# Electricity-Market LLM papers, datasets and benchmark

> [**English**](README.md) | **简体中文（本页）**

A curated reading list of AI in electricity markets, with large language models (and generative / foundation models) as the primary focus and other AI methods as comparison anchors.

面向 **AI＋电力市场** 的论文与资源清单。以 **LLM（及生成式／基础模型）** 为主体，其它 AI 方法（深度学习、强化学习、时序基础模型、多主体博弈仿真）作为**对照锚点**，用于凸显语言推理带来的增量。按**电力市场中的科学问题**组织：先说明每个问题在研究什么、为什么重要，再介绍该问题下的研究。LLM 论文收录 2024 起；非 LLM 方法收录 2020 起，早期仅保留里程碑。

**更新日期：2026-10-13。当前为持续扩展的文献与资源清单，不是完整系统综述。** 论文结论为作者报告；部分条目基于摘要或公开版本整理，尚未逐篇复现。预印本与正式版本合并记录，待核实题录单列。

本次增量（2026-10-13）：正文新增 TRACE、AlphaCast、CastClaw、E2A-MAS、参与式建模、ChatElet 与 ENTSO-E 角色知识评测共七篇，将四条既有待核实记录移入正文或对照，并新增一条题录已核实但方法仍待核实的候选。同步更新发表／资源信息，纠正年份与方法分类，并从电力市场待核队列移除一条金融交易候选。TRACE 首次提交于 9 月 30 日，角色知识章节首次上线于 10 月 9 日；其余含遗漏补录和发表状态更新，不均为 9 月 16 日以后首次出现的研究。

新增及修订条目的资源可用性核查日期为 2026-10-13；未改动的代码状态沿用此前 2026-09-16 的核查。链接紧随对应论文。“未找到公开实现”表示检索未确认匹配代码，不等于作者未开源。部分代码、仅数据资源、补充材料及代码待发布的项目页分别标注；尚未运行这些实现。

检索范围：覆盖五个科学问题下 2024–2026 年 LLM 文献，并重点检索 2026 年 9 月 16 日至 10 月 13 日的增量；核对 arXiv/API、Crossref、出版社、作者／机构页面和仓库内容。Google Scholar 本次未返回可解析结果，部分出版社页面限制访问；缺少一手方法证据的候选继续待核。本次不是穷尽式系统综述。

## Contents

