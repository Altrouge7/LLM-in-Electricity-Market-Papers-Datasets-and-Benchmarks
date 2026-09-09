---
name: ai-electricity-market-research
description: >
  Automate literature / dataset / benchmark research for the "AI in electricity
  market" reading list. Use whenever the user asks to collect, expand, verify, or
  prune papers (LLM / DL / RL / time-series / game theory) in electricity
  markets, or to run the scheduled daily research-and-update cycle that appends
  new items to README.md and pushes to GitHub. Covers the multi-source search
  workflow (Google Scholar, arXiv API, Crossref API, OpenAlex, Semantic Scholar),
  the scientific-question taxonomy, relevance filtering by abstract, bibliographic
  verification, and the git commit/push protocol.
version: 2026.9.9
---

# AI in Electricity Market — Research Skill

这是一个可复用的「文献 / 数据集 / benchmark 自动调研」手册，服务仓库根目录的
`README.md`（"AI in electricity market" 阅读清单）。目标是每天（或按需）从多个
学术源检索新论文，经相关性过滤和题录核实后追加到 README，再提交并推送。

## 什么时候用这个 skill

- 用户要求「收集论文 / 扩充分类 / 补充数据集 / 核对题录 / 剔除无关论文」。
- 用户要跑「每天定时调研」：执行 `skills/ai-electricity-market-research/run_research.ps1`
  （或等效的 agent 流程），然后提交推送。
- 任何需要把「AI × 电力市场」文献工作复现跨会话的时刻。

## 仓库约定（先读这些）

- 工作目录 = 仓库根 `F:\projects\EM_LLM_paper`（路径可能变化，以当前 `pwd` 为准）。
- 核心产物 = 根目录 `README.md`。
- 分类不是按方法，而是按**电力市场中的科学问题**（见下）。先讲科学问题，再讲该问题下的研究。
- LLM 论文收 **2024 起**；非 LLM（DL/RL/时序/博弈）收 **2020 起**，早期只保留里程碑（高被引代表作）。
- 纯碳市场（纯碳价预测、纯碳交易——不涉电）**不纳入**；「电—碳耦合」纳入（如 LLM-CECM）。
- 未核实题录统一放 README 的「待核实题录」表，不放正文。

## 科学问题分类法（README 的五问骨架）

| # | 科学问题 | 关键词块 |
| --- | --- | --- |
| 一 | 价格如何形成与预测 | price forecasting, spike, probabilistic, sentiment, news, feature engineering |
| 二 | 参与者如何竞价与决策 | bidding, storage arbitrage, VPP, ancillary/FCAS, LSE, auto-bidding |
| 三 | 市场机制与交易如何设计 | P2P, market design, fairness, mechanism, local energy market, transactive |
| 四 | 市场如何建模、仿真与行为校准 | agent-based modeling, simulation, market power, collusion, behavior calibration |
| 五 | 模型能否理解规则、政策与被评测 | benchmark, evaluation, policy, document understanding, RAG, QA |

> 写作时：每个科学问题先给一段「在研究什么、难点在哪」，再列论文；每条论文给
> 「标题 — 出处/年份 — 链接 — 方法/场景/阅读重点」的结构。

## 检索引擎（多源，按需组合）

优先级与用途：

1. **Google Scholar**（覆盖最全、含被引数）——`https://scholar.google.com/scholar?q=<URL-encoded>&hl=en&as_sdt=0,5&num=<n>`
   用 `Invoke-WebRequest` 抓 HTML，正则解析 `<div class="gs_r gs_or gs_scl">`
   块里的 `h3.gs_rt`（标题）、`div.gs_a`（作者/出处/年份）、`Cited by (\d+)`。
   需带浏览器 UA，否则可能被当机器人。间隔 ≥1.2s。
2. **arXiv API**（预印本全文检索 + 准确摘要）——`http://export.arxiv.org/api/query?search_query=all:<q>&max_results=<n>&sortBy=submittedDate&sortOrder=descending`
   返回 Atom，用 `[xml]` 解析 `//a:entry` 的 title / summary / id。**这是核对摘要最可靠、无限制的源。**
3. **Crossref API**（精确 DOI / venue / year）——`https://api.crossref.org/works?query.bibliographic=<q>&rows=1`
   （`published` 或 `published-print` 的 `date-parts[0][0]` 是年份；`container-title[0]` 是期刊/会议名）。
   注意：`abstract` 字段常为空（Elsevier 一般不填）。
