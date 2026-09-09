<#
.SYNOPSIS
    AI in electricity market — daily auto-research + README update + git commit/push.

.DESCRIPTION
    Runs the multi-source literature search workflow described in SKILL.md:
      1. Queries arXiv API and Google Scholar for the scientific-question keywords.
      2. Collects candidate (title, year, venue/source, link).
      3. Deduplicates against README.md's existing entries.
      4. Emits new candidates (low-risk: appends them under a dated "auto-discovered
         (to triage)" section at the end of README.md rather than auto-classifying).
      5. git add/commit/push (SSH), using `-c safe.directory` to bypass dubious-ownership.

.NOTES
    Scheduling (Windows Task Scheduler / GitHub Actions) is external; this script does
    one research pass + commit/push. See SKILL.md for the scheduler examples.

    Requires PowerShell 7 (pwsh) for reliable JSON handling. Invoke via:
      pwsh -File F:\projects\EM_LLM_paper\skills\ai-electricity-market-research\run_research.ps1

.PARAMETER RepoPath
    Repo root (defaults to the directory containing this script, two levels up).

.PARAMETER NoPush
    If set, skip git push (useful for local dry runs).
#>
[CmdletBinding()]
param(
    [string]$RepoPath = (Join-Path $PSScriptRoot '..\..'),
    [switch]$NoPush
)

$ErrorActionPreference = 'Stop'
$RepoPath = (Resolve-Path $RepoPath).Path
$Readme = Join-Path $RepoPath 'README.md'
$Pwsh7  = 'C:\Program Files\PowerShell\7\pwsh.exe'

# ---------------------------------------------------------------------------
# 1. Keywords (map to the five scientific questions + cross-cutting)
# ---------------------------------------------------------------------------
$Queries = @(
    "large language model electricity price forecasting",
    "large language model electricity market bidding",
    "reinforcement learning electricity market strategic bidding",
    "large language model peer-to-peer energy trading",
    "large language model electricity market agent-based simulation",
    "large language model energy storage arbitrage bidding",
    "large language model electricity market benchmark evaluation",
    "generative agents electricity market behavior"
)

function Get-ArxivHits {
    param([string]$Query, [int]$Max = 8)
    $enc = [uri]::EscapeDataString($Query)
    $url = "http://export.arxiv.org/api/query?search_query=all:$enc&start=0&max_results=$Max&sortBy=submittedDate&sortOrder=descending"
    try {
        $resp = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 30
    } catch { return @() }
    [xml]$x = $resp.Content
    $ns = New-Object System.Xml.XmlNamespaceManager($x.NameTable)
    $ns.AddNamespace('a','http://www.w3.org/2005/Atom')
    $out = @()
    foreach ($e in $x.SelectNodes('//a:entry', $ns)) {
        $title = ($e.SelectSingleNode('a:title',$ns)).InnerText.Trim()
        $id    = ($e.SelectSingleNode('a:id',$ns)).InnerText
        $pub   = ($e.SelectSingleNode('a:published',$ns)).InnerText
        $year  = if ($pub -match '^(\d{4})') { $Matches[1] } else { '' }
        $out += [pscustomobject]@{ Title=$title; Year=$year; Source='arXiv'; Link=$id }
    }
    return $out
}

function Get-ScholarHits {
    param([string]$Query, [int]$Max = 6)
    $enc = [uri]::EscapeDataString($Query)
    $url = "https://scholar.google.com/scholar?q=$enc&hl=en&as_sdt=0,5&num=$Max"
    try {
        $resp = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 25 -Headers @{
            'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0 Safari/537.36'
        }
    } catch { return @() }
    $html = $resp.Content
    if ($html -match 'unusual traffic|CAPTCHA|not a robot') { return @() }
    $out = @()
    $blocks = [regex]::Matches($html, '<div class="gs_r gs_or gs_scl".*?(?=<div class="gs_r gs_or gs_scl"|</div></div></div></div></div>)', 'Singleline')
    foreach ($b in $blocks) {
        $s = $b.Value
        $title = ''
        $tm = [regex]::Match($s, '<h3 class="gs_rt"[^>]*>(.*?)</h3>', 'Singleline')
        if ($tm.Success) { $title = ($tm.Groups[1].Value -replace '<[^>]+>','' -replace '\s+',' ').Trim() }
        $meta = ''
        $mm = [regex]::Match($s, '<div class="gs_a">(.*?)</div>', 'Singleline')
        if ($mm.Success) { $meta = ($mm.Groups[1].Value -replace '<[^>]+>','' -replace '\s+',' ').Trim() }
        $link = ''
        $lm = [regex]::Match($s, 'href="(https?://[^"]+)"', 'Singleline')
        if ($lm.Success) { $link = $lm.Groups[1].Value }
        $year = ''
        if ($meta -match '\b(19|20)\d{2}\b') { $year = $Matches[0] }
        if ($title) { $out += [pscustomobject]@{ Title=$title; Year=$year; Source="Scholar: $meta"; Link=$link } }
    }
    return $out
}

# ---------------------------------------------------------------------------
# 2. Collect + dedupe against README
# ---------------------------------------------------------------------------
Write-Host "[run_research] repo: $RepoPath"
$existing = (Get-Content $Readme -Raw) -replace '<[^>]+>',' '
$candidates = New-Object System.Collections.Generic.List[object]

foreach ($q in $Queries) {
    Write-Host "[run_research] query: $q"
    $candidates.AddRange((Get-ArxivHits $q 8))
    $candidates.AddRange((Get-ScholarHits $q 6))
    Start-Sleep -Milliseconds 900
}

# dedupe by normalized title prefix (first 40 chars, lowercased, alnum only)
$seen = @{}
$newItems = @()
foreach ($c in $candidates) {
    $key = ($c.Title.ToLowerInvariant() -replace '[^a-z0-9]','')
    if ($key.Length -lt 15) { continue }        # too short / empty
    if ($existing -match [regex]::Escape($c.Title.Substring(0, [Math]::Min(30, $c.Title.Length)))) { continue }
    if ($seen.ContainsKey($key)) { continue }
    $seen[$key] = $true
    $newItems += $c
}

Write-Host "[run_research] new candidates: $($newItems.Count)"
if ($newItems.Count -eq 0) {
    Write-Host "[run_research] nothing new; skipping commit."
    exit 0
}

# ---------------------------------------------------------------------------
# 3. Append under a dated "auto-discovered (to triage)" section
# ---------------------------------------------------------------------------
$today = Get-Date -Format 'yyyy-MM-dd'
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("")
[void]$sb.AppendLine("---")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("## 自动调研：待归类新增（$today）")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("> 本小节由 skills/ai-electricity-market-research/run_research.ps1 自动生成，")
[void]$sb.AppendLine("> 仅做去重，未做摘要相关性过滤与题录核实。请人工/agent 复核后归入上面的科学问题分类，")
[void]$sb.AppendLine("> 并移除本小节。")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("| 年份 | 标题 | 来源 |")
[void]$sb.AppendLine("| --- | --- | --- |")
foreach ($c in $newItems) {
    $t = $c.Title -replace '\|','\'
    $src = $c.Source -replace '\|','\'
    $yr = if ($c.Year) { $c.Year } else { '?' }
    $link = $c.Link
    $cell = if ($link) { "[$t]($link)" } else { $t }
    [void]$sb.AppendLine("| $yr | $cell | $src |")
}
Add-Content -Path $Readme -Value $sb.ToString() -Encoding UTF8
Write-Host "[run_research] appended $($newItems.Count) entries to README.md"

# ---------------------------------------------------------------------------
# 4. git commit + push
# ---------------------------------------------------------------------------
$gitBase = "git -c safe.directory=$RepoPath"
Invoke-Expression "$gitBase add README.md"
$msg = "Auto-research $today : +$($newItems.Count) candidate papers (to triage)"
Invoke-Expression ($gitBase + ' commit -m "' + $msg + '"')
if (-not $NoPush) {
    Invoke-Expression "$gitBase push origin main"
    Write-Host "[run_research] pushed to origin/main"
} else {
    Write-Host "[run_research] NoPush set; committed locally only"
}