- [范围与科学问题](#范围与科学问题)
- [问题一：价格如何形成与预测](#问题一价格如何形成与预测)
- [问题二：市场参与者如何竞价与决策](#问题二市场参与者如何竞价与决策)
- [问题三：市场机制与交易如何设计](#问题三市场机制与交易如何设计)
- [问题四：市场如何建模、仿真与行为校准](#问题四市场如何建模仿真与行为校准)
- [问题五：模型能否理解规则、政策与被评测](#问题五模型能否理解规则政策与被评测)
- [支撑：时序基础模型与基线](#支撑时序基础模型与基线)
- [对照：非 LLM 方法](#对照非-llm-方法)
- [支撑：数据集、基准与工具](#支撑数据集基准与工具)
- [待核实题录](#待核实题录)
- [开放的研究空白](#开放的研究空白)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)

## 范围与科学问题

优先收录直接涉及电价、竞价、储能套利、辅助服务、P2P 交易、市场仿真、规则和政策的 LLM 论文。普通负荷预测、潮流计算、纯调度和普通 Transformer 研究不自动纳入；时序基础模型单列，避免将架构相似性等同于语言推理能力。

同时收录**非 LLM 方法**（深度学习预测、单/多主体强化学习竞价、时序基础模型、多主体博弈仿真、生成模型与可解释 ML）作为**对照锚点**——它们回答“没有语言推理时能做到多好”，是判断 LLM 是否真正带来增量、增量来自哪里的基准。非 LLM 方法集中在「对照：非 LLM 方法」一节，按方法类型组织，不以科学问题细分为主。

电力市场的运行可以拆成一条因果链：**价格如何形成 → 参与者如何据此决策 → 机制如何协调这些决策 → 整个系统如何被建模与优化 → 规则与政策如何被理解和评估**。LLM 在这条链上的每一环都有不同角色。据此，本清单按以下五个科学问题组织：

| # | 科学问题 | 研究要点 | LLM 的典型角色 |
| --- | --- | --- | --- |
| 一 | 价格如何形成与预测 | 电价、趋势、尖峰和不确定性的成因与预测 | 新闻/情绪特征提取、报价行为预测、数值推断 |
| 二 | 参与者如何竞价与决策 | 单个市场主体如何形成报价与交易动作 | 策略生成、工具协调、信息记忆、可解释推理 |
| 三 | 市场机制与交易如何设计 | 产消者(P2P)、多主体如何协调利益与公平 | 专家示范、奖励评价、公平性塑造 |
| 四 | 市场如何建模、仿真与行为校准 | 规则与异质行为如何影响市场结果 | 规则转模型、代码生成、行为模拟 |
| 五 | 模型能否理解规则、政策与被评测 | 模型对专业规则/政策的理解与可靠评测 | 领域问答、政策量化、能力基准 |

前四个是市场的“正向”运行问题，第五个是“元”问题（我们如何信任这些模型）。每个问题下，先给一段该问题在做什么、难点在哪里的说明，再列对应论文。

---

## 问题一：价格如何形成与预测

电价是市场运行的核心信号，其难点在于：电价由供需、报价博弈、天气、燃料、突发新闻共同决定，呈现尖峰、尾部风险和强均值回归；文本信息（新闻、市场规则、检修公告）蕴含数值序列之外的因果信息。LLM 在这里把“文本 → 数值/事件”这条过去难以建模的通道打开了。

年份分组尽量按已核实的首次公开年份整理，各条目另保留正式发表年份；仅时序模型及不含 LLM 的生成式方法列于支撑／对照部分。

### 2024

- **Using Generative Pre-Trained Transformers (GPT) for Electricity Price Trend Forecasting in the Spanish Market** — *Energies*, 17(10), 2338, 2024. [Paper](https://www.mdpi.com/1996-1073/17/10/2338) · [代码](https://github.com/AMM-UJI/energy-price-prediction-OpenAI) · [DOI](https://doi.org/10.3390/en17102338)
  - 市场：西班牙；输入为能源新闻与专家报告。
  - 方法：比较上下文示例和 GPT 微调，提取电价趋势信息和附加变量。
  - 阅读重点：文本观点与发布后价格趋势之间的关系；不是直接预测精确电价值。

- **Large Language Model-Based Bidding Behavior Agent and Market Sentiment Agent-Assisted Electricity Price Prediction** — 2024 年公开；*IEEE Transactions on Energy Markets, Policy and Regulation*, 3(2), 223–235, 2025. [DOI](https://doi.org/10.1109/TEMPR.2024.3518624) · [Author version](https://www.researchgate.net/publication/387130812_Large_Language_Model-based_Bidding_Behavior_Agent_and_Market_Sentiment_Agent-Assisted_Electricity_Price_Prediction) · 代码：未找到公开实现。
  - 市场：澳大利亚 NEM，五分钟价格。
  - 方法：微调 LLM 预测报价行为，另用 LLM 提取市场情绪，结合改进的条件时序 GAN（CTSGAN）。
  - 阅读重点：作者报告电价和尖峰预测改善；区分“预测他人报价”与“优化自身报价”。

- **From News to Forecast: Integrating Event Analysis in LLM-Based Time Series Forecasting with Reflection** — NeurIPS, 2024. [Paper](https://arxiv.org/abs/2409.17515) · [代码](https://github.com/daydreamer-amelia/From_News_to_Forecast)
  - 方法：从新闻提取事件并用反思机制辅助 LLM 时序预测；通用时序框架，含能源/电力相关基准。
  - 阅读重点：事件分析对预测增益的归因，以及反思机制是否减少幻觉；作为事件驱动预测方法的通用基线。

### 2025

- **LLM-Enhanced Feature Engineering for Multi-Factor Electricity Price Predictions** — arXiv, 2025. [Paper](https://arxiv.org/abs/2505.11890) · 代码：未找到公开实现。
  - 市场：澳大利亚 NSW。
  - 方法：FAEP 使用 LLM／RAG 增强特征，融合天气、价格跳跃等信息，接入 XGBoost–LSTM。
  - 阅读重点：新增信息、LLM 特征处理和下游模型分别贡献多少增益。

- **NSW-EPNews: A News-Augmented Benchmark for Electricity Price Forecasting with LLMs** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.11050) · 代码：未找到公开实现 · [数据集／实验材料](https://figshare.com/s/2a00cae76712b59f63ea)
  - 数据：NSW 2015–2024 年超过 17.5 万条半小时价格、温度和 WattClarity 新闻；48 步预测。
  - 方法：对比传统模型与利用结构化上下文的 LLM。
  - 结果：新闻对传统模型的增益有限；LLM 改善较小，并出现虚构或格式错误的价格序列。应同时记录正面与负面结果。
  - 资源核查：题名匹配的 Figshare 页面可访问；本次未检查压缩包内容或实现完整性，未确认会议最终录用状态。

- **LLM-Enhanced Short-Term Electricity Price Forecasting Method for Australian Electricity Market** — 2025 年 12 月 24 日在线；*Applied Sciences*, 16(1), 200，2026。[Paper](https://www.mdpi.com/2076-3417/16/1/200) · 代码：未找到公开实现 · [DOI](https://doi.org/10.3390/app16010200)
  - 市场：NSW 五分钟价格；出版社正文描述了覆盖 2024 年的评估，并以个别月份作案例展示。
  - 方法：将 LLM 提取的新闻特征与数值协变量、分位数回归和保形校准结合。
  - 阅读重点：比较结果前需还原实际评估划分，核对正文与图表中的月份和指标描述；不能仅凭案例图判断只评估了一个月。

- **AlphaCast: A Human Wisdom-LLM Intelligence Co-Reasoning Framework for Interactive Time Series Forecasting** — arXiv，2025 年 11 月 12 日首次提交；v5 更新于 2026 年 4 月 10 日。[Paper](https://arxiv.org/abs/2511.08947) · [代码](https://github.com/ustc-time-series/AlphaCast)
  - 方法：无需训练的 LLM 智能体完成上下文准备、预测生成与反思修正，并调用特征、知识、案例和上下文工具。
  - 市场与阅读重点：包含比利时、德国、法国、Nord Pool 与 PJM 的小时级日前电价；需区分 LLM 推理、辅助预测器和新增信息各自的贡献。

- **Electricity Market Price Forecast via LLM-based Sentiment Analysis and TimeXer** — 2025 7th International Conference on Data-driven Optimization of Complex Systems (DOCS), 2025. [DOI](https://doi.org/10.1109/DOCS67533.2025.11200590) · 代码：未找到公开实现。
  - 方法：LLM 提取市场情绪作为特征，结合 TimeXer 时序模型进行电价预测。
  - 阅读重点：LLM 情绪特征相对传统文本特征的信息增益；与“报价行为与情绪预测”一条的对照组设计。

- **Adaptive Frequency-Domain Feature Extraction With Large Language Models for Accurate Electricity Market Forecasting** — *IEEE Transactions on Consumer Electronics*, 2025. [DOI](https://doi.org/10.1109/TCE.2025.3585889) · 代码：未找到公开实现。
  - 方法：LLM 辅助自适应频域特征提取，用于电价/市场预测。
  - 阅读重点：频域分解与 LLM 的作用边界；是否真正引入语言推理，还是作为特征选择器。

- **Application of Large Language Models in Intelligent Preprocessing and Forecasting of Electricity Price** — 2025 4th International Conference on Smart Grid and Green Energy (ICSGGE), 2025. [DOI](https://doi.org/10.1109/ICSGGE64667.2025.10984532) · 代码：未找到公开实现。
  - 方法：LLM 用于电价数据的智能预处理与预测。
  - 阅读重点：预处理（清洗/补齐/特征）环节与预测环节各自的增益；数据质量差时 LLM 的鲁棒性。

### 2026

- **A Few-Shot LLM Framework for Extreme Day Classification in Electricity Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2602.16735) · 代码：未找到公开实现。
  - 市场：美国得州。
  - 方法：将负荷、可再生能源、天气和近期价格统计量转成提示，判断次日是否出现价格尖峰。
  - 结果：作者报告少样本条件下可超过 SVM、XGBoost；任务是极端日分类，不是完整价格轨迹预测。

- **Reasoning-enhanced probabilistic electricity price forecasting using parameter-efficient large language models** — *Applied Energy*, 2026. [DOI](https://doi.org/10.1016/j.apenergy.2026.128712) · 代码：未找到公开实现。
  - 方法：用参数高效（PEFT）LLM 增强推理，做概率电价预测。
  - 阅读重点：推理增强 vs 纯数值基线的概率校准；参数高效微调带来的成本—增益权衡。

- **RIS-LLM: Reasoning-informed semantic modeling of electricity market price dynamics** — *Advanced Engineering Informatics*, 2026. [DOI](https://doi.org/10.1016/j.aei.2026.104949) · 代码：未找到公开实现。
  - 方法：将推理信息融入电价动态的语义建模。
  - 阅读重点：推理增强相对纯特征/纯数值的增量；语义建模的泛化边界。

- **LLM Agent-Driven Dynamic Prediction for Day-Ahead Electricity Prices** — 2026 IEEE 2nd International Conference on Electronics, Energy Systems and Power Engineering (EESPE), 2026. [DOI](https://doi.org/10.1109/EESPE68405.2026.11648328) · 代码：未找到公开实现。
  - 方法：LLM 智能体驱动的日前电价动态预测。
  - 阅读重点：LLM 作为“预测智能体”而非特征器的定位差异。

- **A large language model-based reprogramming method for electricity price spread prediction** — *Journal of Renewable and Sustainable Energy*, 2026（7 月 21 日在线发表）. [DOI](https://doi.org/10.1063/5.0336800) · 代码：未找到公开实现。
  - 方法：用 LLM 重编程（reprogramming）做电价价差预测。
  - 阅读重点：价差（而非电价水平）预测的套利导向；reprogramming 的迁移能力。

- **TRACE: A Reproducible Benchmark for Electricity Price Forecasting with Official Operational Text** — arXiv，2026 年 9 月 30 日首次提交。作者注明已被 NeurIPS 2026 的 Foundation Models for Time Series 工作坊接收。[Paper](https://arxiv.org/abs/2610.02256) · 代码／数据：未定位到公开发布资源。
  - 基准：将 PJM 五个分区的电价与预测截止时点可获得的官方运行文本配对，形成 7,300 个分区—日样本。
  - 阅读重点：文本可用时间、取消状态与适用区间，以及等信息数值对照。作者报告的文本增益主要集中在电价上尾风险，跨日错配文本会使增益反转。

- **A Human-in-the-Loop Autonomous Agent for Industry Time Series Forecasting** — arXiv，2026 年 8 月 31 日（CastClaw）。[Paper](https://arxiv.org/abs/2608.30976) · [代码](https://github.com/ustc-time-series/CastClaw) · [项目](https://ustc-time-series.github.io/cast-claw/)
  - 方法：协调专用预测模型、分析工具、人类约束和版本化证据，对预测进行检查、保留或修正；评测包含五个电价数据集。
  - 阅读重点：作者报告了相对 16 个基线较好的 MSE/MAE 点估计，但重复试验显著性和组件归因尚待验证；应检查验证门槛、被拒绝的修正、停止规则及工具／模型预算公平性。

- **An on-premises end-to-end automated forecasting multi-agent system for the energy domain** — *Engineering Applications of Artificial Intelligence*, 181, Part 7, 115728，2026 年 10 月。[Paper](https://doi.org/10.1016/j.engappai.2026.115728) · [项目页（代码待发布）](https://github.com/ZihangQiu/E2A-MAS)
  - 方法：E2A-MAS 协调特征工程、预处理、模型选择和超参数调整；能源领域实验包含比利时 ods134 电价数据集。
  - 阅读重点：区分电价预测精度与工作流成功率，并比较训练预算。2026-10-13 核查时，所链接仓库仅有承诺发布代码的 README，未提供公开实现。

---

## 问题二：市场参与者如何竞价与决策

价格预测只是输入，真正的价值在于**决策**：储能何时充放电、发电企业如何报价、辅助服务如何投标。难点在于交易动作要满足市场规则、物理约束和经济目标的三重耦合，且市场反馈延迟。LLM 在这里充当“策略大脑”或“协调器”，把规则文本、状态和反馈组织成可执行动作。

- **LLM-coordination in auto-bidding of frequency regulation: Cross-attention distributional reinforcement agentic learning** — *Applied Energy*, 401, 126702, 2025. [Paper](https://doi.org/10.1016/j.apenergy.2025.126702) · 代码：未找到公开实现。
  - 市场：南澳能量与频率控制辅助服务（FCAS）联合市场，电池储能竞价。
  - 方法：LLM 协调智能体、理解指令和解释反馈；交叉注意力提取市场特征，基于 SAC 的分布强化学习优化策略。
  - 结果：作者报告收益优于预测后优化与其他 DRL 基线；需要分别检验 LLM 和强化学习模块贡献。

- **LLM-Enhanced Trading Decision Framework with Multi-Scale Memory for Electricity Markets** — IEEE SmartGridComm, 2025. [DOI](https://doi.org/10.1109/SmartGridComm65349.2025.11204628) · [Institutional record](https://research.monash.edu/en/publications/llm-enhanced-trading-decision-framework-with-multi-scale-memory-f/) · 代码：未找到公开实现。
  - 市场：澳大利亚电力市场。
  - 方法：短期、中期、长期和反思记忆，处理新闻的语义相关性与延迟影响。
  - 阅读重点：信息时效、记忆更新，以及文本信号如何影响交易决策。

- **Large Language Model Assisted Optimal Bidding of BESS in FCAS Market: An AI-agent based Approach** — arXiv, 2024. [Paper](https://arxiv.org/abs/2406.00974) · 代码：未找到公开实现。
  - 市场：澳大利亚 NEM 频率控制辅助服务（FCAS）市场，电池储能（BESS）竞价。
  - 方法：LLM 智能体解析市场规则与指令并生成竞价动作，结合优化与强化学习。
  - 阅读重点：LLM 对规则/状态的语义理解与下游竞价模块的贡献分解，以及跨市场迁移能力。

- **An Explainable Cognitive Bidding Agent for Electricity Markets: A Framework for Zero-Shot Generalization using Large Language Models** — 2025 IEEE 9th Conference on Energy Internet and Energy System Integration (EI²), 2025. [DOI](https://doi.org/10.1109/EI268505.2025.11425567) · 代码：未找到公开实现。
  - 场景：电力市场竞价智能体的零样本泛化，强调可解释性与认知决策过程。
  - 方法：以 LLM 为竞价决策核心，给出可解释的策略推理，检验未训练市场下的泛化。
  - 阅读重点：零样本跨市场泛化的真实边界；可解释性是否为事后包装而非策略来源。

- **Dual-agent LLMs with genetic evolution for automated bidding strategy optimization in electricity markets** — IET Conference Proceedings, 2026. [DOI](https://doi.org/10.1049/icp.2026.1716) · 代码：未找到公开实现。
  - 场景：电力市场自动竞价策略优化。
  - 方法：双智能体 LLM 结合遗传演化，迭代生成与选择竞价策略。
  - 阅读重点：遗传演化的选择压力是否由真实市场反馈驱动；策略优化的收敛性与过拟合风险。

- **A Semantic Risk-Aware Optimization Framework for Virtual Power Plant Dispatch Using Large Language Models** — *Energies*, 19(12), 2820，2026 年 6 月 12 日。[Paper](https://www.mdpi.com/1996-1073/19/12/2820) · 代码：未找到公开实现 · [DOI](https://doi.org/10.3390/en19122820)
  - 方法：RAG-VPP 将市场公告和预警转为语义风险信号，用于场景生成、备用约束和随机 MIQP 调度；LLM 为优化器提供输入。
  - 市场与证据：采用七天 ERCOT 风格压力测试、合成 ISO 风格预警和五分钟市场粒度。利润与风险改善属于受控仿真结果，并非历史 ERCOT 危机复现或实际交易验证。

- **Large Language Model Based Data Augmentation for Peak Electricity Price Forecasting and Battery Energy Storage Arbitrage** — *2025 IEEE International Conference on Systems, Man, and Cybernetics (SMC)*，7762–7767，2025。[Paper](https://doi.org/10.1109/SMC58881.2025.11342789) · 代码：未找到公开实现 · [作者机构摘要](https://scholars.cityu.edu.hk/en/publications/large-language-model-based-data-augmentation-for-peak-electricity/)
  - 方法：通过包含领域知识与物理约束的提示，让 LLM 生成稀有尖峰电价样本，再以增强数据支持 Monte Carlo dropout 概率预测及储能套利的场景随机优化。
  - 阅读重点：合成极端事件是否改善预测校准及套利收益。题录和机构摘要已核实，全文数据划分、详细基线及可复现性仍未核实。

---

## 问题三：市场机制与交易如何设计

当市场从集中式走向去中心化（P2P、社区交易、产消者），问题就不再只是“单个主体最优”，而是**机制如何让自利的分布式参与者协调出好的整体结果**——既有效率又有公平。难点是如何在信息不对称、异质偏好和物理网络约束下设计激励，并让智能体在机制内“学会”合作或公平。LLM 在这里常作“示范者”“critic”或“公平性评价者”。

- **LLM-Enhanced Multi-Agent Reinforcement Learning with Expert Workflow for Real-Time P2P Energy Trading** — 2025 预印本；*IEEE Transactions on Smart Grid*, Early Access, 2026. [Paper](https://arxiv.org/abs/2507.14995) · [补充材料](https://github.com/jzk0806/P2P-llm-supplementary) · [DOI](https://doi.org/10.1109/TSG.2026.3684885)
  - 场景：考虑配电网约束的实时 P2P 交易。
  - 方法：LLM 生成个性化专家策略，通过模仿指导多智能体强化学习，并使用差分注意力 critic。
  - 结果：作者报告交易成本和电压越限率下降。仓库链接为补充材料，不代表完整可复现实现。

- **Scalable Fairness Shaping with LLM-Guided Multi-Agent Reinforcement Learning for Peer-to-Peer Electricity Markets** — 2025 年预印本；*Utilities Policy*, 100, 102168，2026 年 6 月。[Paper](https://arxiv.org/abs/2508.18610) · [部分代码／玩具演示](https://github.com/SHRENIK000/fairmarket-rl-llm-fairness-energy-markets) · [DOI](https://doi.org/10.1016/j.jup.2026.102168)
  - 方法：LLM 评价器在每轮拍卖后评估电网依赖、卖方公平与定价公平，并将评分加入连续双向拍卖中的 MARL 奖励。
  - 阅读重点：公平与收益的权衡及向更大社区迁移的证据。公开仓库提供接口和玩具环境，训练、完整市场仿真器及 LLM 评价器仍未公开。

- **Large Language Model Assisted Peer-to-Peer Energy Trading System** — *Journal of Energy Engineering*, 152(4), 2026. [Paper](https://ascelibrary.org/doi/abs/10.1061/JLEED9.EYENG-6440) · 代码／模型：需向作者申请（论文声明）。
  - 场景：供需比定价的家庭 P2P 交易。
  - 方法：两阶段提示、多轮负荷预测与数值后处理，连接到负荷调度。
  - 阅读重点：预测误差如何传递到交易结果；部分数据与实现需申请获取。

- **FairMarket-RL: LLM-Guided Fairness Shaping for Multi-Agent Reinforcement Learning in Peer-to-Peer Markets** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.22708) · [部分代码／演示](https://github.com/SHRENIK000/fairmarket-rl-llm-fairness-energy-markets) — 核心训练、市场仿真与 LLM 评价器未公开。
  - 场景：P2P 市场的多智能体强化学习，LLM 引导公平性塑造。
  - 方法：LLM 评价交易公平性并塑造多智能体强化学习奖励。
  - 阅读重点：与同组“Scalable Fairness Shaping”的关系与区别；公平性塑造的扩展性与评价稳定性。

- **Equity-Aware Peer-to-Peer Energy Trading Market to Mitigate Energy Poverty: An LLM–RL Agentic Workflow** — *IEEE Transactions on Energy Markets, Policy and Regulation*, 2026. [DOI](https://doi.org/10.1109/TEMPR.2025.3633992) · 代码：未找到公开实现。
  - 场景：面向缓解能源贫困的权益（equity）感知 P2P 能源交易。
  - 方法：LLM 与强化学习结合的智能体工作流，在交易决策中显式纳入公平/权益目标。
  - 阅读重点：公平目标与经济激励的权衡，以及“缓解能源贫困”这一社会目标的可量化验证。

- **Grounded, Compute-Efficient LLM Policy Agents for Energy-Poverty Equity in Physically-Constrained Peer-to-Peer Energy Markets** — Kunal Jadhav、Siddhesh More；arXiv，2026 年 9 月 1 日。作者注明已被 EMNLP 2026 的 NLP4PI 工作坊接收。[Paper](https://arxiv.org/abs/2609.01918) · 代码：作者承诺发布，本次未找到公开实现。
  - 场景：EqGrid 在 IEEE 33 节点配电网上，通过连续双向拍卖仿真家庭 P2P 能源交易。
  - 方法：低频 LLM 设定价格／碳约束及定向补贴，高频 MARL 交易者竞价，独立的校验与投影模块执行电网约束。
  - 阅读重点：能源负担公平性与交易成本的权衡，以及策略模型压缩与估计推理能耗的关系。依据公开摘要整理，证据来自仿真而非实际部署；摘要承诺发布代码与配置，本次未核实其已公开。

- **Large Language Models as Strategic Bidding Agents in P2P Energy Trading Markets** — arXiv，2026；作者注明已被 IEEE IECON 2026 接收。[Paper](https://arxiv.org/abs/2609.05462) · [代码](https://github.com/ismail0T/Strategic_Bidding_P2P_Energy_Trading)
  - 方法：LLM 代理直接在重复 P2P 双向拍卖中选择报价，实验对照为随机竞价和 epsilon-greedy 多臂老虎机。
  - 阅读重点：初期成交量优势、市场变化后的适应性，以及剩余分配逐渐偏向卖方的现象；这些实验不能支持优于一般 MARL 方法的结论。
  - 代码范围：已实现竞价、LLM 调用和出清，但仓库默认配置与论文实验配置存在差异，本清单未复现结果。

- **Integrating large language models into Peer-to-Peer energy management for multi-tenant buildings: A guardrail approach to ensuring resilience** — *Neural Networks*, 2026. [Paper](https://doi.org/10.1016/j.neunet.2026.108814) · 代码：未找到公开实现。
  - 场景：多租户建筑内的 P2P 能源管理，强调护栏（guardrail）与韧性。
  - 方法：将 LLM 嵌入 P2P 能源管理，用约束/护栏机制保证系统在异常下的韧性。
  - 阅读重点：护栏机制对 LLM 错误输出的约束效果；韧性如何量化。

- **Draining the Energy Commons: Self-Defeating Over-Appropriation as a Coordination Failure in Agentic LLM Collectives** — arXiv, 2026. [Paper](https://arxiv.org/abs/2607.22188) · 代码：未找到公开实现。
  - 场景：共享可再生能源公地（commons）中 LLM 产消者集体的协调失败。
  - 方法：同族 GPT/Gemini/Grok 智能体以产消者身份最大化自身目标，观察对共享资源的过度占用。
  - 阅读重点：LLM 集体决策的公地悲剧；与 P2P 公平性机制如何互补。

- **Interactive learning-implementation of ChatGPT and reinforcement learning in local energy trading** — 2024 IEEE 34th Australasian Universities Power Engineering Conference (AUPEC), 2024. [DOI](https://doi.org/10.1109/AUPEC62273.2024.10807616) · 代码：未找到公开实现。
  - 场景：ChatGPT 与 RL 交互式学习在本地能源交易中的应用。
  - 方法：将对话式 LLM 与 RL 结合实现本地产消者交易决策。
  - 阅读重点：LLM 与 RL 的交互式学习分工；对话指导是否真正改善策略。

- **An explainable equity-aware P2P energy trading framework for socio-economically diverse microgrid** — arXiv, 2025. [Paper](https://arxiv.org/abs/2507.18738) · 代码：未找到公开实现。
  - 场景：面向社会经济异质微网的可解释权益（equity）感知 P2P 交易框架。
  - 方法：在 P2P 交易中显式建模并解释公平/权益，处理参与者异质性。
  - 阅读重点：公平指标的可解释性；与 Equity-Aware P2P 一条的定位差异。

---

## 问题四：市场如何建模、仿真与行为校准

即便有了单个主体的决策模型，我们仍需要理解**整个市场的涌现行为**：规则调整后价格会怎样、异质参与者如何互相作用、报价行为是否与现实吻合。难点在于市场模型要同时可信(calibrated)且可执行。LLM 在这里把“规则文档→数学模型→可执行仿真”这条链路自动化，并作为生成式参与者模拟研究行为偏差。

- **Leveraging Large Language Model Based Agent for Automated Electricity Market Modelling and Simulation** — *Journal of Modern Power Systems and Clean Energy*, 14(1), 50–62, 2026. [Paper](https://doi.org/10.35833/MPCE.2025.000639) · 代码：未找到公开实现。
  - 方法：MSS-Agent 从规则文档提取模型，通过分层思维链、工具调用和反思调试生成仿真代码。
  - 阅读重点：“规则文档→数学模型→可执行仿真”的准确性、代码可靠性和建模效率。

- **Behavioral Generative Agents for Power Dispatch and Auction** — arXiv, 2026. [Paper](https://arxiv.org/abs/2603.08477) · 代码：未找到公开实现。
  - 场景：家庭电池管理与电网接入权拍卖。
  - 方法：利用上下文学习塑造规则式、短视或战略性行为，对照动态规划和竞价基准。
  - 结果：概念验证展示理性策略及系统性行为偏差；不等同于经过真实参与者行为校准的市场模拟器。

- **A Generative AI Agent-Based Simulation for Electricity Market and Load Forecasting Game Strategy** — Proceedings of the 2025 International Conference on Digital Society and Intelligent Computing, 2025. [DOI](https://doi.org/10.1145/3788910.3788914) · 代码：未找到公开实现。
  - 场景：电力市场与负荷预测博弈策略的多智能体仿真。
  - 方法：生成式 AI 智能体参与市场与预测博弈，研究策略交互对市场结果的影响。
  - 阅读重点：智能体行为是否经真实参与者校准；博弈设定与真实市场机制的对应程度。

- **LLM-Augmented Multi-Agent System for Trading Behavior Modeling in Coupled Electricity-Carbon Markets** — *Journal of Modern Power Systems and Clean Energy*, 2026. [DOI](https://doi.org/10.35833/MPCE.2025.000645) · 代码：未找到公开实现。
  - 场景：电—碳耦合市场中的交易行为建模与策略形成。
  - 方法：LLM 增强多智能体系统，以受限理性学习更新信念并迭代调整交易预期与策略。
  - 阅读重点：与“LLM-CECM”的异同；耦合市场下报价行为是否经实证校准。

- **Behavioral Generative Agents for Energy Operations** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.12664) · 代码：未找到公开实现。
  - 场景：能源运营中的消费者/参与者行为建模，含低频高影响事件下的行为异质性。
  - 方法：用生成式智能体补充/替代传统行为模型，研究其在运营决策中的价值与局限。
  - 阅读重点：生成式智能体对真实参与者的行为校准程度；与“Power Dispatch and Auction”一条同组、但更偏运营侧。

- **Large language models empowered agent-based modeling and simulation: A survey and perspectives** — *Humanities and Social Sciences Communications*, 2024. [DOI](https://doi.org/10.1057/s41599-024-03611-3) · [综述资源（非实现代码）](https://github.com/tsinghua-fib-lab/LLM-Agent-Based-Modeling-and-Simulation)
  - 方法：LLM 赋能的 ABM 仿真综述（被引约 550）；是“LLM+ABM”这一方法范式的总入口。
  - 阅读重点：作为本问题（Q4）的方法论背景综述；能源市场是其中一类应用场景。

- **Simulating financial market via large language model based agents** — arXiv, 2024. [Paper](https://arxiv.org/abs/2406.19966) · 代码：未找到公开实现。
  - ⚠️ 相邻领域（股票金融市场，非电力市场）；仅作 LLM 市场仿真的方法论参照。
  - 方法：用 LLM 智能体仿真股票市场（被引约 51）。
  - 阅读重点：相邻领域（金融）的 LLM 市场仿真能否迁移到电力市场。

- **Generative AI-assisted Participatory Modeling in Socio-Environmental Planning under Deep Uncertainty** — arXiv，2026 年 3 月 17 日首次提交；v2 为 3 月 19 日。[Paper](https://arxiv.org/abs/2603.17021) · [代码与补充材料](https://github.com/Hardy-Pei01/LLM-for-DMDU)
  - 方法与市场：通过模板化人机交互，将利益相关者的描述转为形式模型和 Python 实现，其中包含五家发电商的日前电力市场与风电收益评估案例。
  - 阅读重点：这是需要人工验证和修正的建模概念验证，尚非经过真实参与者行为校准的市场仿真器；仓库包含市场案例脚本与会话记录。

- **LLM-CECM: A simulation framework for strategic generation behavior in coupled electricity-carbon markets** — *Renewable Energy*, 273, 126139，2026 年（10 月刊）；作者预印本于 2026 年 4 月 24 日发布。[Paper](https://doi.org/10.1016/j.renene.2026.126139) · 代码：未找到公开实现 · [作者版本](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6643509)
  - 方法：LLM 智能体以人设、记忆和信念模块生成电—碳订单，结合自适应推理频率和固定深度反事实推理；碳出清结果在网络调度前反馈至电力报价。
  - 阅读重点：实验将澳大利亚市场输入与 IEEE 118 节点测试系统结合；效率与价格路径结果属于仿真证据，不能解释为均衡证明或真实交易者行为校准。

---

## 问题五：模型能否理解规则、政策与被评测

这是“元”问题：在我们把 LLM 用于交易之前，先要问它是否真正理解市场规则、能否量化政策、以及我们如何可信地评测它。难点在于专业知识的评测难、且“答对题”不等于“在真实市场赚到钱”。LLM 在这里是“被评测对象”。

- **ELM-Bench: A Multidimensional Methodological Framework for Large Language Model Evaluation in Electricity Markets** — *Energies*, 18(15), 3982, 2025. [Paper](https://www.mdpi.com/1996-1073/18/15/3982) · 代码：未找到公开实现。
  - 场景：中国电力市场，理解、生成、安全三个维度，7 类任务、2841 个样本。
  - 方法：比较通用模型与领域微调模型 QwenGOLD。
  - 阅读重点：专业能力与微调收益；问答及决策任务得分不等于实际交易收益。

- **基于大语言模型与可解释机器学习的中国大陆电力政策量化框架与效力研究** — 2026. [Journal article](https://skjournal.upc.edu.cn/article/html/20260102) · 代码：未找到公开实现。
  - 方法：提示工程、微调模型、主题分析与可解释机器学习，量化政策文本及其效力。
  - 阅读重点：“政策文本→政策变量→实证分析”；更偏政策经济研究，而非实时交易。

- **Engineering Trustworthy Retrieval-Augmented Generation for EU Electricity Market Regulation** — *Electronics*, 15(4), 749, 2026. [Paper](https://www.mdpi.com/2079-9292/15/4/749) · 代码：未找到公开实现。
  - 场景：面向欧盟电力市场法规的可信检索增强生成（RAG）。
  - 方法：构建 RAG 系统以回答法规文本，关注可信性与引用可靠性。
  - 阅读重点：法规问答的准确性与幻觉风险；能否支撑规则变更后的决策迁移问题。

- **ElectriQ: A Benchmark for Assessing the Response Capability of Large Language Models in Power Marketing** — arXiv, 2025. [Paper](https://arxiv.org/abs/2507.22911) · [代码与数据](https://github.com/Jinzhi-Wang/ElectriQ)
  - 场景：电力营销（EPM）场景下的 LLM 响应能力评测，覆盖跨场景长对话与政策/规则知识。
  - 方法：构建电力营销专属问答/对话评测集，检验 LLM 对规则、电价与客户咨询的应对。
  - 阅读重点：与 ELM-Bench 的定位差异；营销场景评测是否触及真实交易决策。

- **How Do Tool-Augmented LLM Agents Perform on Real-World Energy Analytics Tasks?** — arXiv, 2026. [Paper](https://arxiv.org/abs/2606.26346) · [代码](https://github.com/Tume-AI/energy-evals)
  - 场景：能源领域的实时数据检索、法规与市场知识、多步定量推理评测。
  - 方法：实证评测工具增强 LLM 智能体在真实能源分析任务上的表现，弥补“静态知识问答”之外的空白。
  - 阅读重点：工具调用、实时数据与多步推理的可靠性；与 EnergyAgentBench 的互补关系。

- **ElecBench: A Power Dispatch Evaluation Benchmark for Large Language Models** — arXiv, 2024. [Paper](https://arxiv.org/abs/2407.05365) · [题库数据（无实现代码）](https://github.com/xiyuan-zhou/ElecBench-a-Power-Dispatch-Evaluation-Benchmark-for-Large-Language-Models)
  - 场景：电力调度（含市场动态）场景下的 LLM 评测。
  - 方法：构建面向调度决策的评测基准，检验 LLM 的指令遵循与专业决策能力。
  - 阅读重点：偏调度而非纯市场交易，可作为“规则理解能力”的补充证据而非交易收益证据。

- **A Benchmark for Document Understanding of Large Language Models in the Field of Electric Power** — Springer（International Symposium on Artificial Intelligence）, 2025. · 代码：题录待核实。
  - 方法：面向电力领域文档理解的 LLM 基准。
  - 阅读重点：文档理解能力是否覆盖市场规则/结算单等专业文本。

- **WeQA: A benchmark for retrieval augmented generation in wind energy domain** — Workshop on NLP for Positive Impact (NLP4PI), 2025. [DOI](https://doi.org/10.18653/v1/2025.nlp4pi-1.20) · 代码：未找到公开实现。
  - 方法：风能领域 RAG 评测基准；能源领域 RAG 评测的参考（非纯电力市场）。
  - 阅读重点：能源 RAG 的引用可靠性评测范式，可迁移到市场法规 RAG。

- **Closed-Book Probing of Electricity-Market Role Knowledge in Language Models: The ENTSO-E Harmonised Role Model** — *Energy Informatics*，EI.A 2026，LNCS 16981，339–358；2026 年 10 月 9 日首次上线，论文集题录年份为 2027。[Paper](https://link.springer.com/chapter/10.1007/978-3-032-41864-7_22) · 代码：未找到公开实现 · [DOI](https://doi.org/10.1007/978-3-032-41864-7_22)
  - 基准：将电力市场角色与关系的闭卷识别、自由回忆分开测试，采用程序评分；评测九个开放权重模型及三个前沿模型。
  - 阅读重点：识别给定角色比凭记忆重建角色关系更可靠，应区分术语识别能力与可用于决策的市场结构知识。

- **检索增强生成融合政策动态演化机制的电力市场智能问答系统** — 《计算机应用》，2026 年 5 月 29 日网络首发（ChatElet）。[期刊题录与摘要](https://www.joca.cn/EN/abstract/abstract37949.shtml) · 代码：未找到公开实现 · [DOI](https://doi.org/10.11772/j.issn.1001-9081.2026010113)
  - 方法：将政策本体与动态知识图谱结合，通过多路径检索、语义重排序和幻觉校验回答电力市场政策问题。
  - 阅读重点：评测包含 500 条单轮问答与 452 轮连续追问，关注政策版本、时效适用性及冲突处理；出版社已提供网络首发题录与摘要，本次未确认卷期页码或公开评测资源。

---

## 支撑：时序基础模型与基线

以下工作用于基线和评测设计，不能全部作为“语言推理增强交易”的证据。它们回答“没有语言时能做到多好”，是判断 LLM 是否真正带来增益的对照锚点。

- **Energy Price Modelling: A Comparative Evaluation of four Generations of Forecasting Methods** — arXiv, 2024. [Paper](https://arxiv.org/abs/2411.03372) · [代码](https://github.com/QuantLet/AI4EFin)
  - 欧洲能源市场上的预测方法比较；用于建立计量、机器学习、序列模型与 Transformer 基线。
- **Benchmarking Pre-Trained Time Series Models for Electricity Price Forecasting** — *2025 21st International Conference on the European Energy Market (EEM)*，2025。[Paper](https://arxiv.org/abs/2506.08113) · 代码：未找到公开实现 · [DOI](https://doi.org/10.1109/EEM64765.2025.11050326)
  - 欧洲五国 2024 年日前价格；比较 Chronos、TimesFM、Moirai 等时序基础模型。
  - 作者报告没有时序基础模型在统计意义上超过其双季节 MSTL 基线。
- **Forecasting Day-Ahead Residential Electricity Prices Using a Large Language Model** — SSRN working paper, 2025. [Paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5158359) · 代码：未找到公开实现。
  - 实际使用 Chronos，在伦敦居民电价实验中超过 ARIMA、Gaussian Processes，但微调存在跨片段泛化问题。
- **PriceFM: Foundation Model for Probabilistic Electricity Price Forecasting** — arXiv, 2025. [Paper](https://arxiv.org/abs/2508.04875) · [代码](https://github.com/runyao-yu/PriceFM)
  - 面向概率电价预测的时序基础模型；用于建立强概率预测基线，与语言推理增强方法对照。
- **Foundation models for electricity price forecasting and battery arbitrage: Can they replace market-specific forecasting models?** — arXiv, 2026. [Paper](https://arxiv.org/abs/2609.00089) · 代码：未找到公开实现。
  - 检验时序基础模型能否替代市场专用预测模型，并评估其在电池套利中的经济价值。
  - 直接对应“预测到收益”研究问题；区分统计精度与套利收益。
- **A systematic review of transformers and large language models in the energy sector: towards agentic digital twins** — *Applied Energy*, 2025. [Paper](https://doi.org/10.1016/j.apenergy.2025.126670) · 代码：未找到公开实现。
  - 能源领域 Transformer 与 LLM 系统综述，涵盖市场与智能体方向；用于建立领域全景与入口。

- **Regression Models Meet Foundation Models: A Hybrid-AI Approach to Practical Electricity Price Forecasting** — arXiv, 2026. [Paper](https://arxiv.org/abs/2603.06726) · [代码](https://github.com/thulab/FutureBoosting)
  - 方法：回归模型与时序基础模型混合，面向实际电价预测。
  - 阅读重点：混合架构相对纯基础模型的增益来源；与纯时序基线（MSTL、Chronos 等）的对照。

- **Assessing time series foundation models for probabilistic electricity price forecasting: Toward a unified benchmark** — *Energies*, 2025. [DOI](https://doi.org/10.3390/en18236269) · [代码](https://github.com/MarchesiGabriele/PEPF_bench)
  - 方法：统一基准评估时序基础模型的概率电价预测。
  - 阅读重点：与“Benchmarking Pre-Trained Time Series Models”一条互补；概率预测评估的统一口径。

### LLM 在能源/电力领域的综述（全景入口）

- **Exploring the capabilities and limitations of large language models in the electric energy sector** — *Joule*, 2024. [DOI](https://doi.org/10.1016/j.joule.2024.05.009) · 代码：未找到公开实现。
  - 系统刻画 LLM 在电力能源领域的能力与局限（被引约 202）；是理解“LLM 到底能/不能做什么”的必读入口。
- **Review of LLMs applications in electrical power & energy systems** — *IEEE Access*, 2025. [DOI](https://doi.org/10.1109/ACCESS.2025.3599922) · 代码：未找到公开实现。
  - 电力与能源系统中 LLM 应用综述（被引约 25）。
- **A comprehensive review on the application of large language models in power systems** — *IEEE Access*, 2025. [DOI](https://doi.org/10.1109/ACCESS.2025.3637226) · 代码：未找到公开实现。
  - 电力系统 LLM 应用综合综述。
- **Opportunities of applying Large Language Models in building energy sector** — *Renewable and Sustainable Energy Reviews*, 2025. [DOI](https://doi.org/10.1016/j.rser.2025.115558) · 代码：未找到公开实现。
  - 建筑能源领域 LLM 机会（被引约 68）；偏建筑，但提供相邻领域迁移视角。

---

## 对照：非 LLM 方法

以下工作不使用（或不以）语言模型为核心，而是以深度学习、强化学习、时序基础模型或博弈/多主体仿真等方法解决电力市场问题。它们作为 LLM 研究的**对照锚点**：判断 LLM 的增益是来自“语言/语义理解”，还是来自更成熟的数值方法早已能做好的部分。2020 后为主，早期仅保留里程碑式综述/基准。

### 综述与基准（入口）

- **Forecasting day-ahead electricity prices: A review of state-of-the-art algorithms, best practices and an open-access benchmark** — *Applied Energy*, 293, 116983, 2021. [Paper](https://arxiv.org/abs/2008.08004) · [代码](https://github.com/jeslago/epftoolbox)
  - 日前电价预测的算法综述与开放基准；为后续 DL/LLM 预测工作提供数据集与最佳实践对照。
- **Reinforcement learning in deregulated energy market: A comprehensive review** — *Applied Energy*, 329, 120212, 2023. [Paper](https://doi.org/10.1016/j.apenergy.2022.120212) · 代码：未找到公开实现。
  - 开放能源市场中 RL（含 DRL/MARL）的应用综述；覆盖竞价、套利与市场仿真，是 RL 对照的入口。
- **Multi-agent systems in Peer-to-Peer energy trading: A comprehensive survey** — *Engineering Applications of Artificial Intelligence*, 132, 2024. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0952197624000058) · 代码：未找到公开实现。
  - P2P 能源交易中的多智能体系统综述；与 LLM 驱动的 P2P 方法形成方法谱系对照。
- **Machine learning applications for electricity market agent-based models: A systematic literature review** — arXiv, 2022. [Paper](https://arxiv.org/abs/2206.02196) · 代码：未找到公开实现。
  - 电力市场 ABM 中机器学习（含 RL）应用的系统综述；是“市场建模与行为仿真”问题的非 LLM 对照。
- **Graph Reinforcement Learning for Power Grids: A Comprehensive Survey** — arXiv, 2024. [Paper](https://arxiv.org/abs/2407.04522) · 代码：未找到公开实现。
  - 电网图 RL 综述；提供跨电力系统与市场的 RL 方法全景。

### 深度学习电价预测（非 LLM）

- **Forecasting day-ahead electricity prices**（同上综述）中的 DL 基线（DNN/RNN/CNN）是最常用的非 LLM 预测对照。
- **A comparison of modern deep neural network architectures for energy spot price forecasting** — 比较 DNN/RNN/CNN 等架构在现货电价预测上的表现；作为“纯数值 DL 能做到什么”的对照。 · 代码：题录待核实。

- **Probabilistic Forecasting of Real-Time Electricity Market Signals via Interpretable Generative AI** — arXiv，2024 年 3 月 9 日。[Paper](https://arxiv.org/abs/2403.05743) · 代码：未找到公开实现。
  - 非 LLM 方法：WIAE-GPF 使用弱新息自编码器，对节点电价、价差和不平衡等实时市场信号进行生成式概率预测。
  - 阅读重点：概率校准、时间依赖及可解释数值表征；这里的生成式建模不等于语言模型。

### 强化学习竞价与储能

以下为 RL 竞价方向的里程碑式代表作（多被引数百），是判断任何 LLM 竞价方法增量的硬基准：

- **Deep Reinforcement Learning for Strategic Bidding in Electricity Markets** — *IEEE Transactions on Smart Grid*, 11(2), 2020. [DOI](https://doi.org/10.1109/TSG.2019.2936142) · 代码：未找到公开实现。
  - DRL 用于战略竞价的奠基工作（被引约 389），是 RL 竞价对照的必引基线。
- **Deep Reinforcement Learning for Joint Bidding and Pricing of Load Serving Entity** — *IEEE Transactions on Smart Grid*, 10(6), 2019. [DOI](https://doi.org/10.1109/TSG.2019.2903756) · 代码：未找到公开实现。
  - 负荷服务商联合竞价与定价的 DRL（被引约 143）。
- **Approximating Nash Equilibrium in Day-ahead Electricity Market Bidding with Multi-agent Deep Reinforcement Learning** — *Journal of Modern Power Systems and Clean Energy*, 9(3), 2021. [DOI](https://doi.org/10.35833/MPCE.2020.000502) · 代码：未找到公开实现。
  - MADRL 逼近日前市场竞价的纳什均衡（被引约 140）；是“多主体竞价均衡”的对照。
- **Multi-Agent Deep Reinforcement Learning for Simulating Centralized Double-Sided Auction Electricity Market** — *IEEE Transactions on Power Systems*, 2025. [DOI](https://doi.org/10.1109/TPWRS.2024.3404472) · 代码：未找到公开实现。
  - MADRL 仿真集中式双边拍卖市场；是“市场仿真”的非 LLM 对照。
- **Optimizing bidding strategy in electricity market based on graph convolutional neural network and deep reinforcement learning** — *Applied Energy*, 379, 2025. [DOI](https://doi.org/10.1016/j.apenergy.2024.124978) · [代码](https://github.com/18heweng666/DDPG-GCN-for-bidding-strategy)
  - 图卷积 + DRL 竞价；结合网络结构与策略优化。
- **Intelligent strategic bidding in competitive electricity markets using multi-agent simulation and deep reinforcement learning** — *Applied Soft Computing*, 2024. [DOI](https://doi.org/10.1016/j.asoc.2024.111235) · 代码：未找到公开实现。
  - 多智能体仿真 + DRL 的战略竞价。
- **A strategic day-ahead bidding strategy and operation for battery energy storage system by reinforcement learning** — *Electric Power Systems Research*, 196, 2021. [DOI](https://doi.org/10.1016/j.epsr.2021.107229) · 代码：未找到公开实现。
  - BESS 日前竞价与运行的 RL 奠基工作（被引约 71）；储能套利竞价的必引对照。
- **Multi-market bidding behavior analysis of energy storage system based on inverse reinforcement learning** — *IEEE Transactions on Power Systems*, 2022. [DOI](https://doi.org/10.1109/TPWRS.2022.3150518) · 代码：未找到公开实现。
  - 逆强化学习分析储能多市场竞价行为（被引约 53）。
- **Temporal-aware deep reinforcement learning for energy storage bidding in energy and contingency reserve markets** — *IEEE Transactions on Energy Markets, Policy and Regulation*, 2024. [DOI](https://doi.org/10.1109/TEMPR.2024.3372656) · 代码：未找到公开实现。
  - 时序感知 DRL 储能联合能量/备用竞价。
- **Attentive convolutional deep reinforcement learning for optimizing solar-storage systems in real-time electricity markets** — *IEEE Transactions on Industrial Informatics*, 2024. [DOI](https://doi.org/10.1109/TII.2024.3352229) · 代码：未找到公开实现。
  - 注意力卷积 DRL 优化光储实时市场参与。
- **Multi-agent deep reinforcement learning-based autonomous decision-making framework for community virtual power plants** — *Applied Energy*, 2024. [DOI](https://doi.org/10.1016/j.apenergy.2024.122813) · 代码：未找到公开实现。
  - 社区虚拟电厂自主决策的 MADRL 框架（被引约 55）。
- **Energy storage arbitrage in two-settlement markets: A transformer-based approach** — *Electric Power Systems Research*, 2024. [DOI](https://doi.org/10.1016/j.epsr.2024.110755) · [代码](https://github.com/Alghumayjan/Energy-Storage-Arbitrage-in-Two-Settlement-Markets)
  - Transformer 储能套利（两结算市场）；“不含语言的 Transformer”套利对照。
- **Interpretable Hybrid Experimental Learning for Trading Behavior Modeling in Electricity Market** — *IEEE Transactions on Power Systems*, 38(4), 2023. [DOI](https://doi.org/10.1109/TPWRS.2022.3173654) · 代码：未找到公开实现。
  - 可解释交易行为建模（不依赖 LLM）。

- **Learn to Bid: Deep Reinforcement Learning with Transformer for Energy Storage Bidding in Energy and Contingency Reserve Markets** — NeurIPS 2022（Climate Change AI）。 [Paper](https://www.climatechange.ai/papers/neurips2022/62) · 代码：未找到公开实现。
  - 储能联合能量/备用市场的 DRL+Transformer 竞价；是“不含语言的 Transformer+RL”对照。
- **Deep Reinforcement Learning for Wind and Energy Storage Coordination in Wholesale Energy and Ancillary Service Markets** — arXiv, 2022. [Paper](https://arxiv.org/abs/2212.13368) · 代码：未找到公开实现。
  - 风+储能联合参与能量与辅助服务市场的 DRL 调度与竞价。
- **Reinforcement Learning-Based Bi-Level strategic bidding model of Gas-fired unit in integrated electricity and natural gas markets preventing market manipulation** — *Applied Energy*, 336, 120822, 2023. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0306261923001770) · 代码：未找到公开实现。
  - 气电机的双层策略竞价，防市场操纵；作为传统发电企业竞价的 RL 对照。
- **Proximal policy optimization based reinforcement learning for joint bidding in energy and frequency regulation markets** — Monash（期刊版）。 [Record](https://research.monash.edu/en/publications/proximal-policy-optimization-based-reinforcement-learning-for-joi) · 代码：未找到公开实现。
  - PPO 用于能量与调频市场联合竞价，是类 FCAS 场景的非 LLM RL 对照。
- **MARS-DA: A Hierarchical Reinforcement Learning Framework for Risk-Aware Multi-Agent Bidding in Power Grids** — arXiv, 2026. [Paper](https://arxiv.org/abs/2605.03142) · 代码：未找到公开实现。
  - 面向可再生能源波动下日前/实时市场价差的风险感知多主体竞价；是“风险管理型竞价”的非 LLM 对照。
- **A Dual-Positive Monotone Parameterization for Multi-Segment Bids and a Validity Assessment Framework for Reinforcement Learning Agent-based Simulation of Electricity Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2604.10252) · 代码：未找到公开实现。
  - RL-ABS 中多段单调报价的合法参数化与有效性评估；是市场机制分析用 RL 仿真的方法论对照。
- **Evaluation of Electricity Market Clearing Mechanisms via Reinforcement Learning: Prices, Remuneration and Competitive Dynamics** — arXiv, 2026. [Paper](https://arxiv.org/abs/2602.01392) · [代码](https://github.com/andyalt23/report-electricity-market-comparison-rl)
  - 用 RL 智能体评估 Pay-as-Clear 等出清机制的价格、报酬与竞争动态；是“机制设计”问题的非 LLM 对照。

- **Integrating Multi-Agent Reinforcement Learning and Evolutionary Game Theory for Adaptive Virtual Bidding Strategies in Electricity Markets** — *Journal of Power and Energy Engineering*, 14(4), 1–24，2026。[Paper](https://www.scirp.org/journal/paperinformation?paperid=150495) · 代码：未找到公开实现 · [DOI](https://doi.org/10.4236/jpee.2026.144001)
  - 非 LLM 对照：结合 MADDPG 与演化博弈分析虚拟竞价，考虑异质参与者、预算及 CVaR 约束。可作为数值决策基线；核实的方法没有引入语言模型智能体。

### 多主体强化学习与 P2P

- **Renewable energy integration and microgrid energy trading using multi-agent deep reinforcement learning** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261922005256) · 代码：未找到公开实现。
  - MADRL 用于微网能量交易；是 LLM-MARL P2P 方法的纯 RL 对照。
- **Multi-agent deep deterministic policy gradient algorithm for peer-to-peer energy trading considering distribution network constraints** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261922005025) · 代码：未找到公开实现。
  - 考虑配网约束的 P2P 交易 MADDPG；对应 LLM-Enhanced P2P 方法的约束处理对照。
- **Multi-agent deep reinforcement learning for efficient multi-timescale bidding of a hybrid power plant in day-ahead and real-time markets** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0306261922004603) · 代码：未找到公开实现。
  - 混合电源日前+实时多时间尺度竞价的 MADRL。
- **Indirect customer-to-customer energy trading with reinforcement learning** — *IEEE Transactions on Smart Grid*, 2019. [DOI](https://doi.org/10.1109/TSG.2018.2857449) · 代码：未找到公开实现。
  - 间接 C2C 能源交易的 RL（被引约 206），是本地能源市场 RL 的奠基工作。
- **Multi-agent deep reinforcement learning for coordinated energy trading and flexibility services provision in local electricity markets** — *IEEE Transactions on Smart Grid*, 2023. [DOI](https://doi.org/10.1109/TSG.2022.3149266) · 代码：未找到公开实现。
  - MADRL 协调本地电力市场的能源交易与灵活性服务（被引约 140）。
- **A scalable privacy-preserving multi-agent deep reinforcement learning approach for large-scale peer-to-peer transactive energy trading** — *IEEE Transactions on Smart Grid*, 2021. [DOI](https://doi.org/10.1109/TSG.2021.3103917) · 代码：未找到公开实现。
  - 大规模 P2P 跨能源交易的隐私保护 MADRL（被引约 211）。
- **Reinforcement learning-driven local transactive energy market for distributed energy resources** — *Energy and AI*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S2666546822000197) · 代码：未找到公开实现。
  - 面向分布式能源的本地跨能源市场的 RL。

### 市场力评估与计算市场仿真

- **A reinforcement learning model to assess market power under auction-based energy pricing** — *IEEE Transactions on Power Systems*, 22(1), 2007. [DOI](https://doi.org/10.1109/TPWRS.2006.888977) · 代码：未找到公开实现。
  - RL 评估拍卖定价下市场力的奠基工作（被引约 196）；是“市场力/竞争动态”问题的经典对照。
- **An Adaptive Q-Learning Algorithm Developed for Agent-Based Computational Modeling of Electricity Market** — *IEEE Transactions on Systems, Man, and Cybernetics, Part C*, 40(5), 2010. [DOI](https://doi.org/10.1109/TSMCC.2010.2044174) · 代码：未找到公开实现。
  - 自适应 Q-learning 用于电力市场 ABM 计算建模（被引约 125）。

- **AI agents in Algorithmic Electricity Markets: On the Emergence of Tacit Collusion** — arXiv，2026 年 8 月 27 日。[Paper](https://arxiv.org/abs/2608.26896) · 代码：未找到公开实现。
  - 非 LLM 方法：采用多智能体 TD3，研究具有网络约束的重复电力市场出清与策略竞价。
  - 阅读重点：偏离惩罚、短视消融与迭代最优响应检验，可作为识别默示合谋的数值对照，避免仅凭高利润下结论；该论文没有评测 LLM 竞价者。

---

## 支撑：数据集、基准与工具

补充可复现的数据集、评估基准、工具包与交易仿真环境；用于复现论文、自建基线和训练/评测交易智能体。

### 电价预测数据集与基准

- **Global Day-Ahead Electricity Price Dataset** — IEEE DataPort。多区域日前电价数据集，便于跨区域统一地获取电价序列。 [Dataset](https://ieee-dataport.org/documents/global-day-ahead-electricity-price-dataset) · [数据处理代码](https://github.com/d3m-lab/Energy-Price-Data-Research) · [Mendeley](https://data.mendeley.com/datasets/s54n4tyyz4/3)
- **UniElecPrice: Unified Cross-Regional Time-Series Day-Ahead Electricity Price Dataset** — IEEE Open Journal 描述文档。 [Descriptor](https://ieeexplore.ieee.org/document/11169754) · [数据处理代码](https://github.com/d3m-lab/Energy-Price-Data-Research)
- **NOR_EPF** — 挪威五个竞价区的日前电价预测基准（含代码与数据）。 [Repo](https://github.com/myptd/NOR_EPF)
- **2024 IISE PG&E Electricity Price Forecasting Challenge** — PG&E 赞助的电价预测挑战数据集。 [Repo](https://github.com/RIA-Research-Group/2024-IISE-PGE-Electricity-Price-Forecasting-Challenge)
- **OpenSTEF / Liander 2024 Energy Forecasting Benchmark** — 能源负荷/价格预测基准（Hugging Face 数据集）。 [Dataset](https://huggingface.co/datasets/cat1233211/liander2024-energy-forecasting-benchmark)

### LLM / 智能体评测基准

- **SolarChain-Eval: A Physics-Constrained Benchmark for Trustworthy Economic Agents in Decentralized Energy Markets** — arXiv, 2026。面向去中心化能源市场经济智能体的物理约束评测。 [Paper](https://arxiv.org/abs/2607.08681) · [代码](https://github.com/yxu-dev/SolarChain-Eval)
- **EnergyAgentBench: Benchmarking LLM Agents on Live Energy Infrastructure Data** — arXiv，2026。[Paper](https://arxiv.org/abs/2605.15230) · [代码](https://github.com/TheHydroguy/energyagentbench)
  - 评测电力市场区域选址、成本—碳排放权衡和长期基础设施决策中的多步工具调用，并非短期竞价基准。
  - 仓库包含任务生成、评分、模型运行器与工具适配代码，运行依赖外部模型服务和实时 QuarluxAI 接口；代码存在不代表已完成复现。
- **energy-markets-eval** — Hugging Face 数据集，能源市场评测样本（30 条、6 个领域）。 [Dataset](https://huggingface.co/datasets/karthikchundi/energy-markets-eval)
- **DSM-EQA** — 需求侧管理能量问答评测集（GitHub）。 [Repo](https://github.com/samarhashmi/DSM-EQA)

### 交易仿真环境与工具包

- **ASSUME** — 面向电力市场动态与国家/市场设计的智能体仿真框架，支持强化学习。 [Paper](https://www.sciencedirect.com/science/article/pii/S2352711025001438) · [代码](https://github.com/assume-framework/assume)
- **POMATO** — 分区电力市场出清与分析的电力市场工具（Python+Julia）。 [SoftwareX](https://doi.org/10.1016/j.softx.2021.100870) · [代码](https://github.com/richard-weinhold/pomato)
- **AMES** — 美国批发电力市场的智能体仿真框架（AMES 市场）。 [GitHub](https://github.com/ames-market/AMES-V5.0)
- **lemlab** — 面向本地能源市场（P2P）应用的多智能体开发与测试工具。 [GitHub](https://github.com/tum-ewk/lemlab)
- **energy-py** — 能源系统强化学习框架（含电池、VPP 等环境）。 [GitHub](https://github.com/ADGEfficiency/energy-py)
- **marl_clearing_and_bidding** — 模型强化学习下的市场出清与竞价复现仓库。 [GitHub](https://github.com/Digitalized-Energy-Systems/marl_clearing_and_bidding)

### LLM / 智能体交易环境与基准

面向 LLM 的电力市场资源已包括 P2P 竞价实现和市场治理基准，同时也有通用及强化学习仿真器。各资源的交易机制、物理约束、智能体职责和公开完整性不同，应按具体的竞价、出清或政策评测任务判断适用性。

- **OPLEM: Open Platform for Local Energy Markets** — *Applied Energy*, 2024。本地能源市场（P2P、需求响应、储能代理）开放仿真平台，可作为 LLM 交易智能体的市场底座。 [Paper](https://www.sciencedirect.com/science/article/pii/S0306261924012315) · [代码](https://github.com/PSALOxford/OPLEM)
- **Agentic AI for Price-Only 15 min SDAC Market Diagnostics in Central and Eastern Europe** — MDPI, 2026。面向 SDAC 单一日前耦合市场的智能体化市场诊断。 [Paper](https://www.mdpi.com/2571-5577/9/5/93) · [案例数据（无实现代码）](https://github.com/sener3/energy-agents)
- **PowerAgentBench（含 -SS / -Dyn）** — 电力系统智能体的多步操作性评测基准（稳态/动态研究）。属于电力系统 agent 基准而非市场交易基准，但提供可复用的 agent 任务/环境/度量范式。 [Paper (SS)](https://arxiv.org/abs/2606.18789) · [代码](https://github.com/Power-Agent/PowerAgentBench)
- **NTU P2P Energy Agent（World Avatar）** — 剑桥 Care 项目下的 P2P 能源交易智能体实现（基于 TheWorldAvatar 堆栈）。 [Repo](https://github.com/cambridge-cares/TheWorldAvatar/tree/main/Agents/NTUP2PEnergyAgent)
- **BESS-Coding-Agent** — 面向能源市场的储能（BESS）编码智能体原型。 [GitHub](https://github.com/NavishaShetty/BESS-Coding-Agent)

---

## 待核实题录

保留已发现的相关题录；尚未完成全文、发表日期或实验核对，不据此作效果比较。

| 年份标签 | 论文 | 来源 | 待核实内容 |
| --- | --- | --- | --- |
| 2024 | Large Language Model for Extreme Electricity Price Forecasting in the Australia Electricity Market | [IEEE IECON 2024 / DOI](https://doi.org/10.1109/IECON55916.2024.10906045) · 代码：未找到公开实现 | 全文方法、数据和基线 |
| 2025 | A Large Language Model-Based Agent for Automated Bidding Strategy Generation in Electricity Markets | [IEEE ICPIES 2025 / DOI](https://doi.org/10.1109/ICPIES65420.2025.11070004) · 代码：未找到公开实现 | 全文方法、策略评价 |
| 2025 | A Review of Large Language Models for Energy Systems: Applications, Challenges, and Future Prospects | [IEEE Access / DOI](https://doi.org/10.1109/ACCESS.2025.3610994) · 代码：未找到公开实现 | 综述范围是否含电力市场专门小节；作为入口还是单列 |
| 2026（索引） | Virtual Power Plant Trading Strategy in the Electricity Market Based on Prompt-LLM & MAPPO（基于LLM Prompt推理的虚拟电厂MAPPO交易策略） | [DOI](https://doi.org/10.3969/j.issn.1007-290X.2026.04.002) · [万方题录](https://d.wanfangdata.com.cn/periodical/gddl202604002) · 代码：未找到公开实现 | 索引为《广东电力》39(4):13–26；期刊原文、LLM 实现及实验基线仍待核实 |
| 2025 | An In-Context LLM for PV-BESS Operations: Adaptive Day-Ahead Strategy Recommendation for Economic Optimization | [IEEE Access / DOI](https://doi.org/10.1109/ACCESS.2025.3638429) · 代码：未找到公开实现 | 是否属市场竞价或仅运行经济优化 |
| 2025 | Modeling and optimization of virtual power plant energy market behavior based on news sentiment and natural semantic analysis | [Sustainable Energy Tech. & Assess. / DOI](https://doi.org/10.1016/j.seta.2025.104718) · 代码：未找到公开实现 | LLM 具体角色、实验与基线 |
| 2026 | Large Language Model Applications in Power Systems: A Comprehensive Review and Outlook | [J. Modern Power Systems & Clean Energy / DOI](https://doi.org/10.35833/MPCE.2025.000760) · 代码：未找到公开实现 | 综述中电力市场章节占比；作为入口还是单列 |
| 2025 | An Event-Aware Price Spread Arbitrage Decision Framework for Electricity Retailers in Spot Markets | [IEEE EI² 2025 / DOI](https://doi.org/10.1109/EI268505.2025.11425643) · 代码：未找到公开实现 | Crossref 已核实题名、会议与 2066–2070 页；一手摘要／全文、LLM 作用、市场数据及套利评估仍待核实 |

筛选记录（2026-10-13）：从电力市场待核实列表移除 *Agents are All you need: Elevating Trading Dynamics with Advanced Generative AI-Driven Conversational LLM Agents and Tools*（[DOI](https://doi.org/10.1109/I2CT61223.2024.10543356)）；[作者机构的介绍](https://rastrai.com/news)指向金融交易流程，未确认其具有电力市场应用。

---

## 开放的研究空白

以下是按科学问题梳理后仍待填补的空白，不代表已经证实；其中「研究问题」一栏是阅读这些论文后值得继续检验的检验点，「空白」一栏是当前生态尚未覆盖之处。

| 科学问题 | 研究问题 | 当前空白 |
| --- | --- | --- |
| 价格形成与预测 | 信息增益、事件时效 | NSW-EPNews 与 TRACE 已提供具体文本—电价基准；跨市场协议对齐及可比较的负面结果仍待评估 |
| 参与者竞价与决策 | 预测到收益、规则迁移 | LLM-native 竞价环境稀缺；决策收益多以仿真而非真实市场验证 |
| 市场机制与交易设计 | 公平性与经济激励的权衡 | 公平与激励的证据仍依赖场景；应区分已有 MARL 合谋检验与尚待研究的 LLM 竞价者问题 |
| 市场建模与仿真 | 行为校准 | LLM 仿真产生的报价分布/价格鲜有对照真实数据校准 |
| 规则、政策与评测 | 专业能力 vs 交易收益 | 问答得分与实际交易收益之间的鸿沟未被量化 |

具体检验问题：

1. **信息增益**：在相同数据和下游模型下，LLM 是否优于关键词、传统文本编码器和手工事件变量？
2. **事件时效**：严格以预测时刻可获得的信息为准，新闻发布时间、影响持续时间和地区关联是否改变效果？
3. **预测到收益**：预测误差改善能否带来扣除约束和成本后的交易收益改善？
4. **规则迁移**：市场规则改变后，Agent 能否正确更新模型约束，并保持策略有效？
5. **行为校准**：LLM 仿真产生的报价分布、价格和参与者响应是否符合实际？
6. **增量归因**：在同等预算与数据下，LLM 相对成熟 RL/DL/时序基线的增量究竟来自“语言语义理解”，还是来自更强的表征或更多算力？这条是扩展到 AI 视角后最核心、却最少被论文直接回答的问题。
7. **默示合谋**：在寡头、重复互动的算法电力市场中，独立学习的 LLM/RL 竞价智能体是否会自发形成默示合谋？机制设计如何抵御这一风险？

建议精读起点：报价行为与情绪预测、NSW-EPNews、极端日分类、FCAS 自动竞价、P2P 专家工作流、MSS-Agent；对照侧从《RL in deregulated energy market》与《Forecasting day-ahead electricity prices》两篇综述入手。

## Contributing

欢迎通过 Issue 或 Pull Request 补充论文、纠正题录和更新公开资源。每个条目建议提供：

- 原始标题、作者、首次公开年份和正式发表信息；
- DOI、出版社或作者论文链接；
- 所述方法类别（LLM / DL / RL / 时序基础模型 / 博弈仿真）、所属科学问题、电力市场任务、LLM 实际作用、市场／数据、基线和主要结论；
- 代码及数据链接，并区分完整实现、部分代码、补充材料和需申请资源。

同一论文的预印本和正式版本合并记录。优先引用出版社、作者公开版本和机构资料；未核实内容放入待核实列表。仅提供论文链接，不重新分发论文全文。

## Acknowledgements

文献库的组织形式参考 [awesome_energy_LLM](https://github.com/chenweilong915/awesome_energy_LLM)。本文献库以 LLM／生成式为主体、以其它 AI 方法为对照，按电力市场中的科学问题独立分类和整理，检索覆盖 arXiv、IEEE Xplore、Elsevier（ScienceDirect）等多个来源，持续通过中文文献、会议论文及前后向引文检索扩展。

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Altrouge7/Papers-of-LLM-in-Electricity-Market&type=Date)](https://star-history.com/#Altrouge7/Papers-of-LLM-in-Electricity-Market&Date)