4. **OpenAlex**（覆盖面广，无严格限流）——`https://api.openalex.org/works?filter=title.search:<q>&per-page=n`
   需处理 JSON：PowerShell 5.1 的 `ConvertFrom-Json` 会因 `abstract_inverted_index` 里
   大小写重复键报错，改用 **pwsh 7**（`C:\Program Files\PowerShell\7\pwsh.exe`）的
   `Invoke-RestMethod` 直接取对象。
5. **Semantic Scholar**（abstract + 被引图）——`https://api.semanticscholar.org/graph/v1/paper/<arXiv:ID|DOI:...>?fields=title,abstract,year,venue`
   ⚠️ 无 API key 时限流严重（频繁 429），**不要用作主力**；仅单条补摘要时用，间隔 ≥5s 且重试。

## 完整工作流（一次调研的标准步骤）

1. **扫关键词**：按五个科学问题（+交叉方向）各列一组关键词，跑 Google Scholar 和 arXiv API。
2. **去重**：与 README 里已有序的标题比对，只保留新论文。
3. **判相关（关键质量闸门）**：
   - 标题已明确「electricity price / market / bidding / P2P / energy trading」→ 基本直接相关。
   - 标题泛化（如 "Trading Dynamics"、"Auto-Bidding"、"agency"）→ **必须抓摘要确认**。
   - 摘要提到「advertising market / financial stock market / 一般 ABM 方法论」等 → **剔除或标注相邻领域**。
   - 纯碳市场 → 剔除；电碳耦合 → 保留。
4. **核实题录**：用 Crossref 拿 DOI / 年份 / 会议名（把「IEEE 会议论文」这类中性标注升级为
   精确出处；无法核实的一律降级到「待核实题录」表）。
5. **写入 README**：分到对应科学问题（LLM 项）或「对照：非 LLM 方法」（DL/RL/时序/博弈项），
   或「支撑：数据集/工具」（资源项）。
6. **提交推送**：见下节 git 协议。

## Git 协议（提交 + 推送）

仓库曾被不同 SID 用户标识 owner，git 会报 "dubious ownership"。**必须**用
`-c safe.directory=<repo>` 内联规避（不要改全局 `.gitconfig`）：

```powershell
git -c safe.directory=F:/projects/EM_LLM_paper add README.md
git -c safe.directory=F:/projects/EM_LLM_paper commit -m "<描述本次新增/删除>"
git -c safe.directory=F:/projects/EM_LLM_paper push origin main
```

- push 走 SSH（`git@github.com:...`），需要外网 + 进程管道。在沙箱里直接 push 会因
  `sh.exe` 的 signal-pipe 错误失败；需在 full-access 权限下跑（本环境当前已是 full access）。
- 提交信息要描述「新增哪几篇 / 移除哪些」，不要 `wip`。

## 相关性判定边界的经验（务必遵守）

- 「LLM 在电力市场」的主体是：电价预测、竞价、储能套利、辅助服务、P2P、市场仿真、
  规则政策评测。
- **不纳入**：普通负荷预测、潮流计算、纯调度、普通 Transformer 时序（除非作为对照/基线）。
- **对照锚点**：RL/DL/时序/博弈方法收录的唯一理由是与 LLM 做「增益归因」对照，需标注
  「不含语言」的性质。
- 相邻领域（金融 LLM 市场仿真、一般 ABM）仅在明确标注「相邻领域，方法论参照」时保留，
  或干脆不放。

## 经验教训（来自实际操作，避免重蹈覆辙）

- Google Scholar 在 sandbox 里曾被网络策略拦截；full-access 下可用。Semantic Scholar 免费档限流极严，别批量依赖。
- OpenAI/OpenAlex 的 `abstract_inverted_index` 在 PS 5.1 解析会炸；用 pwsh 7。
- 会议论文的「会议名/年份」靠普通网页搜索拿不到，必须走 Crossref/Semantic Scholar 结构化 API。
- 摘要核对应以 arXiv API 为主；纯 IEEE/Springer 会议论文若无 arXiv 版本，摘要难拿到，此时**降级到待核实表**而非硬猜。

## 配套脚本

`run_research.ps1`（本目录）是这套流程的可执行版本：多源检索 → 去重 → 追加到 README →
git add/commit/push。调度（Windows 任务计划 / GitHub Actions 等）由你自己接，脚本本身
只做「一次调研 + 提交推送」。

- Windows 任务计划示例（每天 09:00）：`schtasks /Create /TN "AI-Market-Research" /TR "pwsh -File F:\projects\EM_LLM_paper\skills\ai-electricity-market-research\run_research.ps1" /SC DAILY /ST 09:00`
- GitHub Actions 示例（无需本地开机）：在仓库加 `.github/workflows/research.yml`，
  用 `cron: '0 1 * * *'` 触发，runner 上跑本脚本。
