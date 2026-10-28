# Electricity-Market LLM papers, datasets and benchmarks

> **English（this page）** | [简体中文](README.zh-CN.md)

A curated reading list of AI in electricity markets, with large language models (and generative / foundation models) as the primary focus and other AI methods (deep learning, reinforcement learning, time-series foundation models, agent-based / game theory) as comparison anchors. LLM papers cover **2024 onward**; non-LLM methods span **2020 onward** with earlier milestones.

**Last updated: 2026-10-28. This is a continuously growing literature and resource list, not a complete systematic review.** Reported findings are the authors'; some entries are summarized from abstracts or public versions and have not been reproduced one by one. Preprints and published versions are merged; unverified records are listed separately.

Latest increment (2026-10-28): added ten main-list research records, four author-linked code resources and an AlphaSearch dataset entry; added four bibliographically verified candidates to the pending table. The document-activity study was first submitted October 23. Other additions are backfills or newly verified records, not necessarily first published since October 13. The 2026 autonomous-BESS-bidding article is kept distinct from the related 2024 preprint until their version relationship is established.

Resources for additions, and the E2A-MAS project-page status, were checked on 2026-10-28. Other code-status labels retain their earlier September 16 or October 13 checks. Links follow the corresponding paper; “Code: not located” means no matching public implementation was confirmed. Partial code, data, supplementary materials and code-pending project pages are distinguished. No linked experiments were rerun.

Search scope: 2024–2026 LLM work across Q1–Q5, prioritizing October 13–28, 2026 and backfilling omissions. Google Scholar returned usable results for all five question groups; arXiv/API, Crossref, publisher/author/institutional pages and GitHub contents supplied verification. Some publisher full texts remained inaccessible; four new records with verified metadata but insufficient primary methodological evidence remain pending. This is a targeted update, not an exhaustive systematic review.

## Contents

