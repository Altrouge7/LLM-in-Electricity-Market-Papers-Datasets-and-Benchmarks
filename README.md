# LLM in electricity market

A curated reading list of large language models in electricity markets, covering papers from **2024 onward**.

面向 **LLM＋电力市场** 的论文与资源清单，按市场研究问题组织，记录 LLM 的实际作用、研究场景及发表状态。

**更新日期：2026-09-09。当前为初始文献清单，不是完整系统综述。** 论文结论为作者报告；部分条目基于摘要或公开版本整理，尚未逐篇复现。预印本与正式版本合并记录，待核实题录单列。

## Contents

- [Scope and taxonomy](#scope-and-taxonomy)
- [Price forecasting](#price-forecasting)
- [Bidding and storage trading](#bidding-and-storage-trading)
- [Peer-to-peer electricity markets](#peer-to-peer-electricity-markets)
- [Market modelling and behavioral simulation](#market-modelling-and-behavioral-simulation)
- [Market rules, policy and evaluation](#market-rules-policy-and-evaluation)
- [Supporting methods and benchmarks](#supporting-methods-and-benchmarks)
- [Papers to verify](#papers-to-verify)
- [Research questions](#research-questions)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)

## Scope and taxonomy

优先收录直接涉及电价、竞价、储能套利、辅助服务、P2P 交易、市场仿真、规则和政策的 LLM 论文。普通负荷预测、潮流计算、纯调度和普通 Transformer 研究不自动纳入；时序基础模型单列，避免将架构相似性等同于语言推理能力。

| 分类 | 核心问题 | 常见 LLM 角色 |
| --- | --- | --- |
| 电价预测 | 电价、趋势、尖峰和不确定性 | 新闻特征提取、报价行为预测、数值推断 |
| 竞价与储能交易 | 市场参与者如何形成交易动作 | 工具协调、策略生成、信息记忆 |
| P2P 市场 | 产消者如何交易及协调利益 | 专家示范、奖励评价、预测辅助 |
| 市场建模与仿真 | 规则和异质行为如何影响市场 | 规则转模型、代码生成、行为模拟 |
| 规则、政策与评测 | 模型能否理解专业规则与政策 | 领域问答、政策量化、能力评测 |
| 支撑方法与基准 | 如何建立强基线和工具评测 | 时序基础模型、多步工具调用 |

## Price forecasting

### 2024

- **Using Generative Pre-Trained Transformers (GPT) for Electricity Price Trend Forecasting in the Spanish Market** — *Energies*, 17(10), 2338, 2024. [Paper](https://www.mdpi.com/1996-1073/17/10/2338) · [DOI](https://doi.org/10.3390/en17102338)
  - 市场：西班牙；输入为能源新闻与专家报告。
  - 方法：比较上下文示例和 GPT 微调，提取电价趋势信息和附加变量。
  - 阅读重点：文本观点与发布后价格趋势之间的关系；不是直接预测精确电价值。

- **Large Language Model-Based Bidding Behavior Agent and Market Sentiment Agent-Assisted Electricity Price Prediction** — 2024 年公开；*IEEE Transactions on Energy Markets, Policy and Regulation*, 3(2), 223–235, 2025. [DOI](https://doi.org/10.1109/TEMPR.2024.3518624) · [Author version](https://www.researchgate.net/publication/387130812_Large_Language_Model-based_Bidding_Behavior_Agent_and_Market_Sentiment_Agent-Assisted_Electricity_Price_Prediction)
  - 市场：澳大利亚 NEM，五分钟价格。
  - 方法：微调 LLM 预测报价行为，另用 LLM 提取市场情绪，结合改进的条件时序 GAN（CTSGAN）。
  - 阅读重点：作者报告电价和尖峰预测改善；区分“预测他人报价”与“优化自身报价”。

### 2025

- **LLM-Enhanced Feature Engineering for Multi-Factor Electricity Price Predictions** — arXiv, 2025. [Paper](https://arxiv.org/abs/2505.11890)
  - 市场：澳大利亚 NSW。
  - 方法：FAEP 使用 LLM／RAG 增强特征，融合天气、价格跳跃等信息，接入 XGBoost–LSTM。
  - 阅读重点：新增信息、LLM 特征处理和下游模型分别贡献多少增益。

- **NSW-EPNews: A News-Augmented Benchmark for Electricity Price Forecasting with LLMs** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.11050)
  - 数据：NSW 2015–2024 年超过 17.5 万条半小时价格、温度和 WattClarity 新闻；48 步预测。
  - 方法：对比传统模型与利用结构化上下文的 LLM。
  - 结果：新闻对传统模型的增益有限；LLM 改善较小，并出现虚构或格式错误的价格序列。应同时记录正面与负面结果。

- **LLM-Enhanced Short-Term Electricity Price Forecasting Method for Australian Electricity Market** — 2025-12-24 在线；*Applied Sciences*, 16(1), 200, 2026. [Paper](https://www.mdpi.com/2076-3417/16/1/200) · [DOI](https://doi.org/10.3390/app16010200)
  - 市场：NSW 五分钟价格；主要评估包含 2024 年 5 月场景。
  - 方法：LLM 将新闻转为事件特征，结合天气、周期变量、分位数回归和保形校准。
  - 阅读重点：概率预测与区间校准，以及短评估窗口下的泛化边界。

### 2026

- **A Few-Shot LLM Framework for Extreme Day Classification in Electricity Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2602.16735)
  - 市场：美国得州。
  - 方法：将负荷、可再生能源、天气和近期价格统计量转成提示，判断次日是否出现价格尖峰。
  - 结果：作者报告少样本条件下可超过 SVM、XGBoost；任务是极端日分类，不是完整价格轨迹预测。

## Bidding and storage trading

- **LLM-coordination in auto-bidding of frequency regulation: Cross-attention distributional reinforcement agentic learning** — *Applied Energy*, 401, 126702, 2025. [Paper](https://doi.org/10.1016/j.apenergy.2025.126702)
  - 市场：南澳能量与频率控制辅助服务（FCAS）联合市场，电池储能竞价。
  - 方法：LLM 协调智能体、理解指令和解释反馈；交叉注意力提取市场特征，基于 SAC 的分布强化学习优化策略。
  - 结果：作者报告收益优于预测后优化与其他 DRL 基线；需要分别检验 LLM 和强化学习模块贡献。

- **LLM-Enhanced Trading Decision Framework with Multi-Scale Memory for Electricity Markets** — IEEE SmartGridComm, 2025. [DOI](https://doi.org/10.1109/SmartGridComm65349.2025.11204628) · [Institutional record](https://research.monash.edu/en/publications/llm-enhanced-trading-decision-framework-with-multi-scale-memory-f/)
  - 市场：澳大利亚电力市场。
  - 方法：短期、中期、长期和反思记忆，处理新闻的语义相关性与延迟影响。
  - 阅读重点：信息时效、记忆更新，以及文本信号如何影响交易决策。

## Peer-to-peer electricity markets

- **LLM-Enhanced Multi-Agent Reinforcement Learning with Expert Workflow for Real-Time P2P Energy Trading** — 2025 预印本；*IEEE Transactions on Smart Grid*, Early Access, 2026. [Paper](https://arxiv.org/abs/2507.14995) · [DOI](https://doi.org/10.1109/TSG.2026.3684885) · [Supplementary materials](https://github.com/jzk0806/P2P-llm-supplementary)
  - 场景：考虑配电网约束的实时 P2P 交易。
  - 方法：LLM 生成个性化专家策略，通过模仿指导多智能体强化学习，并使用差分注意力 critic。
  - 结果：作者报告交易成本和电压越限率下降。仓库链接为补充材料，不代表完整可复现实现。

- **Scalable Fairness Shaping with LLM-Guided Multi-Agent Reinforcement Learning for Peer-to-Peer Electricity Markets** — arXiv, 2025. [Paper](https://arxiv.org/abs/2508.18610)
  - 场景：连续双向拍卖下的 P2P 产消者交易。
  - 方法：LLM critic 给出电网、卖方之间和定价公平性评分，并融入奖励。
  - 阅读重点：公平性与经济激励如何权衡，以及 LLM 评价的稳定性。

- **Large Language Model Assisted Peer-to-Peer Energy Trading System** — *Journal of Energy Engineering*, 152(4), 2026. [Paper](https://ascelibrary.org/doi/abs/10.1061/JLEED9.EYENG-6440)
  - 场景：供需比定价的家庭 P2P 交易。
  - 方法：两阶段提示、多轮负荷预测与数值后处理，连接到负荷调度。
  - 阅读重点：预测误差如何传递到交易结果；部分数据与实现需申请获取。

## Market modelling and behavioral simulation

- **Leveraging Large Language Model Based Agent for Automated Electricity Market Modelling and Simulation** — *Journal of Modern Power Systems and Clean Energy*, 14(1), 50–62, 2026. [Paper](https://doi.org/10.35833/MPCE.2025.000639)
  - 方法：MSS-Agent 从规则文档提取模型，通过分层思维链、工具调用和反思调试生成仿真代码。
  - 阅读重点：“规则文档→数学模型→可执行仿真”的准确性、代码可靠性和建模效率。

- **Behavioral Generative Agents for Power Dispatch and Auction** — arXiv, 2026. [Paper](https://arxiv.org/abs/2603.08477)
  - 场景：家庭电池管理与电网接入权拍卖。
  - 方法：利用上下文学习塑造规则式、短视或战略性行为，对照动态规划和竞价基准。
  - 结果：概念验证展示理性策略及系统性行为偏差；不等同于经过真实参与者行为校准的市场模拟器。

## Market rules, policy and evaluation

- **ELM-Bench: A Multidimensional Methodological Framework for Large Language Model Evaluation in Electricity Markets** — *Energies*, 18(15), 3982, 2025. [Paper](https://www.mdpi.com/1996-1073/18/15/3982)
  - 场景：中国电力市场，理解、生成、安全三个维度，7 类任务、2841 个样本。
  - 方法：比较通用模型与领域微调模型 QwenGOLD。
  - 阅读重点：专业能力与微调收益；问答及决策任务得分不等于实际交易收益。

- **基于大语言模型与可解释机器学习的中国大陆电力政策量化框架与效力研究** — 2026. [Journal article](https://skjournal.upc.edu.cn/article/html/20260102)
  - 方法：提示工程、微调模型、主题分析与可解释机器学习，量化政策文本及其效力。
  - 阅读重点：“政策文本→政策变量→实证分析”；更偏政策经济研究，而非实时交易。

## Supporting methods and benchmarks

以下工作用于基线和评测设计，不能全部作为语言推理增强交易的证据。

- **Energy Price Modelling: A Comparative Evaluation of four Generations of Forecasting Methods** — arXiv, 2024. [Paper](https://arxiv.org/abs/2411.03372)
  - 欧洲能源市场上的预测方法比较；用于建立计量、机器学习、序列模型与 Transformer 基线。
- **Benchmarking Pre-Trained Time Series Models for Electricity Price Forecasting** — 2025, public preprint. [Paper](https://arxiv.org/abs/2506.08113)
  - 欧洲五国 2024 年日前价格；比较 Chronos、TimesFM、Moirai 等时序基础模型。
  - 作者报告没有时序基础模型在统计意义上超过其双季节 MSTL 基线。
- **Forecasting Day-Ahead Residential Electricity Prices Using a Large Language Model** — SSRN working paper, 2025. [Paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5158359)
  - 实际使用 Chronos，在伦敦居民电价实验中超过 ARIMA、Gaussian Processes，但微调存在跨片段泛化问题。
- **EnergyAgentBench: Benchmarking LLM Agents on Live Energy Infrastructure Data** — arXiv, 2026. [Paper](https://arxiv.org/abs/2605.15230)
  - 实时能源数据上的多步工具调用评测，任务包括选址、成本—碳权衡和长期组合分析；不是短期竞价基准。

## Papers to verify

保留已发现的相关题录；尚未完成全文、发表日期或实验核对，不据此作效果比较。

| 年份标签 | 论文 | 来源 | 待核实内容 |
| --- | --- | --- | --- |
| 2024 | Large Language Model for Extreme Electricity Price Forecasting in the Australia Electricity Market | [IEEE IECON / DOI](https://doi.org/10.1109/IECON55916.2024.10906045) | 全文方法、数据和基线 |
| 2025 | A Large Language Model-Based Agent for Automated Bidding Strategy Generation in Electricity Markets | [IEEE ICPIES / DOI](https://doi.org/10.1109/ICPIES65420.2025.11070004) | 全文方法、策略评价 |
| 2025 | Large Language Model Based Data Augmentation for Peak Electricity Price Forecasting and Battery Energy Storage Arbitrage | [IEEE SMC official handbook](https://www.ieeesmc2025.org/files/content/SMC25-Handbook.pdf) | DOI、数据增强机制、套利实验 |
| 2026 | LLM-CECM: A simulation framework for strategic generation behavior in coupled electricity-carbon markets | [Publisher page](https://www.sciencedirect.com/science/article/pii/S0960148126009651) | 在线发表日期、完整仿真设置与验证 |

## Research questions

以下是阅读这些论文后值得继续检验的问题，不代表已经证实的研究空白。

1. **信息增益**：在相同数据和下游模型下，LLM 是否优于关键词、传统文本编码器和手工事件变量？
2. **事件时效**：严格以预测时刻可获得的信息为准，新闻发布时间、影响持续时间和地区关联是否改变效果？
3. **预测到收益**：预测误差改善能否带来扣除约束和成本后的交易收益改善？
4. **规则迁移**：市场规则改变后，Agent 能否正确更新模型约束，并保持策略有效？
5. **行为校准**：LLM 仿真产生的报价分布、价格和参与者响应是否符合实际？

建议精读起点：报价行为与情绪预测、NSW-EPNews、极端日分类、FCAS 自动竞价、P2P 专家工作流、MSS-Agent。

## Contributing

欢迎通过 Issue 或 Pull Request 补充论文、纠正题录和更新公开资源。每个条目建议提供：

- 原始标题、作者、首次公开年份和正式发表信息；
- DOI、出版社或作者论文链接；
- 电力市场任务、LLM 实际作用、市场／数据、基线和主要结论；
- 代码及数据链接，并区分完整实现、部分代码、补充材料和需申请资源。

同一论文的预印本和正式版本合并记录。优先引用出版社、作者公开版本和机构资料；未核实内容放入待核实列表。仅提供论文链接，不重新分发论文全文。

## Acknowledgements

文献库的组织形式参考 [awesome_energy_LLM](https://github.com/chenweilong915/awesome_energy_LLM)。本文献库按电力市场研究问题独立分类和整理，初始清单仍需通过中文文献、会议论文及前后向引文检索扩展。
