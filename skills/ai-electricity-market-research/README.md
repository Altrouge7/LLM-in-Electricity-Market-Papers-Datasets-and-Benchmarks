# ai-electricity-market-research

自动调研「AI × 电力市场」论文 / 数据集 / benchmark 的 skill，服务仓库根目录的
`README.md` 阅读清单。

## 文件

- `SKILL.md` —— 完整方法手册：科学问题分类、多源检索引擎、相关性判定、题录核实、git 协议。
- `run_research.ps1` —— 可执行脚本：多源检索 → 去重 → 追加「待归类」表 → git commit/push。

## 如何手动跑一次

```powershell
pwsh -File F:\projects\EM_LLM_paper\skills\ai-electricity-market-research\run_research.ps1
# 只提交不推送（本地测试）：
pwsh -File ...\run_research.ps1 -NoPush
```

## 如何设置每日定时

### 方式 A：Windows 任务计划（本机常开）

```powershell
schtasks /Create /TN "AI-Market-Research" `
  /TR "pwsh -NoProfile -File F:\projects\EM_LLM_paper\skills\ai-electricity-market-research\run_research.ps1" `
  /SC DAILY /ST 09:00
```

删除：`schtasks /Delete /TN "AI-Market-Research" /F`

注意：push 走 SSH，需本机 `~/.ssh` 已配置 GitHub 密钥且 ssh-agent 可用；计划任务以登录用户身份运行时一般能满足。

### 方式 B：GitHub Actions（无需本地开机）

在仓库加 `.github/workflows/research.yml`：

```yaml
name: daily-research
on:
  schedule:
    - cron: '0 1 * * *'   # UTC 01:00 = 北京时间 09:00
  workflow_dispatch: {}
jobs:
  research:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run research script
        shell: pwsh
        run: pwsh -File ./skills/ai-electricity-market-research/run_research.ps1 -NoPush
      - uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "Auto-research: append candidate papers"
```

（Actions runner 没有本机 SSH key，push 交给 `git-auto-commit-action` 用仓库 token 完成。）

## 注意事项

- 脚本产出的「自动调研：待归类新增」小节**不做摘要相关性过滤和题录核实**，只去重。
  需要人工或 agent 复核后归入科学问题分类，再删除该小节。
- 若当天无新增，脚本会直接退出、不产生空提交。
- 脚本依赖 PowerShell 7（`pwsh`）；Windows PowerShell 5.1 下 JSON 解析不可靠。