- [Scope and scientific questions](#scope-and-scientific-questions)
- [Q1: How do prices form and get forecast](#q1-how-do-prices-form-and-get-forecast)
- [Q2: How do participants bid and decide](#q2-how-do-participants-bid-and-decide)
- [Q3: How are market mechanisms and trading designed](#q3-how-are-market-mechanisms-and-trading-designed)
- [Q4: How are markets modeled, simulated, and behavior-calibrated](#q4-how-are-markets-modeled-simulated-and-behavior-calibrated)
- [Q5: Can models understand rules and policy, and be evaluated](#q5-can-models-understand-rules-and-policy-and-be-evaluated)
- [Support: time-series foundation models and baselines](#support-time-series-foundation-models-and-baselines)
- [Comparison: non-LLM methods](#comparison-non-llm-methods)
- [Support: datasets, benchmarks and tools](#support-datasets-benchmarks-and-tools)
- [Papers to verify](#papers-to-verify)
- [Open research gaps](#open-research-gaps)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)

## Scope and scientific questions

We prioritize LLM papers that directly involve electricity prices, bidding, storage arbitrage, ancillary services, P2P trading, market simulation, rules, and policy. Ordinary load forecasting, power-flow computation, pure dispatch, and vanilla Transformer studies are not automatically included; time-series foundation models are listed separately to avoid conflating architectural similarity with language-reasoning ability.

We also include **non-LLM methods** (deep-learning forecasting, single/multi-agent RL bidding, time-series foundation models, multi-agent game-theoretic simulation, generative models and interpretable ML) as **comparison anchors** — they answer "how well can we do without language reasoning", and are the baseline for judging whether, and where, an LLM actually adds value. Non-LLM methods are grouped in the "Comparison: non-LLM methods" section, organized by method rather than by scientific question.

Electricity-market operation decomposes into a causal chain: **how prices form → how participants decide given prices → how mechanisms coordinate those decisions → how the system is modeled and optimized → how rules and policy are understood and evaluated**. LLMs play a different role at each link. Accordingly, this list is organized around five scientific questions:

| # | Scientific question | Research focus | Typical LLM role |
| --- | --- | --- | --- |
| 1 | How do prices form and get forecast | Causes and prediction of prices, trends, spikes, uncertainty | News/sentiment feature extraction, bid-behavior prediction, numeric inference |
| 2 | How do participants bid and decide | How a single market player forms bids and trading actions | Strategy generation, tool coordination, information memory, interpretable reasoning |
| 3 | How are market mechanisms and trading designed | How prosumers (P2P) and multiple agents coordinate interest and fairness | Expert demonstrations, reward evaluation, fairness shaping |
| 4 | How are markets modeled, simulated, and behavior-calibrated | How rules and heterogeneous behavior shape market outcomes | Rule→model translation, code generation, behavior simulation |
| 5 | Can models understand rules and policy, and be evaluated | How well models understand domain rules/policy and can be reliably evaluated | Domain QA, policy quantification, capability benchmarks |

The first four are "forward" operating questions; the fifth is the "meta" question (can we trust these models). Each section opens with what the question studies and where the difficulty lies, then lists the corresponding papers.

---

## Q1: How do prices form and get forecast

Electricity price is the core signal of market operation. Its difficulty: price is jointly determined by supply/demand, bid games, weather, fuel, and breaking news, exhibiting spikes, tail risk, and strong mean reversion; text (news, market rules, outage notices) carries causal information beyond the numeric series. LLMs open the previously hard-to-model "text → numeric/event" channel here.

Year groups follow the first public year where verified; formal publication years are retained in each entry. Time-series-only and non-LLM generative methods are listed in the support/comparison sections.

### 2024

- **Using Generative Pre-Trained Transformers (GPT) for Electricity Price Trend Forecasting in the Spanish Market** — *Energies*, 17(10), 2338, 2024. [Paper](https://www.mdpi.com/1996-1073/17/10/2338) · [Code](https://github.com/AMM-UJI/energy-price-prediction-OpenAI) · [DOI](https://doi.org/10.3390/en17102338)
  - Market: Spain; input from energy news and expert reports.
  - Method: compares in-context examples vs GPT fine-tuning to extract price-trend information and auxiliary variables.
  - Reading focus: relationship between textual opinion and post-publication price trend; not direct exact-price prediction.

- **Large Language Model-Based Bidding Behavior Agent and Market Sentiment Agent-Assisted Electricity Price Prediction** — public 2024; *IEEE Transactions on Energy Markets, Policy and Regulation*, 3(2), 223–235, 2025. [DOI](https://doi.org/10.1109/TEMPR.2024.3518624) · [Author version](https://www.researchgate.net/publication/387130812_Large_Language_Model-based_Bidding_Behavior_Agent_and_Market_Sentiment_Agent-Assisted_Electricity_Price_Prediction) · Code: not located.
  - Market: Australian NEM, five-minute prices.
  - Method: fine-tunes an LLM to predict bid behavior and another to extract market sentiment, combined with an improved conditional time-series GAN (CTSGAN).
  - Reading focus: authors report improved price and spike prediction; distinguish "predicting others' bids" from "optimizing one's own bid".

- **From News to Forecast: Integrating Event Analysis in LLM-Based Time Series Forecasting with Reflection** — NeurIPS, 2024. [Paper](https://arxiv.org/abs/2409.17515) · [Code](https://github.com/daydreamer-amelia/From_News_to_Forecast)
  - Method: extracts events from news and uses a reflection mechanism to aid LLM time-series forecasting; a general framework with energy/power benchmarks.
  - Reading focus: attribution of gains to event analysis, and whether reflection reduces hallucination; a general baseline for event-driven forecasting.

### 2025

- **LLM-Enhanced Feature Engineering for Multi-Factor Electricity Price Predictions** — arXiv, 2025. [Paper](https://arxiv.org/abs/2505.11890) · Code: not located.
  - Market: Australian NSW.
  - Method: FAEP uses LLM/RAG-enhanced features (weather, price jumps, etc.) feeding an XGBoost–LSTM.
  - Reading focus: how much gain comes from new information vs LLM feature processing vs the downstream model.

- **NSW-EPNews: A News-Augmented Benchmark for Electricity Price Forecasting with LLMs** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.11050) · Code: not located · [Dataset / experimental materials](https://figshare.com/s/2a00cae76712b59f63ea)
  - Data: NSW 2015–2024, >175k half-hour prices, temperature, and WattClarity news; 48-step forecasting.
  - Method: compares conventional models vs LLMs using structured context.
  - Result: news gives limited gain for conventional models; LLM improvement is small and produces hallucinated or malformed price series. Record both positive and negative results.
  - Resource check: the paper-matched Figshare landing page is accessible; archive contents and implementation completeness were not inspected. Conference acceptance was not confirmed.

- **LLM-Enhanced Short-Term Electricity Price Forecasting Method for Australian Electricity Market** — online December 24, 2025; *Applied Sciences*, 16(1), 200, 2026. [Paper](https://www.mdpi.com/2076-3417/16/1/200) · Code: not located · [DOI](https://doi.org/10.3390/app16010200)
  - Market: NSW five-minute prices; the publisher text describes evaluation across 2024, with individual months used as illustrative cases.
  - Method: LLM-extracted news features are combined with numerical covariates, quantile regression and conformal calibration.
  - Reading focus: reconstruct the actual evaluation split and reconcile month/metric descriptions in the text and figures before comparing results; do not infer a one-month-only evaluation from a case plot.

- **AlphaCast: A Human Wisdom-LLM Intelligence Co-Reasoning Framework for Interactive Time Series Forecasting** — arXiv, first submitted November 12, 2025; v5 April 10, 2026. [Paper](https://arxiv.org/abs/2511.08947) · [Code](https://github.com/ustc-time-series/AlphaCast)
  - Method: training-free LLM agents prepare context, generate forecasts and refine them through reflection, supported by feature, knowledge, case and contextual tools.
  - Market/reading focus: hourly day-ahead prices from Belgium, Germany, France, Nord Pool and PJM. Separate the contribution of LLM reasoning from auxiliary forecasters and richer input information.

- **Electricity Market Price Forecast via LLM-based Sentiment Analysis and TimeXer** — 2025 7th International Conference on Data-driven Optimization of Complex Systems (DOCS), 2025. [DOI](https://doi.org/10.1109/DOCS67533.2025.11200590) · Code: not located.
  - Method: LLM extracts market sentiment as features, combined with the TimeXer time-series model.
  - Reading focus: information gain of LLM sentiment over conventional text features; paired-control design with the "bid-behavior and sentiment" entry.

- **Adaptive Frequency-Domain Feature Extraction With Large Language Models for Accurate Electricity Market Forecasting** — *IEEE Transactions on Consumer Electronics*, 2025. [DOI](https://doi.org/10.1109/TCE.2025.3585889) · Code: not located.
  - Method: LLM-assisted adaptive frequency-domain feature extraction for price/market forecasting.
  - Reading focus: the boundary of frequency decomposition vs LLM's role; whether it truly adds language reasoning or merely acts as a feature selector.

- **Application of Large Language Models in Intelligent Preprocessing and Forecasting of Electricity Price** — 2025 4th International Conference on Smart Grid and Green Energy (ICSGGE), 2025. [DOI](https://doi.org/10.1109/ICSGGE64667.2025.10984532) · Code: not located.
  - Method: LLMs for intelligent preprocessing and forecasting of price data.
  - Reading focus: gains from preprocessing (cleaning/imputation/featurization) vs forecasting separately; robustness under poor data quality.

### 2026

- **A Few-Shot LLM Framework for Extreme Day Classification in Electricity Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2602.16735) · Code: not located.
  - Market: Texas, USA.
  - Method: feeds load, renewables, weather, and recent price statistics into a prompt to judge whether the next day has a price spike.
  - Result: authors report beating SVM/XGBoost in few-shot; the task is extreme-day classification, not full price-trajectory forecasting.

- **Reasoning-enhanced probabilistic electricity price forecasting using parameter-efficient large language models** — *Applied Energy*, 2026. [DOI](https://doi.org/10.1016/j.apenergy.2026.128712) · Code: not located.
  - Method: parameter-efficient (PEFT) LLMs enhanced with reasoning for probabilistic price forecasting.
  - Reading focus: probabilistic calibration of reasoning-enhanced vs pure-numeric baselines; the cost–gain tradeoff of PEFT.

- **RIS-LLM: Reasoning-informed semantic modeling of electricity market price dynamics** — *Advanced Engineering Informatics*, 2026. [DOI](https://doi.org/10.1016/j.aei.2026.104949) · Code: not located.
  - Method: incorporates reasoning into semantic modeling of price dynamics.
  - Reading focus: gain of reasoning over pure-feature/pure-numeric approaches; generalization boundary of semantic modeling.

- **LLM Agent-Driven Dynamic Prediction for Day-Ahead Electricity Prices** — 2026 IEEE 2nd International Conference on Electronics, Energy Systems and Power Engineering (EESPE), 2026. [DOI](https://doi.org/10.1109/EESPE68405.2026.11648328) · Code: not located.
  - Method: LLM-agent-driven dynamic day-ahead price prediction.
  - Reading focus: the difference between LLM-as-a-"prediction agent" versus LLM-as-a-feature-extractor.

- **A large language model-based reprogramming method for electricity price spread prediction** — *Journal of Renewable and Sustainable Energy*, 2026 (online July 21). [DOI](https://doi.org/10.1063/5.0336800) · Code: not located.
  - Method: LLM-based reprogramming for price-spread prediction.
  - Reading focus: arbitrage-oriented spread (rather than level) prediction; transferability of reprogramming.

- **TRACE: A Reproducible Benchmark for Electricity Price Forecasting with Official Operational Text** — arXiv, first submitted September 30, 2026. Authors report acceptance at the NeurIPS 2026 Workshop on Foundation Models for Time Series. [Paper](https://arxiv.org/abs/2610.02256) · Code/data: public release not located.
  - Benchmark: 7,300 zone–day instances from five PJM zones, pairing prices with official operational text reconstructed at the forecast cutoff.
  - Reading focus: forecast-time availability, cancellation/applicability timestamps and matched numerical controls. Authors report the most consistent text-related gains for upper-tail risk; cross-day text mismatch reverses the gains.

- **A Human-in-the-Loop Autonomous Agent for Industry Time Series Forecasting** — arXiv, August 31, 2026 (CastClaw). [Paper](https://arxiv.org/abs/2608.30976) · [Code](https://github.com/ustc-time-series/CastClaw) · [Project](https://ustc-time-series.github.io/cast-claw/)
  - Method: coordinates specialized forecasters, tools, human constraints and versioned evidence to check, retain or revise forecasts; evaluation includes five electricity-price datasets.
  - Reading focus: authors report favorable MSE/MAE point estimates against 16 baselines, while repeated-run significance and component attribution remain unresolved. Check validation gates, rejected revisions, stopping rules and equal tool/model budgets.

- **An on-premises end-to-end automated forecasting multi-agent system for the energy domain** — *Engineering Applications of Artificial Intelligence*, 181, Part 7, 115728, October 2026. [Paper](https://doi.org/10.1016/j.engappai.2026.115728) · [Project page (code pending)](https://github.com/ZihangQiu/E2A-MAS)
  - Method: E2A-MAS coordinates feature engineering, preprocessing, model selection and hyperparameter retuning; its energy-domain experiments include the Belgian ods134 electricity-price dataset.
  - Reading focus: distinguish price-specific accuracy from workflow success and compare training budgets. At the 2026-10-28 recheck, the linked repository still contained only a README promising code release; an implementation was not publicly available there.

- **Do LLM-derived text features improve electricity price forecasts beyond document activity? Evidence from Australia's National Electricity Market** — arXiv, October 23, 2026. [Paper](https://arxiv.org/abs/2610.32379) · [Code and released data](https://github.com/ningfanxing-sys/nem-llm-text-activity)
  - Design: compares LLM text representations against both numerical-only forecasts and matched document/failure-count controls; covers AEMO notices at 5–30-minute horizons and WattClarity news for day-ahead prices, using three training seeds and time-shifted placebos.
  - Result: news content adds no statistically significant improvement beyond activity counts; two notice representations add small gains, with mixed placebo evidence. Stronger operational or price-history benchmarks outperform all text models.
  - Resources: extraction/forecasting source, saved forecasts and result-verification scripts are public. Copyrighted news text is excluded; identifiers and derived features are supplied. The linked scripts were not run.

---

## Q2: How do participants bid and decide

Price forecasting is only input; the value lies in **decisions**: when storage charges/discharges, how generators bid, how ancillary services are offered. The difficulty is that trading actions must satisfy market rules, physical constraints, and economic objectives simultaneously, with delayed market feedback. LLMs act here as a "strategy brain" or "coordinator", organizing rule text, state, and feedback into executable actions.

- **LLM-coordination in auto-bidding of frequency regulation: Cross-attention distributional reinforcement agentic learning** — *Applied Energy*, 401, 126702, 2025. [Paper](https://doi.org/10.1016/j.apenergy.2025.126702) · Code: not located.
  - Market: South Australian joint energy and Frequency Control Ancillary Services (FCAS) market, battery bidding.
  - Method: LLM coordinates agents, understands instructions and explains feedback; cross-attention extracts market features; SAC-based distributional RL optimizes the policy.
  - Result: authors report revenue beating forecast-then-optimize and other DRL baselines; the LLM and RL module contributions should be tested separately.

- **LLM-Enhanced Trading Decision Framework with Multi-Scale Memory for Electricity Markets** — IEEE SmartGridComm, 2025. [DOI](https://doi.org/10.1109/SmartGridComm65349.2025.11204628) · [Institutional record](https://research.monash.edu/en/publications/llm-enhanced-trading-decision-framework-with-multi-scale-memory-f/) · Code: not located.
  - Market: Australian electricity market.
  - Method: short/mid/long-term and reflective memory handle semantic relevance and delayed impact of news.
  - Reading focus: information recency, memory updates, and how text signals affect trading decisions.

- **Large Language Model Assisted Optimal Bidding of BESS in FCAS Market: An AI-agent based Approach** — arXiv, 2024. [Paper](https://arxiv.org/abs/2406.00974) · Code: not located.
  - Market: Australian NEM FCAS market, battery energy storage system (BESS) bidding.
  - Method: an LLM agent parses market rules/instructions and generates bidding actions, combined with optimization and RL.
  - Reading focus: decomposing LLM's semantic understanding of rules/state from the downstream bidding module; cross-market transferability.

- **An Explainable Cognitive Bidding Agent for Electricity Markets: A Framework for Zero-Shot Generalization using Large Language Models** — 2025 IEEE 9th Conference on Energy Internet and Energy System Integration (EI²), 2025. [DOI](https://doi.org/10.1109/EI268505.2025.11425567) · Code: not located.
  - Scenario: zero-shot generalization of a bidding agent, emphasizing interpretability and cognitive decision processes.
  - Method: LLM as the bidding-decision core, producing interpretable strategic reasoning and testing generalization to unseen markets.
  - Reading focus: the real boundary of zero-shot cross-market generalization; whether interpretability is post-hoc packaging or the source of strategy.

- **Dual-agent LLMs with genetic evolution for automated bidding strategy optimization in electricity markets** — IET Conference Proceedings, 2026. [DOI](https://doi.org/10.1049/icp.2026.1716) · Code: not located.
  - Scenario: automated bidding-strategy optimization.
  - Method: dual-agent LLMs combined with genetic evolution to iteratively generate and select bidding strategies.
  - Reading focus: whether genetic selection pressure is driven by real market feedback; convergence and overfitting risk.

- **A Semantic Risk-Aware Optimization Framework for Virtual Power Plant Dispatch Using Large Language Models** — *Energies*, 19(12), 2820, June 12, 2026. [Paper](https://www.mdpi.com/1996-1073/19/12/2820) · Code: not located · [DOI](https://doi.org/10.3390/en19122820)
  - Method: RAG-VPP converts market notices and warnings into semantic risk signals for scenario generation, reserve constraints and stochastic MIQP dispatch; the LLM supplies inputs to the optimizer.
  - Market/evidence: a seven-day ERCOT-style stress test with synthetic ISO-like alerts and five-minute market resolution. Reported profit and risk improvements are controlled-simulation results, not a reconstruction of the historical ERCOT crisis or live trading evidence.

- **Large Language Model Based Data Augmentation for Peak Electricity Price Forecasting and Battery Energy Storage Arbitrage** — *2025 IEEE International Conference on Systems, Man, and Cybernetics (SMC)*, 7762–7767, 2025. [Paper](https://doi.org/10.1109/SMC58881.2025.11342789) · Code: not located · [Institutional abstract](https://scholars.cityu.edu.hk/en/publications/large-language-model-based-data-augmentation-for-peak-electricity/)
  - Method: prompts containing domain knowledge and physical constraints guide LLM generation of rare peak-price samples; augmented data feed Monte Carlo dropout forecasts and scenario-based stochastic optimization for BESS arbitrage.
  - Reading focus: whether synthetic extremes improve forecast calibration and arbitrage returns. Bibliography and the institutional abstract are verified; full-text data splits, detailed baselines and reproducibility remain unverified.

- **Large Language Model-Assisted Autonomous Bidding for Battery Energy Storage Systems: An Agentic Approach for Smart Power Industrial Decision-Making** — *IEEE Transactions on Automation Science and Engineering*, 23, 18290–18304, 2026; online October 5. [Paper](https://doi.org/10.1109/TASE.2026.3740512) · Code: not located.
  - Method: a bi-level NEM/FCAS bidding model combines risk-sensitive DRL with an SFT/CoT/ReAct LLM agent that turns retrieved context into risk-preference parameters through a Kumaraswamy distributional representation.
  - Reading focus: distinguish the LLM's risk-setting role from DRL action selection; audit retrieval latency and information timing. Compare with the 2024 FCAS preprint above; an explicit preprint-to-journal version mapping was not confirmed, so the records are not silently merged.

- **Customising Electricity Contracts at Scale with Large Language Models** — 2025 preprint; *IEEE Transactions on Power Systems*, 41(4), 2953–2966, 2026. [Paper](https://arxiv.org/abs/2505.19551) · [Code](https://github.com/TU-Delft-AI-Energy-Lab/LLM-Electricity-Contracts) · [DOI](https://doi.org/10.1109/TPWRS.2026.3670536)
  - Method: chat-based agents call engineering tools to negotiate flexible grid-access contracts and check technical feasibility for residential/SME users; demonstrations also cover outage planning.
  - Reading focus: contract design and grid-access feasibility, rather than spot-auction bidding. The repository contains Wolfram notebooks, Python power-system backends and example conversations; runtime dependencies and end-to-end reproducibility remain to be tested.

- **Highly personalized electricity pricing plan selection empowered by knowledge graph-enhanced large language models** — *Advanced Engineering Informatics*, 76, Part B, 105014, 2026 (November issue; publisher abstract already public at this check). [Paper](https://doi.org/10.1016/j.aei.2026.105014) · Code: not located.
  - Method: appliance-level consumption knowledge graphs support hierarchical LLM agents for retail-plan interpretation, behavior analysis and optimization-code generation.
  - Reading focus: distinguish savings from selecting a tariff, rescheduling consumption and agent reasoning. The publisher describes real consumption data and pricing plans; the exact first-online date and public implementation were not confirmed.

- **AlphaSearch: Agentic AI for Price Arbitrage in Energy Systems** — *Proceedings of the 32nd ACM SIGKDD Conference on Knowledge Discovery and Data Mining V.2*, 11936–11947, 2026; online August 8. [Paper](https://doi.org/10.1145/3770855.3818957) · [Code](https://github.com/AgenticsFintekColumbia/agentics-energy-alphasearch) · [Dataset](https://zenodo.org/records/20478895) · [Archived code release](https://zenodo.org/records/20573370)
  - Method/resources: integrates electricity-price forecasting, battery arbitrage optimization and LLM-assisted scheduling; the repository includes MILP, RL, language-model and agent-orchestration components.
  - Reading focus: compare executed schedules under forecast uncertainty with the perfect-foresight oracle, including feasibility repair and battery constraints. Public source availability does not establish that all paper results can be reproduced; model services and solver licensing may be required.

- **From public weather narratives to solar-market risk decisions using constrained language-model features** — *Scientific Reports*, 16, 32026, July 13, 2026. [Paper](https://doi.org/10.1038/s41598-026-61535-1) · [Code and released data](https://github.com/habahabadog/weather_narratives_to_solar_market_risk_decisions)
  - Method: bounded features extracted from NWS forecast discussions augment CAISO-SP15 solar/price forecasts; 100-scenario day-block residual bootstraps feed a CVaR-regularized settlement-proxy decision rule.
  - Reading focus: gains are reported under ex-post public-data proxy accounting, not realized trading profits. Check matched blend weights, time-based tests and the separation of weather-information gain from model effects. The repository offers cached-result reconstruction and a public raw-data rebuild path; neither was run here.

- **LLM-assisted value assessment and strategy design for virtual power plant participation in coupled electricity–carbon markets** — *Scientific Reports*, online September 5, 2026. [Paper](https://doi.org/10.1038/s41598-026-69959-5) · Code: not located.
  - Method: an LLM translates user preferences into hard/soft constraints, prohibited periods and penalties for a deterministic day-ahead MILP spanning energy, ancillary-service and carbon-credit decisions; traceable renewable-energy accounting prevents double counting.
  - Reading focus: validate preference translation separately from optimization and carbon-credit accounting. Case-study gains do not establish robust performance under forecast error or strategic market interaction.

---

## Q3: How are market mechanisms and trading designed

When markets shift from centralized to decentralized (P2P, community trading, prosumers), the question is no longer "single-agent optimum" but **how the mechanism gets self-interested distributed participants to coordinate a good aggregate outcome** — efficient and fair at once. The difficulty is designing incentives under information asymmetry, heterogeneous preferences, and physical network constraints, while letting agents "learn" to cooperate or be fair within the mechanism. LLMs often act here as a "demonstrator", "critic", or "fairness evaluator".

- **LLM-Enhanced Multi-Agent Reinforcement Learning with Expert Workflow for Real-Time P2P Energy Trading** — 2025 preprint; *IEEE Transactions on Smart Grid*, Early Access, 2026. [Paper](https://arxiv.org/abs/2507.14995) · [Supplementary materials](https://github.com/jzk0806/P2P-llm-supplementary) · [DOI](https://doi.org/10.1109/TSG.2026.3684885)
  - Scenario: real-time P2P trading under distribution-network constraints.
  - Method: LLM generates personalized expert strategies, guides MARL via imitation, and a differential-attention critic is used.
  - Result: authors report lower trading cost and voltage-limit violations. The repo link is supplementary material, not a full reproducible implementation.

- **Scalable Fairness Shaping with LLM-Guided Multi-Agent Reinforcement Learning for Peer-to-Peer Electricity Markets** — 2025 preprint; *Utilities Policy*, 100, 102168, June 2026. [Paper](https://arxiv.org/abs/2508.18610) · [Partial code / toy demo](https://github.com/SHRENIK000/fairmarket-rl-llm-fairness-energy-markets) · [DOI](https://doi.org/10.1016/j.jup.2026.102168)
  - Method: an LLM critic evaluates grid dependence, seller fairness and pricing fairness after each auction, shaping MARL rewards in a continuous double auction.
  - Reading focus: fairness–profit trade-offs and transfer to larger communities. The public repository provides interfaces and a toy environment; training, the full market simulator and LLM critic remain withheld.

- **Large Language Model Assisted Peer-to-Peer Energy Trading System** — *Journal of Energy Engineering*, 152(4), 2026. [Paper](https://ascelibrary.org/doi/abs/10.1061/JLEED9.EYENG-6440) · Code/models: available on request (author statement).
  - Scenario: household P2P trading under supply-demand-ratio pricing.
  - Method: two-stage prompting, multi-round load forecast, numeric post-processing, linked to load scheduling.
  - Reading focus: how forecast error propagates to trading outcomes; some data/implementation requires request.

- **FairMarket-RL: LLM-Guided Fairness Shaping for Multi-Agent Reinforcement Learning in Peer-to-Peer Markets** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.22708) · [Partial code / toy demo](https://github.com/SHRENIK000/fairmarket-rl-llm-fairness-energy-markets) — Core training, market simulator and LLM critic withheld.
  - Scenario: MARL in P2P markets, LLM-guided fairness shaping.
  - Method: LLM evaluates trading fairness and shapes the MARL reward.
  - Reading focus: relation/difference with the same group's "Scalable Fairness Shaping"; scalability and evaluation stability of fairness shaping.

- **Equity-Aware Peer-to-Peer Energy Trading Market to Mitigate Energy Poverty: An LLM–RL Agentic Workflow** — *IEEE Transactions on Energy Markets, Policy and Regulation*, 2026. [DOI](https://doi.org/10.1109/TEMPR.2025.3633992) · Code: not located.
  - Scenario: equity-aware P2P energy trading aimed at mitigating energy poverty.
  - Method: an LLM–RL agentic workflow explicitly embeds fairness/equity objectives into trading decisions.
  - Reading focus: the fairness-vs-incentive tradeoff; quantifiable validation of the social "mitigate energy poverty" goal.

- **Grounded, Compute-Efficient LLM Policy Agents for Energy-Poverty Equity in Physically-Constrained Peer-to-Peer Energy Markets** — Kunal Jadhav and Siddhesh More; arXiv, September 1, 2026. Authors report acceptance at NLP4PI, EMNLP 2026. [Paper](https://arxiv.org/abs/2609.01918) · Code: release promised; public implementation not located.
  - Scenario: EqGrid simulates household P2P trading through a continuous double auction on an IEEE 33-bus distribution network.
  - Method: a low-frequency LLM sets price/carbon bounds and targeted subsidies; high-frequency MARL traders bid, while a separate validation/projection gate enforces grid constraints.
  - Reading focus: energy-burden equity versus trading cost; policy-model compression versus estimated inference energy. Evidence summarized from the public abstract concerns simulation, not field deployment; code/configuration release is promised there, not verified here.

- **Large Language Models as Strategic Bidding Agents in P2P Energy Trading Markets** — arXiv, 2026; authors report acceptance at IEEE IECON 2026. [Paper](https://arxiv.org/abs/2609.05462) · [Code](https://github.com/ismail0T/Strategic_Bidding_P2P_Energy_Trading)
  - Method: LLM agents directly choose prices in repeated P2P double auctions, evaluated against random bidding and an epsilon-greedy multi-armed bandit.
  - Reading focus: early-round trading-volume advantages and adaptation after market changes, alongside increasingly seller-favored surplus allocation. These experiments do not establish superiority over general MARL methods.
  - Code scope: bidding, LLM calls and clearing are implemented, but repository defaults differ from the paper's experiment configuration; results have not been reproduced here.

- **Integrating large language models into Peer-to-Peer energy management for multi-tenant buildings: A guardrail approach to ensuring resilience** — *Neural Networks*, 2026. [Paper](https://doi.org/10.1016/j.neunet.2026.108814) · Code: not located.
  - Scenario: P2P energy management in multi-tenant buildings, emphasizing guardrails and resilience.
  - Method: embeds LLMs into P2P energy management and uses constraint/guardrail mechanisms to preserve resilience under anomalies.
  - Reading focus: how guardrails constrain erroneous LLM output; how resilience is quantified.

- **Draining the Energy Commons: Self-Defeating Over-Appropriation as a Coordination Failure in Agentic LLM Collectives** — arXiv, 2026. [Paper](https://arxiv.org/abs/2607.22188) · Code: not located.
  - Scenario: coordination failure of LLM prosumer collectives over a shared renewable-energy commons.
  - Method: same-family GPT/Gemini/Grok agents act as prosumers maximizing their own objective; observes over-appropriation of the shared resource.
  - Reading focus: tragedy of the commons in LLM collective decisions; how this complements P2P fairness mechanisms.

- **Interactive learning-implementation of ChatGPT and reinforcement learning in local energy trading** — 2024 IEEE 34th Australasian Universities Power Engineering Conference (AUPEC), 2024. [DOI](https://doi.org/10.1109/AUPEC62273.2024.10807616) · Code: not located.
  - Scenario: interactive ChatGPT+RL learning in local energy trading.
  - Method: combines a conversational LLM with RL for local-prosumer trading decisions.
  - Reading focus: the division of labor in interactive LLM+RL learning; whether conversational guidance truly improves the policy.

- **An explainable equity-aware P2P energy trading framework for socio-economically diverse microgrid** — arXiv, 2025. [Paper](https://arxiv.org/abs/2507.18738) · Code: not located.
  - Scenario: interpretable, equity-aware P2P framework for socio-economically diverse microgrids.
  - Method: explicitly models and explains fairness/equity in P2P trading, handling participant heterogeneity.
  - Reading focus: interpretability of fairness metrics; positional difference from the "Equity-Aware P2P" entry above.

- **Federated Learning and LLMs for Secure Peer-to-Peer Energy Trading** — *IEEE Network*, 2026. [Paper](https://doi.org/10.1109/MNET.2026.3701057) · Code: not located · [Institutional abstract](https://zuscholars.zu.ac.ae/works/8208/)
  - Scope/method: security infrastructure for blockchain-based P2P trading. Locally fine-tuned LLMs parse logs and correlate events; federated aggregation and GNNs target attacks spanning multiple peers.
  - Reading focus: evaluate attack detection, privacy assumptions and coordination overhead separately from market clearing or bidding performance. The institutional abstract verifies the framework; detailed experimental settings and public artifacts remain unverified.

---

## Q4: How are markets modeled, simulated, and behavior-calibrated

Even with single-agent decision models, we still need to understand **emergent whole-market behavior**: how prices change after a rule adjustment, how heterogeneous participants interact, and whether bid behavior matches reality. The difficulty is that a market model must be simultaneously calibrated (credible) and executable. LLMs here automate the "rule document → mathematical model → executable simulation" chain, and act as generative participants to study behavioral biases.

- **Leveraging Large Language Model Based Agent for Automated Electricity Market Modelling and Simulation** — *Journal of Modern Power Systems and Clean Energy*, 14(1), 50–62, 2026. [Paper](https://doi.org/10.35833/MPCE.2025.000639) · Code: not located.
  - Method: MSS-Agent extracts models from rule documents and generates simulation code via hierarchical chain-of-thought, tool use, and reflective debugging.
  - Reading focus: accuracy of "rule → math model → executable simulation", code reliability, and modeling efficiency.

- **Behavioral Generative Agents for Power Dispatch and Auction** — arXiv, 2026. [Paper](https://arxiv.org/abs/2603.08477) · Code: not located.
  - Scenario: household battery management and grid-access-right auctions.
  - Method: in-context learning shapes rule-based, myopic, or strategic behavior, benchmarked against dynamic programming and bidding.
  - Result: proof-of-concept shows rational strategies and systematic behavioral biases; not a market simulator calibrated on real participants.

- **A Generative AI Agent-Based Simulation for Electricity Market and Load Forecasting Game Strategy** — Proceedings of the 2025 International Conference on Digital Society and Intelligent Computing, 2025. [DOI](https://doi.org/10.1145/3788910.3788914) · Code: not located.
  - Scenario: multi-agent simulation of market and load-forecasting game strategies.
  - Method: generative-AI agents participate in market and forecasting games; studies how strategic interaction shapes outcomes.
  - Reading focus: whether agent behavior is calibrated on real participants; correspondence of the game setup to real market mechanisms.

- **LLM-Augmented Multi-Agent System for Trading Behavior Modeling in Coupled Electricity-Carbon Markets** — *Journal of Modern Power Systems and Clean Energy*, 2026. [DOI](https://doi.org/10.35833/MPCE.2025.000645) · Code: not located.
  - Scenario: trading-behavior modeling and strategy formation in coupled electricity-carbon markets.
  - Method: LLM-augmented multi-agent system updates beliefs via bounded-rational learning and iteratively adjusts expectations/strategies.
  - Reading focus: difference/similarity with "LLM-CECM"; whether bid behavior in coupled markets is empirically calibrated.

- **Behavioral Generative Agents for Energy Operations** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.12664) · Code: not located.
  - Scenario: consumer/participant behavior modeling in energy operations, including behavioral heterogeneity in low-frequency, high-impact events.
  - Method: uses generative agents to supplement or replace conventional behavioral models and studies their value/limits in operational decisions.
  - Reading focus: calibration of generative agents against real participants; same group as "Power Dispatch and Auction" but more operations-oriented.

- **Large language models empowered agent-based modeling and simulation: A survey and perspectives** — *Humanities and Social Sciences Communications*, 2024. [DOI](https://doi.org/10.1057/s41599-024-03611-3) · [Survey resources (not implementation)](https://github.com/tsinghua-fib-lab/LLM-Agent-Based-Modeling-and-Simulation)
  - Method: a survey of LLM-empowered ABM simulation (~550 citations); the entry point to the "LLM+ABM" paradigm.
  - Reading focus: methodological background for Q4; electricity markets are one application domain.

- **Simulating financial market via large language model based agents** — arXiv, 2024. [Paper](https://arxiv.org/abs/2406.19966) · Code: not located.
  - ⚠️ Adjacent domain (equity/financial market, not electricity); kept only as a methodological reference for LLM market simulation.
  - Method: simulates a stock market with LLM agents (~51 citations).
  - Reading focus: whether adjacent-domain (finance) LLM market simulation transfers to electricity markets.

- **Generative AI-assisted Participatory Modeling in Socio-Environmental Planning under Deep Uncertainty** — arXiv, March 17, 2026; v2 March 19. [Paper](https://arxiv.org/abs/2603.17021) · [Code and supplementary materials](https://github.com/Hardy-Pei01/LLM-for-DMDU)
  - Method/market: a templated human–LLM workflow turns stakeholder descriptions into formal models and Python implementations, including a five-producer day-ahead electricity-market case and wind-revenue assessment.
  - Reading focus: a modeling proof of concept requiring human verification and refinement, not a market simulator calibrated on real participant behavior. The repository includes market case scripts and conversation records.

- **LLM-CECM: A simulation framework for strategic generation behavior in coupled electricity-carbon markets** — *Renewable Energy*, 273, 126139, 2026 (October issue); author preprint posted April 24, 2026. [Paper](https://doi.org/10.1016/j.renene.2026.126139) · Code: not located · [Author version](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6643509)
  - Method: LLM agents maintain personas, memory and beliefs for coupled electricity/carbon orders, with adaptive reasoning frequency and fixed-depth counterfactual reasoning; carbon clearing feeds back into electricity offers before network dispatch.
  - Reading focus: Australian market inputs combined with an IEEE 118-bus testbed. Reported efficiency and price-path effects are simulation evidence, not proof of equilibrium or calibration to real trader behavior.

---

## Q5: Can models understand rules and policy, and be evaluated

This is the "meta" question: before using LLMs for trading, ask whether they truly understand market rules, can quantify policy, and how to evaluate them credibly. The difficulty is that domain-knowledge evaluation is hard, and "answering correctly" does not equal "making money in a real market". Here the LLM is the "object under evaluation".

- **ELM-Bench: A Multidimensional Methodological Framework for Large Language Model Evaluation in Electricity Markets** — *Energies*, 18(15), 3982, 2025. [Paper](https://www.mdpi.com/1996-1073/18/15/3982) · Code: not located.
  - Scenario: Chinese electricity market; understanding, generation, and safety dimensions; 7 task types, 2841 samples.
  - Method: compares general models with the domain-fine-tuned QwenGOLD.
  - Reading focus: domain capability and fine-tuning gains; QA/decision scores do not equal real trading returns.

- **基于大语言模型与可解释机器学习的中国大陆电力政策量化框架与效力研究** (A framework for quantifying mainland-China electricity policy and its effectiveness using LLMs and interpretable ML) — 2026. [Journal article](https://skjournal.upc.edu.cn/article/html/20260102) · Code: not located.
  - Method: prompt engineering, fine-tuning, topic analysis, and interpretable ML to quantify policy text and effectiveness.
  - Reading focus: "policy text → policy variable → empirical analysis"; more policy-economic research than real-time trading.

- **Engineering Trustworthy Retrieval-Augmented Generation for EU Electricity Market Regulation** — *Electronics*, 15(4), 749, 2026. [Paper](https://www.mdpi.com/2079-9292/15/4/749) · Code: not located.
  - Scenario: trustworthy RAG for EU electricity-market regulation.
  - Method: builds a RAG system to answer regulatory text, focusing on trustworthiness and citation reliability.
  - Reading focus: accuracy and hallucination risk in regulatory QA; whether it supports decision migration under rule changes.

- **ElectriQ: A Benchmark for Assessing the Response Capability of Large Language Models in Power Marketing** — arXiv, 2025. [Paper](https://arxiv.org/abs/2507.22911) · [Code and data](https://github.com/Jinzhi-Wang/ElectriQ)
  - Scenario: LLM response capability in electric-power marketing (EPM), covering cross-scenario long dialogues and policy/rule knowledge.
  - Method: builds a power-marketing QA/dialogue benchmark to test LLM handling of rules, prices, and customer inquiries.
  - Reading focus: positioning difference from ELM-Bench; whether marketing-scenario evaluation touches real trading decisions.

- **How Do Tool-Augmented LLM Agents Perform on Real-World Energy Analytics Tasks?** — arXiv, 2026. [Paper](https://arxiv.org/abs/2606.26346) · [Code](https://github.com/Tume-AI/energy-evals)
  - Scenario: live data retrieval, regulatory/market knowledge, and multi-step quantitative reasoning in energy.
  - Method: empirically evaluates tool-augmented LLM agents on real energy-analysis tasks, going beyond static knowledge recall.
  - Reading focus: reliability of tool use, live data, and multi-step reasoning; complementarity with EnergyAgentBench.

- **ElecBench: A Power Dispatch Evaluation Benchmark for Large Language Models** — arXiv, 2024. [Paper](https://arxiv.org/abs/2407.05365) · [Question data (no implementation)](https://github.com/xiyuan-zhou/ElecBench-a-Power-Dispatch-Evaluation-Benchmark-for-Large-Language-Models)
  - Scenario: LLM evaluation in power dispatch (including market dynamics).
  - Method: builds a dispatch-decision benchmark to test LLM instruction-following and domain decision capability.
  - Reading focus: dispatch rather than pure market trading; evidence of "rule understanding" rather than trading returns.

- **A Benchmark for Document Understanding of Large Language Models in the Field of Electric Power** — Springer (International Symposium on Artificial Intelligence), 2025. · Code: pending bibliographic verification.
  - Method: an LLM benchmark for electric-power document understanding.
  - Reading focus: whether document understanding covers market rules, settlement documents, and other professional text.

- **WeQA: A benchmark for retrieval augmented generation in wind energy domain** — Workshop on NLP for Positive Impact (NLP4PI), 2025. [DOI](https://doi.org/10.18653/v1/2025.nlp4pi-1.20) · Code: not located.
  - Method: a wind-energy RAG benchmark; a reference for energy-domain RAG evaluation (not pure electricity market).
  - Reading focus: citation-reliability evaluation patterns that can transfer to market-regulation RAG.

- **Closed-Book Probing of Electricity-Market Role Knowledge in Language Models: The ENTSO-E Harmonised Role Model** — *Energy Informatics*, EI.A 2026, LNCS 16981, 339–358; first online October 9, 2026; proceedings bibliographic year 2027. [Paper](https://link.springer.com/chapter/10.1007/978-3-032-41864-7_22) · Code: not located · [DOI](https://doi.org/10.1007/978-3-032-41864-7_22)
  - Benchmark: closed-book recognition and free-recall probes of electricity-market roles and relationships, with programmatic scoring; evaluates nine open-weight and three frontier models.
  - Reading focus: recognizing supplied roles is easier than reconstructing their relationships from memory; distinguish terminology recognition from usable market-structure knowledge.

- **检索增强生成融合政策动态演化机制的电力市场智能问答系统** (Retrieval-augmented generation integrated with policy dynamic evolution mechanism for intelligent Q&A system in electricity market) — *Journal of Computer Applications*, online May 29, 2026 (ChatElet). [Journal article](https://www.joca.cn/EN/abstract/abstract37949.shtml) · Code: not located · [DOI](https://doi.org/10.11772/j.issn.1001-9081.2026010113)
  - Method: a policy ontology and dynamic knowledge graph support multi-path retrieval, semantic reranking and hallucination checks for electricity-market policy QA.
  - Reading focus: evaluation covers 500 single-turn questions and 452 follow-up rounds; examine policy-version validity, applicability and conflict handling. The publisher supplies the online record and abstract; issue/page metadata and public evaluation assets were not confirmed.

- **An Electricity Market Policy News Screening Model with NLP and Deep Pre-Training** — *2026 IEEE 2nd International Conference on Power and Integrated Energy Systems (ICPIES)*, 856–860, 2026. [Paper](https://doi.org/10.1109/ICPIES69888.2026.11650942) · Code: not located · [Publisher abstract](https://ieeexplore.ieee.org/abstract/document/11650942/)
  - Method: DeepSeek-70B assigns policy-news labels for expected upward, neutral or downward price influence; a supervised DistilBERT classifier learns these labels.
  - Reading focus: measure label quality and independent human agreement. Agreement with LLM-generated labels does not by itself establish causal price effects or forecast/trading gains.

- **A text-table fusion model for electricity trading and cross-modal knowledge fusion** — *Discover Applied Sciences*, online August 27, 2026 (Power-FusionLLM). [Paper](https://doi.org/10.1007/s42452-026-09439-7) · Code/data: public release not located.
  - Method: domain instruction tuning and policy-gated cross-attention combine rule text with trading tables; evaluation covers market QA, strategy generation and compliance detection on simulated/desensitized trading data.
  - Reading focus: inspect numerical reasoning, rule-to-table alignment and compliance errors separately. Reported benchmark scores do not establish feasible or profitable execution; the training/evaluation data have not been confirmed as public.

---

## Support: time-series foundation models and baselines

The following are for baseline and evaluation design; they are not evidence of "language-reasoning-enhanced trading" by themselves. They answer "how well can we do without language", the anchor for judging whether an LLM truly adds value.

- **Energy Price Modelling: A Comparative Evaluation of four Generations of Forecasting Methods** — arXiv, 2024. [Paper](https://arxiv.org/abs/2411.03372) · [Code](https://github.com/QuantLet/AI4EFin)
  - Compares forecasting methods on European energy markets; baseline for econometric, ML, sequence, and Transformer approaches.
- **Benchmarking Pre-Trained Time Series Models for Electricity Price Forecasting** — *2025 21st International Conference on the European Energy Market (EEM)*, 2025. [Paper](https://arxiv.org/abs/2506.08113) · Code: not located · [DOI](https://doi.org/10.1109/EEM64765.2025.11050326)
  - Day-ahead prices in five European countries in 2024; compares Chronos, TimesFM, Moirai, etc.
  - Authors report no time-series foundation model statistically beats their double-seasonal MSTL baseline.
- **Forecasting Day-Ahead Residential Electricity Prices Using a Large Language Model** — SSRN working paper, 2025. [Paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5158359) · Code: not located.
  - Uses Chronos; beats ARIMA and Gaussian Processes on London residential prices, but fine-tuning has cross-segment generalization issues.
- **PriceFM: Foundation Model for Probabilistic Electricity Price Forecasting** — arXiv, 2025. [Paper](https://arxiv.org/abs/2508.04875) · [Code](https://github.com/runyao-yu/PriceFM)
  - A time-series foundation model for probabilistic price forecasting; a strong baseline to compare against language-reasoning enhancements.
- **Foundation models for electricity price forecasting and battery arbitrage: Can they replace market-specific forecasting models?** — arXiv, 2026. [Paper](https://arxiv.org/abs/2609.00089) · Code: not located.
  - Tests whether time-series FMs replace market-specific models, and their economic value in battery arbitrage.
  - Directly addresses the "forecast→profit" research question; distinguishes statistical accuracy from arbitrage profit.
- **A systematic review of transformers and large language models in the energy sector: towards agentic digital twins** — *Applied Energy*, 2025. [Paper](https://doi.org/10.1016/j.apenergy.2025.126670) · Code: not located.
  - A systematic review of transformers/LLMs in energy (market and agent directions); an entry point to the domain landscape.

- **Regression Models Meet Foundation Models: A Hybrid-AI Approach to Practical Electricity Price Forecasting** — arXiv, 2026. [Paper](https://arxiv.org/abs/2603.06726) · [Code](https://github.com/thulab/FutureBoosting)
  - Method: hybridizes regression models with time-series foundation models for practical price forecasting.
  - Reading focus: source of gains over pure foundation models; comparison against pure time-series baselines (MSTL, Chronos, etc.).

- **Assessing time series foundation models for probabilistic electricity price forecasting: Toward a unified benchmark** — *Energies*, 2025. [DOI](https://doi.org/10.3390/en18236269) · [Code](https://github.com/MarchesiGabriele/PEPF_bench)
  - Method: a unified benchmark assessing time-series foundation models on probabilistic price forecasting.
  - Reading focus: complements "Benchmarking Pre-Trained Time Series Models"; a unified protocol for probabilistic evaluation.

### LLM surveys in energy/power (panorama entry points)

- **Exploring the capabilities and limitations of large language models in the electric energy sector** — *Joule*, 2024. [DOI](https://doi.org/10.1016/j.joule.2024.05.009) · Code: not located.
  - Systematically characterizes LLM capabilities and limits in electric energy (~202 citations); the must-read entry for "what LLMs can/can't do".
- **Review of LLMs applications in electrical power & energy systems** — *IEEE Access*, 2025. [DOI](https://doi.org/10.1109/ACCESS.2025.3599922) · Code: not located.
  - A survey of LLM applications in power/energy systems (~25 citations).
- **A comprehensive review on the application of large language models in power systems** — *IEEE Access*, 2025. [DOI](https://doi.org/10.1109/ACCESS.2025.3637226) · Code: not located.
  - A comprehensive review of LLM applications in power systems.
- **Opportunities of applying Large Language Models in building energy sector** — *Renewable and Sustainable Energy Reviews*, 2025. [DOI](https://doi.org/10.1016/j.rser.2025.115558) · Code: not located.
  - LLM opportunities in building energy (~68 citations); building-focused but offers adjacent-domain transfer views.

---

## Comparison: non-LLM methods

These works do not use (or do not center on) language models; they solve electricity-market problems with deep learning, reinforcement learning, time-series foundation models, or game-theoretic / multi-agent simulation. They serve as **comparison anchors**: they tell us whether an LLM's gain comes from "language/semantic understanding" or from what mature numeric methods already do well. Mostly 2020 onward; earlier works are kept only as milestone surveys/benchmarks.

### Surveys and benchmarks (entry points)

- **Forecasting day-ahead electricity prices: A review of state-of-the-art algorithms, best practices and an open-access benchmark** — *Applied Energy*, 293, 116983, 2021. [Paper](https://arxiv.org/abs/2008.08004) · [Code](https://github.com/jeslago/epftoolbox)
  - A review + open benchmark for day-ahead price forecasting; datasets and best-practice baselines for later DL/LLM work.
- **Reinforcement learning in deregulated energy market: A comprehensive review** — *Applied Energy*, 329, 120212, 2023. [Paper](https://doi.org/10.1016/j.apenergy.2022.120212) · Code: not located.
  - A review of RL (incl. DRL/MARL) in deregulated energy markets, covering bidding, arbitrage, and simulation; the RL comparison entry point.
- **Multi-agent systems in Peer-to-Peer energy trading: A comprehensive survey** — *Engineering Applications of Artificial Intelligence*, 132, 2024. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0952197624000058) · Code: not located.
  - A survey of multi-agent systems in P2P energy trading; forms a method-spectrum comparison with LLM-driven P2P.
- **Machine learning applications for electricity market agent-based models: A systematic literature review** — arXiv, 2022. [Paper](https://arxiv.org/abs/2206.02196) · Code: not located.
  - A systematic review of ML (incl. RL) in electricity-market ABMs; the non-LLM comparison for "market modeling and behavior simulation".
- **Graph Reinforcement Learning for Power Grids: A Comprehensive Survey** — arXiv, 2024. [Paper](https://arxiv.org/abs/2407.04522) · Code: not located.
  - A survey of graph RL for power grids; the RL method landscape across power systems and markets.

### Deep-learning price forecasting (non-LLM)

- The DL baselines (DNN/RNN/CNN) in the **Forecasting day-ahead electricity prices** survey are the most common non-LLM forecasting comparisons.
- **A comparison of modern deep neural network architectures for energy spot price forecasting** — compares DNN/RNN/CNN on spot-price forecasting; "what pure-numeric DL can do". · Code: pending bibliographic verification.

- **Probabilistic Forecasting of Real-Time Electricity Market Signals via Interpretable Generative AI** — arXiv, March 9, 2024. [Paper](https://arxiv.org/abs/2403.05743) · Code: not located.
  - Non-LLM method: WIAE-GPF uses a weak-innovations autoencoder for generative probabilistic forecasts of real-time market signals, including nodal prices, spreads and imbalance.
  - Reading focus: calibration, temporal dependence and interpretable numerical representations; generative modeling here does not imply a language model.

### Reinforcement-learning bidding and storage

The following are milestone RL-bidding works (many with hundreds of citations), the hard baselines for judging the incremental value of any LLM bidding method:

- **Deep Reinforcement Learning for Strategic Bidding in Electricity Markets** — *IEEE Transactions on Smart Grid*, 11(2), 2020. [DOI](https://doi.org/10.1109/TSG.2019.2936142) · Code: not located.
  - The foundational DRL strategic-bidding work (~389 citations); the mandatory RL-bidding baseline.
- **Deep Reinforcement Learning for Joint Bidding and Pricing of Load Serving Entity** — *IEEE Transactions on Smart Grid*, 10(6), 2019. [DOI](https://doi.org/10.1109/TSG.2019.2903756) · Code: not located.
  - DRL for joint bidding+pricing of a load-serving entity (~143 citations).
- **Approximating Nash Equilibrium in Day-ahead Electricity Market Bidding with Multi-agent Deep Reinforcement Learning** — *Journal of Modern Power Systems and Clean Energy*, 9(3), 2021. [DOI](https://doi.org/10.35833/MPCE.2020.000502) · Code: not located.
  - MADRL approximating Nash equilibrium of day-ahead bidding (~140 citations); the "multi-agent bidding equilibrium" comparison.
- **Multi-Agent Deep Reinforcement Learning for Simulating Centralized Double-Sided Auction Electricity Market** — *IEEE Transactions on Power Systems*, 2025. [DOI](https://doi.org/10.1109/TPWRS.2024.3404472) · Code: not located.
  - MADRL simulating a centralized double-sided auction; a non-LLM "market simulation" comparison.
- **Optimizing bidding strategy in electricity market based on graph convolutional neural network and deep reinforcement learning** — *Applied Energy*, 379, 2025. [DOI](https://doi.org/10.1016/j.apenergy.2024.124978) · [Code](https://github.com/18heweng666/DDPG-GCN-for-bidding-strategy)
  - Graph convolution + DRL bidding, combining network structure with policy optimization.
- **Intelligent strategic bidding in competitive electricity markets using multi-agent simulation and deep reinforcement learning** — *Applied Soft Computing*, 2024. [DOI](https://doi.org/10.1016/j.asoc.2024.111235) · Code: not located.
  - Multi-agent simulation + DRL strategic bidding.
- **A strategic day-ahead bidding strategy and operation for battery energy storage system by reinforcement learning** — *Electric Power Systems Research*, 196, 2021. [DOI](https://doi.org/10.1016/j.epsr.2021.107229) · Code: not located.
  - Foundational RL work for BESS day-ahead bidding and operation (~71 citations); the mandatory storage-arbitrage comparison.
- **Multi-market bidding behavior analysis of energy storage system based on inverse reinforcement learning** — *IEEE Transactions on Power Systems*, 2022. [DOI](https://doi.org/10.1109/TPWRS.2022.3150518) · Code: not located.
  - Inverse RL analyzing multi-market storage bidding (~53 citations).
- **Temporal-aware deep reinforcement learning for energy storage bidding in energy and contingency reserve markets** — *IEEE Transactions on Energy Markets, Policy and Regulation*, 2024. [DOI](https://doi.org/10.1109/TEMPR.2024.3372656) · Code: not located.
  - Temporal-aware DRL for storage joint energy/reserve bidding.
- **Attentive convolutional deep reinforcement learning for optimizing solar-storage systems in real-time electricity markets** — *IEEE Transactions on Industrial Informatics*, 2024. [DOI](https://doi.org/10.1109/TII.2024.3352229) · Code: not located.
  - Attentive-conv DRL optimizing solar-storage participation in real-time markets.
- **Multi-agent deep reinforcement learning-based autonomous decision-making framework for community virtual power plants** — *Applied Energy*, 2024. [DOI](https://doi.org/10.1016/j.apenergy.2024.122813) · Code: not located.
  - MADRL autonomous-decision framework for community VPPs (~55 citations).
- **Energy storage arbitrage in two-settlement markets: A transformer-based approach** — *Electric Power Systems Research*, 2024. [DOI](https://doi.org/10.1016/j.epsr.2024.110755) · [Code](https://github.com/Alghumayjan/Energy-Storage-Arbitrage-in-Two-Settlement-Markets)
  - Transformer for storage arbitrage in two-settlement markets; a "Transformer without language" arbitrage comparison.
- **Interpretable Hybrid Experimental Learning for Trading Behavior Modeling in Electricity Market** — *IEEE Transactions on Power Systems*, 38(4), 2023. [DOI](https://doi.org/10.1109/TPWRS.2022.3173654) · Code: not located.
  - Interpretable trading-behavior modeling (no LLM).

- **Learn to Bid: Deep Reinforcement Learning with Transformer for Energy Storage Bidding in Energy and Contingency Reserve Markets** — NeurIPS 2022 (Climate Change AI). [Paper](https://www.climatechange.ai/papers/neurips2022/62) · Code: not located.
  - DRL+Transformer for storage joint energy/reserve bidding; a "Transformer+RL without language" comparison.
- **Deep Reinforcement Learning for Wind and Energy Storage Coordination in Wholesale Energy and Ancillary Service Markets** — arXiv, 2022. [Paper](https://arxiv.org/abs/2212.13368) · Code: not located.
  - DRL dispatch/bidding of wind+storage in energy and ancillary markets.
- **Reinforcement Learning-Based Bi-Level strategic bidding model of Gas-fired unit in integrated electricity and natural gas markets preventing market manipulation** — *Applied Energy*, 336, 120822, 2023. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0306261923001770) · Code: not located.
  - Bi-level strategic bidding of a gas-fired unit preventing market manipulation; an RL comparison for conventional generators.
- **Proximal policy optimization based reinforcement learning for joint bidding in energy and frequency regulation markets** — Monash (journal version). [Record](https://research.monash.edu/en/publications/proximal-policy-optimization-based-reinforcement-learning-for-joi) · Code: not located.
  - PPO for joint energy+frequency-regulation bidding; a non-LLM RL comparison for FCAS-like scenarios.
- **MARS-DA: A Hierarchical Reinforcement Learning Framework for Risk-Aware Multi-Agent Bidding in Power Grids** — arXiv, 2026. [Paper](https://arxiv.org/abs/2605.03142) · Code: not located.
  - Risk-aware multi-agent bidding for day-ahead/real-time spreads under renewables volatility; a "risk-managed bidding" non-LLM comparison.
- **A Dual-Positive Monotone Parameterization for Multi-Segment Bids and a Validity Assessment Framework for Reinforcement Learning Agent-based Simulation of Electricity Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2604.10252) · Code: not located.
  - Legality parameterization of multi-segment monotone bids in RL-ABS; a methodological comparison for market-mechanism RL simulation.
- **Evaluation of Electricity Market Clearing Mechanisms via Reinforcement Learning: Prices, Remuneration and Competitive Dynamics** — arXiv, 2026. [Paper](https://arxiv.org/abs/2602.01392) · [Code](https://github.com/andyalt23/report-electricity-market-comparison-rl)
  - Uses RL agents to evaluate Pay-as-Clear and other clearing mechanisms; a non-LLM comparison for "mechanism design".

- **Integrating Multi-Agent Reinforcement Learning and Evolutionary Game Theory for Adaptive Virtual Bidding Strategies in Electricity Markets** — *Journal of Power and Energy Engineering*, 14(4), 1–24, 2026. [Paper](https://www.scirp.org/journal/paperinformation?paperid=150495) · Code: not located · [DOI](https://doi.org/10.4236/jpee.2026.144001)
  - Non-LLM comparison: MADDPG and evolutionary game analysis for virtual bidding, with heterogeneous participants, budget and CVaR constraints. Useful as a numerical decision baseline; the verified method does not introduce a language-model agent.

### Multi-agent RL and P2P

- **Renewable energy integration and microgrid energy trading using multi-agent deep reinforcement learning** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261922005256) · Code: not located.
  - MADRL microgrid energy trading; a pure-RL comparison for LLM-MARL P2P.
- **Multi-agent deep deterministic policy gradient algorithm for peer-to-peer energy trading considering distribution network constraints** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261922005025) · Code: not located.
  - MADDPG P2P trading with distribution constraints; the constraint-handling comparison for LLM-Enhanced P2P.
- **Multi-agent deep reinforcement learning for efficient multi-timescale bidding of a hybrid power plant in day-ahead and real-time markets** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0306261922004603) · Code: not located.
  - MADRL multi-timescale bidding of a hybrid power plant.
- **Indirect customer-to-customer energy trading with reinforcement learning** — *IEEE Transactions on Smart Grid*, 2019. [DOI](https://doi.org/10.1109/TSG.2018.2857449) · Code: not located.
  - RL for indirect C2C energy trading (~206 citations); the foundational local-energy-market RL work.
- **Multi-agent deep reinforcement learning for coordinated energy trading and flexibility services provision in local electricity markets** — *IEEE Transactions on Smart Grid*, 2023. [DOI](https://doi.org/10.1109/TSG.2022.3149266) · Code: not located.
  - MADRL coordinating energy trading and flexibility in local markets (~140 citations).
- **A scalable privacy-preserving multi-agent deep reinforcement learning approach for large-scale peer-to-peer transactive energy trading** — *IEEE Transactions on Smart Grid*, 2021. [DOI](https://doi.org/10.1109/TSG.2021.3103917) · Code: not located.
  - Privacy-preserving MADRL for large-scale P2P transactive energy (~211 citations).
- **Reinforcement learning-driven local transactive energy market for distributed energy resources** — *Energy and AI*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S2666546822000197) · Code: not located.
  - RL for a local transactive-energy market for distributed resources.

### Market power and computational market simulation

- **A reinforcement learning model to assess market power under auction-based energy pricing** — *IEEE Transactions on Power Systems*, 22(1), 2007. [DOI](https://doi.org/10.1109/TPWRS.2006.888977) · Code: not located.
  - The foundational RL market-power assessment under auction pricing (~196 citations); the classic "market power / competitive dynamics" comparison.
- **An Adaptive Q-Learning Algorithm Developed for Agent-Based Computational Modeling of Electricity Market** — *IEEE Transactions on Systems, Man, and Cybernetics, Part C*, 40(5), 2010. [DOI](https://doi.org/10.1109/TSMCC.2010.2044174) · Code: not located.
  - Adaptive Q-learning for electricity-market ABM computational modeling (~125 citations).

- **AI agents in Algorithmic Electricity Markets: On the Emergence of Tacit Collusion** — arXiv, August 27, 2026. [Paper](https://arxiv.org/abs/2608.26896) · Code: not located.
  - Non-LLM method: multi-agent TD3 for strategic bidding in repeated, network-constrained electricity-market clearing.
  - Reading focus: deviation-punishment tests, shortsight ablations and iterative best responses provide numerical baselines for detecting tacit collusion beyond elevated profits alone; this paper does not test LLM bidders.

---

## Support: datasets, benchmarks and tools

Reproducible datasets, benchmarks, toolkits, and trading-simulation environments; for reproducing papers, building baselines, and training/evaluating trading agents.

### Price-forecasting datasets and benchmarks

- **Global Day-Ahead Electricity Price Dataset** — IEEE DataPort. Multi-region day-ahead prices for uniform cross-region access. [Dataset](https://ieee-dataport.org/documents/global-day-ahead-electricity-price-dataset) · [Data-processing code](https://github.com/d3m-lab/Energy-Price-Data-Research) · [Mendeley](https://data.mendeley.com/datasets/s54n4tyyz4/3)
- **UniElecPrice: Unified Cross-Regional Time-Series Day-Ahead Electricity Price Dataset** — IEEE Open Journal descriptor. [Descriptor](https://ieeexplore.ieee.org/document/11169754) · [Data-processing code](https://github.com/d3m-lab/Energy-Price-Data-Research)
- **NOR_EPF** — a day-ahead price-forecasting benchmark for Norway's five bidding zones (code + data). [Repo](https://github.com/myptd/NOR_EPF)
- **2024 IISE PG&E Electricity Price Forecasting Challenge** — PG&E-sponsored price-forecasting challenge dataset. [Repo](https://github.com/RIA-Research-Group/2024-IISE-PGE-Electricity-Price-Forecasting-Challenge)
- **OpenSTEF / Liander 2024 Energy Forecasting Benchmark** — energy load/price forecasting benchmark (Hugging Face). [Dataset](https://huggingface.co/datasets/cat1233211/liander2024-energy-forecasting-benchmark)

- **Electricity Market Dataset across Regions (AlphaSearch)** — five-region price/load dataset covering New York, California, Texas, Germany and Italy. [Dataset](https://zenodo.org/records/20478895) · [Processing / experiment code](https://github.com/AgenticsFintekColumbia/agentics-energy-alphasearch). Check source-specific price definitions, units and daylight-saving timestamps before cross-market comparisons.

### LLM / agent evaluation benchmarks

- **SolarChain-Eval: A Physics-Constrained Benchmark for Trustworthy Economic Agents in Decentralized Energy Markets** — arXiv, 2026. Physics-constrained evaluation of economic agents in decentralized energy markets. [Paper](https://arxiv.org/abs/2607.08681) · [Code](https://github.com/yxu-dev/SolarChain-Eval)
- **EnergyAgentBench: Benchmarking LLM Agents on Live Energy Infrastructure Data** — arXiv, 2026. [Paper](https://arxiv.org/abs/2605.15230) · [Code](https://github.com/TheHydroguy/energyagentbench)
  - Evaluates multi-step tool use for electricity-market-region selection, cost–carbon trade-offs and long-horizon infrastructure decisions, rather than short-term bidding.
  - The repository includes task generators, scoring, model runners and tool adapters; execution depends on external model services and live QuarluxAI endpoints. Code presence is not a completed reproduction.
- **energy-markets-eval** — Hugging Face dataset, energy-market evaluation samples (30 samples, 6 domains). [Dataset](https://huggingface.co/datasets/karthikchundi/energy-markets-eval)
- **DSM-EQA** — demand-side-management energy QA evaluation set (GitHub). [Repo](https://github.com/samarhashmi/DSM-EQA)

### Trading-simulation environments and toolkits

- **ASSUME** — agent-based simulation for market dynamics and market design, RL-capable. [Paper](https://www.sciencedirect.com/science/article/pii/S2352711025001438) · [Code](https://github.com/assume-framework/assume)
- **POMATO** — a power-market tool for zonal market clearing and analysis (Python+Julia). [SoftwareX](https://doi.org/10.1016/j.softx.2021.100870) · [Code](https://github.com/richard-weinhold/pomato)
- **AMES** — agent-based simulation of US wholesale power markets. [GitHub](https://github.com/ames-market/AMES-V5.0)
- **lemlab** — multi-agent development/testing for local (P2P) energy-market applications. [GitHub](https://github.com/tum-ewk/lemlab)
- **energy-py** — RL framework for energy systems (battery, VPP, etc.). [GitHub](https://github.com/ADGEfficiency/energy-py)
- **marl_clearing_and_bidding** — reproduction repo for market clearing+bidding with model-based RL. [GitHub](https://github.com/Digitalized-Energy-Systems/marl_clearing_and_bidding)

### LLM / agent trading environments and benchmarks

Public LLM-oriented electricity-market resources now include P2P bidding implementations and market-governance benchmarks, alongside general and RL-based simulators. Their market mechanisms, physical constraints, agent roles and release completeness differ; assess each resource for the intended bidding, clearing or policy-evaluation task.

- **OPLEM: Open Platform for Local Energy Markets** — *Applied Energy*, 2024. An open simulation platform for local energy markets (P2P, demand response, storage agents); a market substrate for LLM trading agents. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261924012315) · [Code](https://github.com/PSALOxford/OPLEM)
- **Agentic AI for Price-Only 15 min SDAC Market Diagnostics in Central and Eastern Europe** — MDPI, 2026. Agentic diagnostics for the SDAC single day-ahead coupling market. [Paper](https://www.mdpi.com/2571-5577/9/5/93) · [Case data (no implementation)](https://github.com/sener3/energy-agents)
- **PowerAgentBench (incl. -SS / -Dyn)** — a multi-step operational benchmark for power-system agents (steady-state/dynamic). A power-system (not market-trading) agent benchmark, but offers reusable agent task/env/metric patterns. [Paper (SS)](https://arxiv.org/abs/2606.18789) · [Code](https://github.com/Power-Agent/PowerAgentBench)
- **NTU P2P Energy Agent (World Avatar)** — a P2P energy-trading agent implementation under the Cambridge CARES project (TheWorldAvatar stack). [Repo](https://github.com/cambridge-cares/TheWorldAvatar/tree/main/Agents/NTUP2PEnergyAgent)
- **BESS-Coding-Agent** — a BESS coding-agent prototype for the energy market. [GitHub](https://github.com/NavishaShetty/BESS-Coding-Agent)

---

## Papers to verify

Retained but not yet verified on full text, publication date, or experiments; do not use these for effect comparisons.

| Year | Paper | Source | To verify |
| --- | --- | --- | --- |
| 2024 | Large Language Model for Extreme Electricity Price Forecasting in the Australia Electricity Market | [IEEE IECON 2024 / DOI](https://doi.org/10.1109/IECON55916.2024.10906045) · Code: not located | full method, data, baselines |
| 2025 | A Large Language Model-Based Agent for Automated Bidding Strategy Generation in Electricity Markets | [IEEE ICPIES 2025 / DOI](https://doi.org/10.1109/ICPIES65420.2025.11070004) · Code: not located | full method, strategy evaluation |
| 2025 | A Review of Large Language Models for Energy Systems: Applications, Challenges, and Future Prospects | [IEEE Access / DOI](https://doi.org/10.1109/ACCESS.2025.3610994) · Code: not located | whether it has an electricity-market section; entry vs. standalone |
| 2026 (indexed) | Virtual Power Plant Trading Strategy in the Electricity Market Based on Prompt-LLM & MAPPO | [DOI](https://doi.org/10.3969/j.issn.1007-290X.2026.04.002) · [Wanfang record](https://d.wanfangdata.com.cn/periodical/gddl202604002) · Code: not located | Indexed as Guangdong Electric Power, 39(4), 13–26; original journal text, LLM implementation and baselines remain unverified |
| 2025 | An In-Context LLM for PV-BESS Operations: Adaptive Day-Ahead Strategy Recommendation for Economic Optimization | [IEEE Access / DOI](https://doi.org/10.1109/ACCESS.2025.3638429) · Code: not located | market bidding vs. pure operation optimization |
| 2025 | Modeling and optimization of virtual power plant energy market behavior based on news sentiment and natural semantic analysis | [Sustainable Energy Tech. & Assess. / DOI](https://doi.org/10.1016/j.seta.2025.104718) · Code: not located | Publisher abstract confirms pretrained text representations plus DRL on CAISO data/news; exact encoder, generative-LLM role, splits and baselines remain unverified (checked October 28) |
| 2026 | Large Language Model Applications in Power Systems: A Comprehensive Review and Outlook | [J. Modern Power Systems & Clean Energy / DOI](https://doi.org/10.35833/MPCE.2025.000760) · Code: not located | electricity-market section share; entry vs. standalone |
| 2025 | An Event-Aware Price Spread Arbitrage Decision Framework for Electricity Retailers in Spot Markets | [IEEE EI² 2025 / DOI](https://doi.org/10.1109/EI268505.2025.11425643) · Code: not located | Crossref verifies title, conference and pp. 2066–2070; primary abstract/full text, LLM role, market data and arbitrage evaluation remain unverified |
| 2026 | A knowledge graph-augmented algorithm for day-ahead electricity price forecasting in electricity markets based on large language model and graph neural network fusion | [SENPS 2026 / SPIE / DOI](https://doi.org/10.1117/12.3120337) · Code: not located | Primary method, graph construction, information timing and numerical baselines |
| 2026 | Day-Ahead Electricity Price Forecasting via Multi-Granularity Feature Alignment and Large Language Models | [IEEE CIEEC 2026 / DOI](https://doi.org/10.1109/CIEEC69682.2026.11572089) · Code: not located | Primary abstract/full text, LLM role and feature-alignment ablations; pp. 3582–3587 verified |
| 2026 | Agents for Rule-Intensive Decision Making in Virtual Power Plant Operations | [IEEE PSGEC 2026 / DOI](https://doi.org/10.1109/PSGEC70194.2026.11719196) · Code: not located | Primary abstract/full text, market-rule tasks and agent evaluation; pp. 29–34 verified |
| 2026 | A Hierarchical LLM-MARL Framework for Market-Oriented Cooperative Scheduling of Multiple Virtual Power Plants | [IEEE ICAITA 2026 / DOI](https://doi.org/10.1109/ICAITA71179.2026.11737037) · Code: not located | Primary abstract/full text, LLM/MARL responsibilities and market mechanism; pp. 980–986 verified |

Screening note (2026-10-13): removed *Agents are All you need: Elevating Trading Dynamics with Advanced Generative AI-Driven Conversational LLM Agents and Tools* ([DOI](https://doi.org/10.1109/I2CT61223.2024.10543356)) from the pending electricity-market records: the [authors' organization describes financial workflows](https://rastrai.com/news), and an electricity-market application was not established.

---

## Open research gaps

Gaps remaining after organizing by scientific question (not claimed to be verified). The "research question" column lists checkpoints worth validating after reading; the "gap" column lists what the ecosystem has not yet covered.

| Scientific question | Research question | Current gap |
| --- | --- | --- |
| Price formation & forecasting | information gain, event timeliness | NSW-EPNews, TRACE and the NEM document-activity study provide concrete tests; cross-market replication must separate content gain from document counts, extraction failures and stronger numerical references |
| Bidding & decision | forecast→profit, rule migration | LLM-native bidding environments scarce; gains mostly validated in simulation, not real markets |
| Mechanism & trading design | fairness vs incentive | fairness–incentive evidence remains setting-dependent; distinguish established MARL collusion tests from still-open questions about LLM bidders |
| Modeling & simulation | behavior calibration | LLM-simulated bid distributions/prices rarely calibrated against real data |
| Rules, policy & evaluation | domain capability vs trading profit | the gap between QA scores and real trading returns is unquantified |

Specific checkpoints:

1. **Information gain**: under identical data and downstream models, does an LLM beat document/failure-count controls, keywords, conventional text encoders and handcrafted events? Include operational forecasts, time-shifted placebos and model-knowledge-cutoff checks.
2. **Event timeliness**: strictly using only information available at forecast time, do news release time, impact duration, and regional association change results?
3. **Forecast→profit**: does improved forecast error translate into improved trading profit after constraints and costs?
4. **Rule migration**: after market rules change, can the agent correctly update model constraints and remain effective?
5. **Behavior calibration**: do LLM-simulated bid distributions, prices, and participant responses match reality?
6. **Attribution of gain**: under equal budget and data, does an LLM's gain over mature RL/DL/time-series baselines come from "language-semantic understanding" or from stronger representation/more compute? The most central, least-directly-answered question once framed as "AI".
7. **Tacit collusion**: in oligopolistic, repeatedly-interacting algorithmic markets, do independently-learning LLM/RL bidding agents spontaneously form tacit collusion? How can mechanism design resist it?

Suggested starting points for close reading: bid-behavior & sentiment prediction, NSW-EPNews, extreme-day classification, FCAS auto-bidding, P2P expert workflow, MSS-Agent; on the comparison side, start from the two surveys "RL in deregulated energy market" and "Forecasting day-ahead electricity prices".

## Contributing

Contributions (papers, record corrections, public resources) are welcome via Issue or Pull Request. Each entry should ideally include:

- Original title, authors, first-publication year and published venue;
- DOI, publisher, or author link;
- Method category (LLM / DL / RL / time-series FM / game-theoretic simulation), scientific question, market task, LLM's actual role, market/data, baselines and main findings;
- Code and data links, distinguishing full implementation, partial code, supplementary material, and available-on-request resources.

Preprint and published versions of the same paper are merged into one record. Prefer publisher, author-public, and institutional sources; unverified records go to the verify table. Only link to papers; do not redistribute full texts.

## Acknowledgements

The organization of this list references [awesome_energy_LLM](https://github.com/chenweilong915/awesome_energy_LLM). This list takes LLM/generative models as the primary focus and other AI methods as comparison anchors, organized independently by scientific questions in electricity markets. Search covers arXiv, IEEE Xplore, Elsevier (ScienceDirect), Google Scholar, and other sources, and is continuously extended via Chinese-language literature, conference papers, and forward/backward citation search.

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Altrouge7/Papers-of-LLM-in-Electricity-Market&type=Date)](https://star-history.com/#Altrouge7/Papers-of-LLM-in-Electricity-Market&Date)
