# AI in electricity market

> **English（this page）** | [简体中文](README.zh-CN.md)

A curated reading list of AI in electricity markets, with large language models (and generative / foundation models) as the primary focus and other AI methods (deep learning, reinforcement learning, time-series foundation models, agent-based / game theory) as comparison anchors. LLM papers cover **2024 onward**; non-LLM methods span **2020 onward** with earlier milestones.

**Last updated: 2026-09-09. This is a continuously growing literature and resource list, not a complete systematic review.** Reported findings are the authors'; some entries are summarized from abstracts or public versions and have not been reproduced one by one. Preprints and published versions are merged; unverified records are listed separately.

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

### 2024

- **Using Generative Pre-Trained Transformers (GPT) for Electricity Price Trend Forecasting in the Spanish Market** — *Energies*, 17(10), 2338, 2024. [Paper](https://www.mdpi.com/1996-1073/17/10/2338) · [DOI](https://doi.org/10.3390/en17102338)
  - Market: Spain; input from energy news and expert reports.
  - Method: compares in-context examples vs GPT fine-tuning to extract price-trend information and auxiliary variables.
  - Reading focus: relationship between textual opinion and post-publication price trend; not direct exact-price prediction.

- **Large Language Model-Based Bidding Behavior Agent and Market Sentiment Agent-Assisted Electricity Price Prediction** — public 2024; *IEEE Transactions on Energy Markets, Policy and Regulation*, 3(2), 223–235, 2025. [DOI](https://doi.org/10.1109/TEMPR.2024.3518624) · [Author version](https://www.researchgate.net/publication/387130812_Large_Language_Model-based_Bidding_Behavior_Agent_and_Market_Sentiment_Agent-Assisted_Electricity_Price_Prediction)
  - Market: Australian NEM, five-minute prices.
  - Method: fine-tunes an LLM to predict bid behavior and another to extract market sentiment, combined with an improved conditional time-series GAN (CTSGAN).
  - Reading focus: authors report improved price and spike prediction; distinguish "predicting others' bids" from "optimizing one's own bid".

### 2025

- **LLM-Enhanced Feature Engineering for Multi-Factor Electricity Price Predictions** — arXiv, 2025. [Paper](https://arxiv.org/abs/2505.11890)
  - Market: Australian NSW.
  - Method: FAEP uses LLM/RAG-enhanced features (weather, price jumps, etc.) feeding an XGBoost–LSTM.
  - Reading focus: how much gain comes from new information vs LLM feature processing vs the downstream model.

- **NSW-EPNews: A News-Augmented Benchmark for Electricity Price Forecasting with LLMs** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.11050)
  - Data: NSW 2015–2024, >175k half-hour prices, temperature, and WattClarity news; 48-step forecasting.
  - Method: compares conventional models vs LLMs using structured context.
  - Result: news gives limited gain for conventional models; LLM improvement is small and produces hallucinated or malformed price series. Record both positive and negative results.

- **From News to Forecast: Integrating Event Analysis in LLM-Based Time Series Forecasting with Reflection** — NeurIPS, 2024. [Paper](https://arxiv.org/abs/2409.17515) · [Code](https://github.com/daydreamer-amelia/From_News_to_Forecast)
  - Method: extracts events from news and uses a reflection mechanism to aid LLM time-series forecasting; a general framework with energy/power benchmarks.
  - Reading focus: attribution of gains to event analysis, and whether reflection reduces hallucination; a general baseline for event-driven forecasting.

- **Regression Models Meet Foundation Models: A Hybrid-AI Approach to Practical Electricity Price Forecasting** — arXiv, 2026. [Paper](https://arxiv.org/abs/2603.06726) · [Code](https://github.com/thulab/FutureBoosting)
  - Method: hybridizes regression models with time-series foundation models for practical price forecasting.
  - Reading focus: source of gains over pure foundation models; comparison against pure time-series baselines (MSTL, Chronos, etc.).

- **LLM-Enhanced Short-Term Electricity Price Forecasting Method for Australian Electricity Market** — online 2025-12-24; *Applied Sciences*, 16(1), 200, 2026. [Paper](https://www.mdpi.com/2076-3417/16/1/200) · [DOI](https://doi.org/10.3390/app16010200)
  - Market: NSW five-minute prices; main evaluation includes a May 2024 scenario.
  - Method: LLM turns news into event features, combined with weather, periodic variables, quantile regression, and conformal calibration.
  - Reading focus: probabilistic forecasting and interval calibration, plus generalization bounds under a short evaluation window.

### 2026

- **A Few-Shot LLM Framework for Extreme Day Classification in Electricity Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2602.16735)
  - Market: Texas, USA.
  - Method: feeds load, renewables, weather, and recent price statistics into a prompt to judge whether the next day has a price spike.
  - Result: authors report beating SVM/XGBoost in few-shot; the task is extreme-day classification, not full price-trajectory forecasting.

- **Reasoning-enhanced probabilistic electricity price forecasting using parameter-efficient large language models** — *Applied Energy*, 2026. [DOI](https://doi.org/10.1016/j.apenergy.2026.128712)
  - Method: parameter-efficient (PEFT) LLMs enhanced with reasoning for probabilistic price forecasting.
  - Reading focus: probabilistic calibration of reasoning-enhanced vs pure-numeric baselines; the cost–gain tradeoff of PEFT.

- **Electricity Market Price Forecast via LLM-based Sentiment Analysis and TimeXer** — 2025 7th International Conference on Data-driven Optimization of Complex Systems (DOCS), 2025. [DOI](https://doi.org/10.1109/DOCS67533.2025.11200590)
  - Method: LLM extracts market sentiment as features, combined with the TimeXer time-series model.
  - Reading focus: information gain of LLM sentiment over conventional text features; paired-control design with the "bid-behavior and sentiment" entry.

- **Adaptive Frequency-Domain Feature Extraction With Large Language Models for Accurate Electricity Market Forecasting** — *IEEE Transactions on Consumer Electronics*, 2025. [DOI](https://doi.org/10.1109/TCE.2025.3585889)
  - Method: LLM-assisted adaptive frequency-domain feature extraction for price/market forecasting.
  - Reading focus: the boundary of frequency decomposition vs LLM's role; whether it truly adds language reasoning or merely acts as a feature selector.

- **Application of Large Language Models in Intelligent Preprocessing and Forecasting of Electricity Price** — 2025 4th International Conference on Smart Grid and Green Energy (ICSGGE), 2025. [DOI](https://doi.org/10.1109/ICSGGE64667.2025.10984532)
  - Method: LLMs for intelligent preprocessing and forecasting of price data.
  - Reading focus: gains from preprocessing (cleaning/imputation/featurization) vs forecasting separately; robustness under poor data quality.

- **RIS-LLM: Reasoning-informed semantic modeling of electricity market price dynamics** — *Advanced Engineering Informatics*, 2026. [DOI](https://doi.org/10.1016/j.aei.2026.104949)
  - Method: incorporates reasoning into semantic modeling of price dynamics.
  - Reading focus: gain of reasoning over pure-feature/pure-numeric approaches; generalization boundary of semantic modeling.

- **LLM Agent-Driven Dynamic Prediction for Day-Ahead Electricity Prices** — IEEE conference, 2026.
  - Method: LLM-agent-driven dynamic day-ahead price prediction.
  - Reading focus: the difference between LLM-as-a-"prediction agent" versus LLM-as-a-feature-extractor.

- **A large language model-based reprogramming method for electricity price spread prediction** — *Journal of Renewable and Sustainable Energy*, 2026.
  - Method: LLM-based reprogramming for price-spread prediction.
  - Reading focus: arbitrage-oriented spread (rather than level) prediction; transferability of reprogramming.

- **Probabilistic Forecasting of Real-Time Electricity Market Signals via Interpretable Generative AI** — arXiv, 2024. [Paper](https://arxiv.org/abs/2403.05743)
  - Method: interpretable generative AI for probabilistic forecasting of real-time signals (LMPs, interregional spreads, supply-demand imbalance).
  - Reading focus: probabilistic calibration and interpretability; real-time vs day-ahead signals.

- **Assessing time series foundation models for probabilistic electricity price forecasting: Toward a unified benchmark** — *Energies*, 2025. [DOI](https://doi.org/10.3390/en18236269)
  - Method: a unified benchmark assessing time-series foundation models on probabilistic price forecasting.
  - Reading focus: complements "Benchmarking Pre-Trained Time Series Models"; a unified protocol for probabilistic evaluation.

---

## Q2: How do participants bid and decide

Price forecasting is only input; the value lies in **decisions**: when storage charges/discharges, how generators bid, how ancillary services are offered. The difficulty is that trading actions must satisfy market rules, physical constraints, and economic objectives simultaneously, with delayed market feedback. LLMs act here as a "strategy brain" or "coordinator", organizing rule text, state, and feedback into executable actions.

- **LLM-coordination in auto-bidding of frequency regulation: Cross-attention distributional reinforcement agentic learning** — *Applied Energy*, 401, 126702, 2025. [Paper](https://doi.org/10.1016/j.apenergy.2025.126702)
  - Market: South Australian joint energy and Frequency Control Ancillary Services (FCAS) market, battery bidding.
  - Method: LLM coordinates agents, understands instructions and explains feedback; cross-attention extracts market features; SAC-based distributional RL optimizes the policy.
  - Result: authors report revenue beating forecast-then-optimize and other DRL baselines; the LLM and RL module contributions should be tested separately.

- **LLM-Enhanced Trading Decision Framework with Multi-Scale Memory for Electricity Markets** — IEEE SmartGridComm, 2025. [DOI](https://doi.org/10.1109/SmartGridComm65349.2025.11204628) · [Institutional record](https://research.monash.edu/en/publications/llm-enhanced-trading-decision-framework-with-multi-scale-memory-f/)
  - Market: Australian electricity market.
  - Method: short/mid/long-term and reflective memory handle semantic relevance and delayed impact of news.
  - Reading focus: information recency, memory updates, and how text signals affect trading decisions.

- **Large Language Model Assisted Optimal Bidding of BESS in FCAS Market: An AI-agent based Approach** — arXiv, 2024. [Paper](https://arxiv.org/abs/2406.00974)
  - Market: Australian NEM FCAS market, battery energy storage system (BESS) bidding.
  - Method: an LLM agent parses market rules/instructions and generates bidding actions, combined with optimization and RL.
  - Reading focus: decomposing LLM's semantic understanding of rules/state from the downstream bidding module; cross-market transferability.

- **An Explainable Cognitive Bidding Agent for Electricity Markets: A Framework for Zero-Shot Generalization using Large Language Models** — 2025 IEEE 9th Conference on Energy Internet and Energy System Integration (EI²), 2025. [DOI](https://doi.org/10.1109/EI268505.2025.11425567)
  - Scenario: zero-shot generalization of a bidding agent, emphasizing interpretability and cognitive decision processes.
  - Method: LLM as the bidding-decision core, producing interpretable strategic reasoning and testing generalization to unseen markets.
  - Reading focus: the real boundary of zero-shot cross-market generalization; whether interpretability is post-hoc packaging or the source of strategy.

- **Dual-agent LLMs with genetic evolution for automated bidding strategy optimization in electricity markets** — IET Conference Proceedings, 2026. [DOI](https://doi.org/10.1049/icp.2026.1716)
  - Scenario: automated bidding-strategy optimization.
  - Method: dual-agent LLMs combined with genetic evolution to iteratively generate and select bidding strategies.
  - Reading focus: whether genetic selection pressure is driven by real market feedback; convergence and overfitting risk.

---

## Q3: How are market mechanisms and trading designed

When markets shift from centralized to decentralized (P2P, community trading, prosumers), the question is no longer "single-agent optimum" but **how the mechanism gets self-interested distributed participants to coordinate a good aggregate outcome** — efficient and fair at once. The difficulty is designing incentives under information asymmetry, heterogeneous preferences, and physical network constraints, while letting agents "learn" to cooperate or be fair within the mechanism. LLMs often act here as a "demonstrator", "critic", or "fairness evaluator".

- **LLM-Enhanced Multi-Agent Reinforcement Learning with Expert Workflow for Real-Time P2P Energy Trading** — 2025 preprint; *IEEE Transactions on Smart Grid*, Early Access, 2026. [Paper](https://arxiv.org/abs/2507.14995) · [DOI](https://doi.org/10.1109/TSG.2026.3684885) · [Supplementary materials](https://github.com/jzk0806/P2P-llm-supplementary)
  - Scenario: real-time P2P trading under distribution-network constraints.
  - Method: LLM generates personalized expert strategies, guides MARL via imitation, and a differential-attention critic is used.
  - Result: authors report lower trading cost and voltage-limit violations. The repo link is supplementary material, not a full reproducible implementation.

- **Scalable Fairness Shaping with LLM-Guided Multi-Agent Reinforcement Learning for Peer-to-Peer Electricity Markets** — arXiv, 2025. [Paper](https://arxiv.org/abs/2508.18610)
  - Scenario: P2P prosumer trading under continuous double auction.
  - Method: an LLM critic scores grid, inter-seller, and pricing fairness, folded into the reward.
  - Reading focus: the fairness-vs-economic-incentive tradeoff and the stability of LLM evaluation.

- **Large Language Model Assisted Peer-to-Peer Energy Trading System** — *Journal of Energy Engineering*, 152(4), 2026. [Paper](https://ascelibrary.org/doi/abs/10.1061/JLEED9.EYENG-6440)
  - Scenario: household P2P trading under supply-demand-ratio pricing.
  - Method: two-stage prompting, multi-round load forecast, numeric post-processing, linked to load scheduling.
  - Reading focus: how forecast error propagates to trading outcomes; some data/implementation requires request.

- **FairMarket-RL: LLM-Guided Fairness Shaping for Multi-Agent Reinforcement Learning in Peer-to-Peer Markets** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.22708)
  - Scenario: MARL in P2P markets, LLM-guided fairness shaping.
  - Method: LLM evaluates trading fairness and shapes the MARL reward.
  - Reading focus: relation/difference with the same group's "Scalable Fairness Shaping"; scalability and evaluation stability of fairness shaping.

- **Equity-Aware Peer-to-Peer Energy Trading Market to Mitigate Energy Poverty: An LLM–RL Agentic Workflow** — *IEEE Transactions on Energy Markets, Policy and Regulation*, 2026. [DOI](https://doi.org/10.1109/TEMPR.2025.3633992)
  - Scenario: equity-aware P2P energy trading aimed at mitigating energy poverty.
  - Method: an LLM–RL agentic workflow explicitly embeds fairness/equity objectives into trading decisions.
  - Reading focus: the fairness-vs-incentive tradeoff; quantifiable validation of the social "mitigate energy poverty" goal.

- **Large Language Models as Strategic Bidding Agents in P2P Energy Trading Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2609.05462)
  - Scenario: LLMs as strategic bidding agents in P2P energy trading.
  - Method: LLMs directly act as prosumer bidding agents; studies their strategic bids and market outcomes.
  - Reading focus: whether LLM bids are strategically rational; comparison against MARL and game-theoretic baselines.

- **Integrating large language models into Peer-to-Peer energy management for multi-tenant buildings: A guardrail approach to ensuring resilience** — *Neural Networks*, 2026. [Paper](https://doi.org/10.1016/j.neunet.2026.108814)
  - Scenario: P2P energy management in multi-tenant buildings, emphasizing guardrails and resilience.
  - Method: embeds LLMs into P2P energy management and uses constraint/guardrail mechanisms to preserve resilience under anomalies.
  - Reading focus: how guardrails constrain erroneous LLM output; how resilience is quantified.

- **AI agents in Algorithmic Electricity Markets: On the Emergence of Tacit Collusion** — arXiv, 2026. [Paper](https://arxiv.org/abs/2608.26896)
  - Scenario: the algorithmic turn of oligopolistic markets and the risk of tacit collusion once learning-based bidding agents dominate.
  - Method: models strategic bidding as a repeated game and studies whether independently-learning agents spontaneously sustain tacit collusion.
  - Reading focus: competitive-compliance of LLM/RL bidding agents; the "individual rationality → aggregate collusion" mechanism warning — the most important new gap to track in this list.

- **Draining the Energy Commons: Self-Defeating Over-Appropriation as a Coordination Failure in Agentic LLM Collectives** — arXiv, 2026. [Paper](https://arxiv.org/abs/2607.22188)
  - Scenario: coordination failure of LLM prosumer collectives over a shared renewable-energy commons.
  - Method: same-family GPT/Gemini/Grok agents act as prosumers maximizing their own objective; observes over-appropriation of the shared resource.
  - Reading focus: tragedy of the commons in LLM collective decisions; how this complements P2P fairness mechanisms.

- **Interactive learning-implementation of ChatGPT and reinforcement learning in local energy trading** — 2024 IEEE 34th Australasian Universities Power Engineering Conference (AUPEC), 2024. [DOI](https://doi.org/10.1109/AUPEC62273.2024.10807616)
  - Scenario: interactive ChatGPT+RL learning in local energy trading.
  - Method: combines a conversational LLM with RL for local-prosumer trading decisions.
  - Reading focus: the division of labor in interactive LLM+RL learning; whether conversational guidance truly improves the policy.

- **An explainable equity-aware P2P energy trading framework for socio-economically diverse microgrid** — arXiv, 2025. [Paper](https://arxiv.org/abs/2507.18738)
  - Scenario: interpretable, equity-aware P2P framework for socio-economically diverse microgrids.
  - Method: explicitly models and explains fairness/equity in P2P trading, handling participant heterogeneity.
  - Reading focus: interpretability of fairness metrics; positional difference from the "Equity-Aware P2P" entry above.

---

## Q4: How are markets modeled, simulated, and behavior-calibrated

Even with single-agent decision models, we still need to understand **emergent whole-market behavior**: how prices change after a rule adjustment, how heterogeneous participants interact, and whether bid behavior matches reality. The difficulty is that a market model must be simultaneously calibrated (credible) and executable. LLMs here automate the "rule document → mathematical model → executable simulation" chain, and act as generative participants to study behavioral biases.

- **Leveraging Large Language Model Based Agent for Automated Electricity Market Modelling and Simulation** — *Journal of Modern Power Systems and Clean Energy*, 14(1), 50–62, 2026. [Paper](https://doi.org/10.35833/MPCE.2025.000639)
  - Method: MSS-Agent extracts models from rule documents and generates simulation code via hierarchical chain-of-thought, tool use, and reflective debugging.
  - Reading focus: accuracy of "rule → math model → executable simulation", code reliability, and modeling efficiency.

- **Behavioral Generative Agents for Power Dispatch and Auction** — arXiv, 2026. [Paper](https://arxiv.org/abs/2603.08477)
  - Scenario: household battery management and grid-access-right auctions.
  - Method: in-context learning shapes rule-based, myopic, or strategic behavior, benchmarked against dynamic programming and bidding.
  - Result: proof-of-concept shows rational strategies and systematic behavioral biases; not a market simulator calibrated on real participants.

- **A Generative AI Agent-Based Simulation for Electricity Market and Load Forecasting Game Strategy** — Proceedings of the 2025 International Conference on Digital Society and Intelligent Computing, 2025. [DOI](https://doi.org/10.1145/3788910.3788914)
  - Scenario: multi-agent simulation of market and load-forecasting game strategies.
  - Method: generative-AI agents participate in market and forecasting games; studies how strategic interaction shapes outcomes.
  - Reading focus: whether agent behavior is calibrated on real participants; correspondence of the game setup to real market mechanisms.

- **LLM-Augmented Multi-Agent System for Trading Behavior Modeling in Coupled Electricity-Carbon Markets** — *Journal of Modern Power Systems and Clean Energy*, 2026. [DOI](https://doi.org/10.35833/MPCE.2025.000645)
  - Scenario: trading-behavior modeling and strategy formation in coupled electricity-carbon markets.
  - Method: LLM-augmented multi-agent system updates beliefs via bounded-rational learning and iteratively adjusts expectations/strategies.
  - Reading focus: difference/similarity with "LLM-CECM"; whether bid behavior in coupled markets is empirically calibrated.

- **Behavioral Generative Agents for Energy Operations** — arXiv, 2025. [Paper](https://arxiv.org/abs/2506.12664)
  - Scenario: consumer/participant behavior modeling in energy operations, including behavioral heterogeneity in low-frequency, high-impact events.
  - Method: uses generative agents to supplement or replace conventional behavioral models and studies their value/limits in operational decisions.
  - Reading focus: calibration of generative agents against real participants; same group as "Power Dispatch and Auction" but more operations-oriented.

- **Large language models empowered agent-based modeling and simulation: A survey and perspectives** — *Humanities and Social Sciences Communications*, 2024. [DOI](https://doi.org/10.1057/s41599-024-03611-3)
  - Method: a survey of LLM-empowered ABM simulation (~550 citations); the entry point to the "LLM+ABM" paradigm.
  - Reading focus: methodological background for Q4; electricity markets are one application domain.

- **Simulating financial market via large language model based agents** — arXiv, 2024. [Paper](https://arxiv.org/abs/2406.19966)
  - ⚠️ Adjacent domain (equity/financial market, not electricity); kept only as a methodological reference for LLM market simulation.
  - Method: simulates a stock market with LLM agents (~51 citations).
  - Reading focus: whether adjacent-domain (finance) LLM market simulation transfers to electricity markets.

---

## Q5: Can models understand rules and policy, and be evaluated

This is the "meta" question: before using LLMs for trading, ask whether they truly understand market rules, can quantify policy, and how to evaluate them credibly. The difficulty is that domain-knowledge evaluation is hard, and "answering correctly" does not equal "making money in a real market". Here the LLM is the "object under evaluation".

- **ELM-Bench: A Multidimensional Methodological Framework for Large Language Model Evaluation in Electricity Markets** — *Energies*, 18(15), 3982, 2025. [Paper](https://www.mdpi.com/1996-1073/18/15/3982)
  - Scenario: Chinese electricity market; understanding, generation, and safety dimensions; 7 task types, 2841 samples.
  - Method: compares general models with the domain-fine-tuned QwenGOLD.
  - Reading focus: domain capability and fine-tuning gains; QA/decision scores do not equal real trading returns.

- **基于大语言模型与可解释机器学习的中国大陆电力政策量化框架与效力研究** (A framework for quantifying mainland-China electricity policy and its effectiveness using LLMs and interpretable ML) — 2026. [Journal article](https://skjournal.upc.edu.cn/article/html/20260102)
  - Method: prompt engineering, fine-tuning, topic analysis, and interpretable ML to quantify policy text and effectiveness.
  - Reading focus: "policy text → policy variable → empirical analysis"; more policy-economic research than real-time trading.

- **Engineering Trustworthy Retrieval-Augmented Generation for EU Electricity Market Regulation** — *Electronics*, 15(4), 749, 2026. [Paper](https://www.mdpi.com/2079-9292/15/4/749)
  - Scenario: trustworthy RAG for EU electricity-market regulation.
  - Method: builds a RAG system to answer regulatory text, focusing on trustworthiness and citation reliability.
  - Reading focus: accuracy and hallucination risk in regulatory QA; whether it supports decision migration under rule changes.

- **ElectriQ: A Benchmark for Assessing the Response Capability of Large Language Models in Power Marketing** — arXiv, 2025. [Paper](https://arxiv.org/abs/2507.22911)
  - Scenario: LLM response capability in electric-power marketing (EPM), covering cross-scenario long dialogues and policy/rule knowledge.
  - Method: builds a power-marketing QA/dialogue benchmark to test LLM handling of rules, prices, and customer inquiries.
  - Reading focus: positioning difference from ELM-Bench; whether marketing-scenario evaluation touches real trading decisions.

- **How Do Tool-Augmented LLM Agents Perform on Real-World Energy Analytics Tasks?** — arXiv, 2026. [Paper](https://arxiv.org/abs/2606.26346)
  - Scenario: live data retrieval, regulatory/market knowledge, and multi-step quantitative reasoning in energy.
  - Method: empirically evaluates tool-augmented LLM agents on real energy-analysis tasks, going beyond static knowledge recall.
  - Reading focus: reliability of tool use, live data, and multi-step reasoning; complementarity with EnergyAgentBench.

- **ElecBench: A Power Dispatch Evaluation Benchmark for Large Language Models** — arXiv, 2024. [Paper](https://arxiv.org/abs/2407.05365)
  - Scenario: LLM evaluation in power dispatch (including market dynamics).
  - Method: builds a dispatch-decision benchmark to test LLM instruction-following and domain decision capability.
  - Reading focus: dispatch rather than pure market trading; evidence of "rule understanding" rather than trading returns.

- **A Benchmark for Document Understanding of Large Language Models in the Field of Electric Power** — Springer (International Symposium on Artificial Intelligence), 2025.
  - Method: an LLM benchmark for electric-power document understanding.
  - Reading focus: whether document understanding covers market rules, settlement documents, and other professional text.

- **WeQA: A benchmark for retrieval augmented generation in wind energy domain** — Workshop on NLP for Positive Impact (NLP4PI), 2025. [DOI](https://doi.org/10.18653/v1/2025.nlp4pi-1.20)
  - Method: a wind-energy RAG benchmark; a reference for energy-domain RAG evaluation (not pure electricity market).
  - Reading focus: citation-reliability evaluation patterns that can transfer to market-regulation RAG.

---

## Support: time-series foundation models and baselines

The following are for baseline and evaluation design; they are not evidence of "language-reasoning-enhanced trading" by themselves. They answer "how well can we do without language", the anchor for judging whether an LLM truly adds value.

- **Energy Price Modelling: A Comparative Evaluation of four Generations of Forecasting Methods** — arXiv, 2024. [Paper](https://arxiv.org/abs/2411.03372)
  - Compares forecasting methods on European energy markets; baseline for econometric, ML, sequence, and Transformer approaches.
- **Benchmarking Pre-Trained Time Series Models for Electricity Price Forecasting** — 2025, public preprint. [Paper](https://arxiv.org/abs/2506.08113)
  - Day-ahead prices in five European countries in 2024; compares Chronos, TimesFM, Moirai, etc.
  - Authors report no time-series foundation model statistically beats their double-seasonal MSTL baseline.
- **Forecasting Day-Ahead Residential Electricity Prices Using a Large Language Model** — SSRN working paper, 2025. [Paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5158359)
  - Uses Chronos; beats ARIMA and Gaussian Processes on London residential prices, but fine-tuning has cross-segment generalization issues.
- **PriceFM: Foundation Model for Probabilistic Electricity Price Forecasting** — arXiv, 2025. [Paper](https://arxiv.org/abs/2508.04875) · [Code](https://github.com/runyao-yu/PriceFM)
  - A time-series foundation model for probabilistic price forecasting; a strong baseline to compare against language-reasoning enhancements.
- **Foundation models for electricity price forecasting and battery arbitrage: Can they replace market-specific forecasting models?** — arXiv, 2026. [Paper](https://arxiv.org/abs/2609.00089)
  - Tests whether time-series FMs replace market-specific models, and their economic value in battery arbitrage.
  - Directly addresses the "forecast→profit" research question; distinguishes statistical accuracy from arbitrage profit.
- **A systematic review of transformers and large language models in the energy sector: towards agentic digital twins** — *Applied Energy*, 2025. [Paper](https://doi.org/10.1016/j.apenergy.2025.126670)
  - A systematic review of transformers/LLMs in energy (market and agent directions); an entry point to the domain landscape.

### LLM surveys in energy/power (panorama entry points)

- **Exploring the capabilities and limitations of large language models in the electric energy sector** — *Joule*, 2024. [DOI](https://doi.org/10.1016/j.joule.2024.05.009)
  - Systematically characterizes LLM capabilities and limits in electric energy (~202 citations); the must-read entry for "what LLMs can/can't do".
- **Review of LLMs applications in electrical power & energy systems** — *IEEE Access*, 2025. [DOI](https://doi.org/10.1109/ACCESS.2025.3599922)
  - A survey of LLM applications in power/energy systems (~25 citations).
- **A comprehensive review on the application of large language models in power systems** — *IEEE Access*, 2025. [DOI](https://doi.org/10.1109/ACCESS.2025.3637226)
  - A comprehensive review of LLM applications in power systems.
- **Opportunities of applying Large Language Models in building energy sector** — *Renewable and Sustainable Energy Reviews*, 2025. [DOI](https://doi.org/10.1016/j.rser.2025.115558)
  - LLM opportunities in building energy (~68 citations); building-focused but offers adjacent-domain transfer views.

---

## Comparison: non-LLM methods

These works do not use (or do not center on) language models; they solve electricity-market problems with deep learning, reinforcement learning, time-series foundation models, or game-theoretic / multi-agent simulation. They serve as **comparison anchors**: they tell us whether an LLM's gain comes from "language/semantic understanding" or from what mature numeric methods already do well. Mostly 2020 onward; earlier works are kept only as milestone surveys/benchmarks.

### Surveys and benchmarks (entry points)

- **Forecasting day-ahead electricity prices: A review of state-of-the-art algorithms, best practices and an open-access benchmark** — *Applied Energy*, 293, 116983, 2021. [Paper](https://arxiv.org/abs/2008.08004)
  - A review + open benchmark for day-ahead price forecasting; datasets and best-practice baselines for later DL/LLM work.
- **Reinforcement learning in deregulated energy market: A comprehensive review** — *Applied Energy*, 329, 120212, 2023. [Paper](https://doi.org/10.1016/j.apenergy.2022.120212)
  - A review of RL (incl. DRL/MARL) in deregulated energy markets, covering bidding, arbitrage, and simulation; the RL comparison entry point.
- **Multi-agent systems in Peer-to-Peer energy trading: A comprehensive survey** — *Engineering Applications of Artificial Intelligence*, 132, 2024. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0952197624000058)
  - A survey of multi-agent systems in P2P energy trading; forms a method-spectrum comparison with LLM-driven P2P.
- **Machine learning applications for electricity market agent-based models: A systematic literature review** — arXiv, 2022. [Paper](https://arxiv.org/abs/2206.02196)
  - A systematic review of ML (incl. RL) in electricity-market ABMs; the non-LLM comparison for "market modeling and behavior simulation".
- **Graph Reinforcement Learning for Power Grids: A Comprehensive Survey** — arXiv, 2024. [Paper](https://arxiv.org/abs/2407.04522)
  - A survey of graph RL for power grids; the RL method landscape across power systems and markets.

### Deep-learning price forecasting (non-LLM)

- The DL baselines (DNN/RNN/CNN) in the **Forecasting day-ahead electricity prices** survey are the most common non-LLM forecasting comparisons.
- **A comparison of modern deep neural network architectures for energy spot price forecasting** — compares DNN/RNN/CNN on spot-price forecasting; "what pure-numeric DL can do".

### Reinforcement-learning bidding and storage

The following are milestone RL-bidding works (many with hundreds of citations), the hard baselines for judging the incremental value of any LLM bidding method:

- **Deep Reinforcement Learning for Strategic Bidding in Electricity Markets** — *IEEE Transactions on Smart Grid*, 11(2), 2020. [DOI](https://doi.org/10.1109/TSG.2019.2936142)
  - The foundational DRL strategic-bidding work (~389 citations); the mandatory RL-bidding baseline.
- **Deep Reinforcement Learning for Joint Bidding and Pricing of Load Serving Entity** — *IEEE Transactions on Smart Grid*, 10(6), 2019. [DOI](https://doi.org/10.1109/TSG.2019.2903756)
  - DRL for joint bidding+pricing of a load-serving entity (~143 citations).
- **Approximating Nash Equilibrium in Day-ahead Electricity Market Bidding with Multi-agent Deep Reinforcement Learning** — *Journal of Modern Power Systems and Clean Energy*, 9(3), 2021. [DOI](https://doi.org/10.35833/MPCE.2020.000502)
  - MADRL approximating Nash equilibrium of day-ahead bidding (~140 citations); the "multi-agent bidding equilibrium" comparison.
- **Multi-Agent Deep Reinforcement Learning for Simulating Centralized Double-Sided Auction Electricity Market** — *IEEE Transactions on Power Systems*, 2025. [DOI](https://doi.org/10.1109/TPWRS.2024.3404472)
  - MADRL simulating a centralized double-sided auction; a non-LLM "market simulation" comparison.
- **Optimizing bidding strategy in electricity market based on graph convolutional neural network and deep reinforcement learning** — *Applied Energy*, 379, 2025. [DOI](https://doi.org/10.1016/j.apenergy.2024.124978)
  - Graph convolution + DRL bidding, combining network structure with policy optimization.
- **Intelligent strategic bidding in competitive electricity markets using multi-agent simulation and deep reinforcement learning** — *Applied Soft Computing*, 2024. [DOI](https://doi.org/10.1016/j.asoc.2024.111235)
  - Multi-agent simulation + DRL strategic bidding.
- **A strategic day-ahead bidding strategy and operation for battery energy storage system by reinforcement learning** — *Electric Power Systems Research*, 196, 2021. [DOI](https://doi.org/10.1016/j.epsr.2021.107229)
  - Foundational RL work for BESS day-ahead bidding and operation (~71 citations); the mandatory storage-arbitrage comparison.
- **Multi-market bidding behavior analysis of energy storage system based on inverse reinforcement learning** — *IEEE Transactions on Power Systems*, 2022. [DOI](https://doi.org/10.1109/TPWRS.2022.3150518)
  - Inverse RL analyzing multi-market storage bidding (~53 citations).
- **Temporal-aware deep reinforcement learning for energy storage bidding in energy and contingency reserve markets** — *IEEE Transactions on Energy Markets, Policy and Regulation*, 2024. [DOI](https://doi.org/10.1109/TEMPR.2024.3372656)
  - Temporal-aware DRL for storage joint energy/reserve bidding.
- **Attentive convolutional deep reinforcement learning for optimizing solar-storage systems in real-time electricity markets** — *IEEE Transactions on Industrial Informatics*, 2024. [DOI](https://doi.org/10.1109/TII.2024.3352229)
  - Attentive-conv DRL optimizing solar-storage participation in real-time markets.
- **Multi-agent deep reinforcement learning-based autonomous decision-making framework for community virtual power plants** — *Applied Energy*, 2024. [DOI](https://doi.org/10.1016/j.apenergy.2024.122813)
  - MADRL autonomous-decision framework for community VPPs (~55 citations).
- **Energy storage arbitrage in two-settlement markets: A transformer-based approach** — *Electric Power Systems Research*, 2024. [DOI](https://doi.org/10.1016/j.epsr.2024.110755)
  - Transformer for storage arbitrage in two-settlement markets; a "Transformer without language" arbitrage comparison.
- **Interpretable Hybrid Experimental Learning for Trading Behavior Modeling in Electricity Market** — *IEEE Transactions on Power Systems*, 38(4), 2023. [DOI](https://doi.org/10.1109/TPWRS.2022.3173654)
  - Interpretable trading-behavior modeling (no LLM).

- **Learn to Bid: Deep Reinforcement Learning with Transformer for Energy Storage Bidding in Energy and Contingency Reserve Markets** — NeurIPS 2022 (Climate Change AI). [Paper](https://www.climatechange.ai/papers/neurips2022/62)
  - DRL+Transformer for storage joint energy/reserve bidding; a "Transformer+RL without language" comparison.
- **Deep Reinforcement Learning for Wind and Energy Storage Coordination in Wholesale Energy and Ancillary Service Markets** — arXiv, 2022. [Paper](https://arxiv.org/abs/2212.13368)
  - DRL dispatch/bidding of wind+storage in energy and ancillary markets.
- **Reinforcement Learning-Based Bi-Level strategic bidding model of Gas-fired unit in integrated electricity and natural gas markets preventing market manipulation** — *Applied Energy*, 336, 120822, 2023. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0306261923001770)
  - Bi-level strategic bidding of a gas-fired unit preventing market manipulation; an RL comparison for conventional generators.
- **Proximal policy optimization based reinforcement learning for joint bidding in energy and frequency regulation markets** — Monash (journal version). [Record](https://research.monash.edu/en/publications/proximal-policy-optimization-based-reinforcement-learning-for-joi)
  - PPO for joint energy+frequency-regulation bidding; a non-LLM RL comparison for FCAS-like scenarios.
- **MARS-DA: A Hierarchical Reinforcement Learning Framework for Risk-Aware Multi-Agent Bidding in Power Grids** — arXiv, 2026. [Paper](https://arxiv.org/abs/2605.03142)
  - Risk-aware multi-agent bidding for day-ahead/real-time spreads under renewables volatility; a "risk-managed bidding" non-LLM comparison.
- **A Dual-Positive Monotone Parameterization for Multi-Segment Bids and a Validity Assessment Framework for Reinforcement Learning Agent-based Simulation of Electricity Markets** — arXiv, 2026. [Paper](https://arxiv.org/abs/2604.10252)
  - Legality parameterization of multi-segment monotone bids in RL-ABS; a methodological comparison for market-mechanism RL simulation.
- **Evaluation of Electricity Market Clearing Mechanisms via Reinforcement Learning: Prices, Remuneration and Competitive Dynamics** — arXiv, 2026. [Paper](https://arxiv.org/abs/2602.01392)
  - Uses RL agents to evaluate Pay-as-Clear and other clearing mechanisms; a non-LLM comparison for "mechanism design".

### Multi-agent RL and P2P

- **Renewable energy integration and microgrid energy trading using multi-agent deep reinforcement learning** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261922005256)
  - MADRL microgrid energy trading; a pure-RL comparison for LLM-MARL P2P.
- **Multi-agent deep deterministic policy gradient algorithm for peer-to-peer energy trading considering distribution network constraints** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261922005025)
  - MADDPG P2P trading with distribution constraints; the constraint-handling comparison for LLM-Enhanced P2P.
- **Multi-agent deep reinforcement learning for efficient multi-timescale bidding of a hybrid power plant in day-ahead and real-time markets** — *Applied Energy*, 2022. [Paper](https://www.sciencedirect.com/science/article/abs/pii/S0306261922004603)
  - MADRL multi-timescale bidding of a hybrid power plant.
- **Indirect customer-to-customer energy trading with reinforcement learning** — *IEEE Transactions on Smart Grid*, 2019. [DOI](https://doi.org/10.1109/TSG.2018.2857449)
  - RL for indirect C2C energy trading (~206 citations); the foundational local-energy-market RL work.
- **Multi-agent deep reinforcement learning for coordinated energy trading and flexibility services provision in local electricity markets** — *IEEE Transactions on Smart Grid*, 2023. [DOI](https://doi.org/10.1109/TSG.2022.3149266)
  - MADRL coordinating energy trading and flexibility in local markets (~140 citations).
- **A scalable privacy-preserving multi-agent deep reinforcement learning approach for large-scale peer-to-peer transactive energy trading** — *IEEE Transactions on Smart Grid*, 2021. [DOI](https://doi.org/10.1109/TSG.2021.3103917)
  - Privacy-preserving MADRL for large-scale P2P transactive energy (~211 citations).
- **Reinforcement learning-driven local transactive energy market for distributed energy resources** — *Energy and AI*, 2022. [Paper](https://www.sciencedirect.com/science/article/pii/S2666546822000197)
  - RL for a local transactive-energy market for distributed resources.

### Market power and computational market simulation

- **A reinforcement learning model to assess market power under auction-based energy pricing** — *IEEE Transactions on Power Systems*, 22(1), 2007. [DOI](https://doi.org/10.1109/TPWRS.2006.888977)
  - The foundational RL market-power assessment under auction pricing (~196 citations); the classic "market power / competitive dynamics" comparison.
- **An Adaptive Q-Learning Algorithm Developed for Agent-Based Computational Modeling of Electricity Market** — *IEEE Transactions on Systems, Man, and Cybernetics, Part C*, 40(5), 2010. [DOI](https://doi.org/10.1109/TSMCC.2010.2044174)
  - Adaptive Q-learning for electricity-market ABM computational modeling (~125 citations).

---

## Support: datasets, benchmarks and tools

Reproducible datasets, benchmarks, toolkits, and trading-simulation environments; for reproducing papers, building baselines, and training/evaluating trading agents.

### Price-forecasting datasets and benchmarks

- **Global Day-Ahead Electricity Price Dataset** — IEEE DataPort. Multi-region day-ahead prices for uniform cross-region access. [Dataset](https://ieee-dataport.org/documents/global-day-ahead-electricity-price-dataset) · [Mendeley](https://data.mendeley.com/datasets/s54n4tyyz4/3)
- **UniElecPrice: Unified Cross-Regional Time-Series Day-Ahead Electricity Price Dataset** — IEEE Open Journal descriptor. [Descriptor](https://ieeexplore.ieee.org/document/11169754)
- **NOR_EPF** — a day-ahead price-forecasting benchmark for Norway's five bidding zones (code + data). [Repo](https://github.com/myptd/NOR_EPF)
- **2024 IISE PG&E Electricity Price Forecasting Challenge** — PG&E-sponsored price-forecasting challenge dataset. [Repo](https://github.com/RIA-Research-Group/2024-IISE-PGE-Electricity-Price-Forecasting-Challenge)
- **OpenSTEF / Liander 2024 Energy Forecasting Benchmark** — energy load/price forecasting benchmark (Hugging Face). [Dataset](https://huggingface.co/datasets/cat1233211/liander2024-energy-forecasting-benchmark)

### LLM / agent evaluation benchmarks

- **SolarChain-Eval: A Physics-Constrained Benchmark for Trustworthy Economic Agents in Decentralized Energy Markets** — arXiv, 2026. Physics-constrained evaluation of economic agents in decentralized energy markets. [Paper](https://arxiv.org/abs/2607.08681)
- **EnergyAgentBench: Benchmarking LLM Agents on Live Energy Infrastructure Data** — arXiv, 2026. Multi-step tool-use evaluation on live energy data (siting, cost-carbon tradeoffs, long-horizon portfolios); not a short-term bidding benchmark. [Paper](https://arxiv.org/abs/2605.15230)
- **energy-markets-eval** — Hugging Face dataset, energy-market evaluation samples (30 samples, 6 domains). [Dataset](https://huggingface.co/datasets/karthikchundi/energy-markets-eval)
- **DSM-EQA** — demand-side-management energy QA evaluation set (GitHub). [Repo](https://github.com/samarhashmi/DSM-EQA)

### Trading-simulation environments and toolkits

- **ASSUME** — agent-based simulation for market dynamics and market design, RL-capable. [GitHub](https://github.com/assume-framework/assume) · [Paper](https://www.sciencedirect.com/science/article/pii/S2352711025001438)
- **POMATO** — a power-market tool for zonal market clearing and analysis (Python+Julia). [GitHub](https://github.com/richard-weinhold/pomato) · [SoftwareX](https://doi.org/10.1016/j.softx.2021.100870)
- **AMES** — agent-based simulation of US wholesale power markets. [GitHub](https://github.com/ames-market/AMES-V5.0)
- **lemlab** — multi-agent development/testing for local (P2P) energy-market applications. [GitHub](https://github.com/tum-ewk/lemlab)
- **energy-py** — RL framework for energy systems (battery, VPP, etc.). [GitHub](https://github.com/ADGEfficiency/energy-py)
- **marl_clearing_and_bidding** — reproduction repo for market clearing+bidding with model-based RL. [GitHub](https://github.com/Digitalized-Energy-Systems/marl_clearing_and_bidding)

### LLM / agent trading environments and benchmarks

The following resources sit closer to "LLM agent × electricity market" evaluation and execution. Note: right now the ecosystem still **lacks LLM-native electricity-market trading environments** (double-auction, clearing, bidding); most are general/DRL market simulators adapted to LLMs, or power-system (power-flow/dispatch) agent benchmarks.

- **OPLEM: Open Platform for Local Energy Markets** — *Applied Energy*, 2024. An open simulation platform for local energy markets (P2P, demand response, storage agents); a market substrate for LLM trading agents. [Paper](https://www.sciencedirect.com/science/article/pii/S0306261924012315) · [GitHub](https://github.com/PSALOxford/OPLEM)
- **Agentic AI for Price-Only 15 min SDAC Market Diagnostics in Central and Eastern Europe** — MDPI, 2026. Agentic diagnostics for the SDAC single day-ahead coupling market. [Paper](https://www.mdpi.com/2571-5577/9/5/93)
- **PowerAgentBench (incl. -SS / -Dyn)** — a multi-step operational benchmark for power-system agents (steady-state/dynamic). A power-system (not market-trading) agent benchmark, but offers reusable agent task/env/metric patterns. [GitHub](https://github.com/Power-Agent/PowerAgentBench) · [Paper (SS)](https://arxiv.org/abs/2606.18789)
- **NTU P2P Energy Agent (World Avatar)** — a P2P energy-trading agent implementation under the Cambridge CARES project (TheWorldAvatar stack). [Repo](https://github.com/cambridge-cares/TheWorldAvatar/tree/main/Agents/NTUP2PEnergyAgent)
- **BESS-Coding-Agent** — a BESS coding-agent prototype for the energy market. [GitHub](https://github.com/NavishaShetty/BESS-Coding-Agent)

---

## Papers to verify

Retained but not yet verified on full text, publication date, or experiments; do not use these for effect comparisons.

| Year | Paper | Source | To verify |
| --- | --- | --- | --- |
| 2024 | Large Language Model for Extreme Electricity Price Forecasting in the Australia Electricity Market | [IEEE IECON 2024 / DOI](https://doi.org/10.1109/IECON55916.2024.10906045) | full method, data, baselines |
| 2025 | A Large Language Model-Based Agent for Automated Bidding Strategy Generation in Electricity Markets | [IEEE ICPIES 2025 / DOI](https://doi.org/10.1109/ICPIES65420.2025.11070004) | full method, strategy evaluation |
| 2025 | Large Language Model Based Data Augmentation for Peak Electricity Price Forecasting and Battery Energy Storage Arbitrage | [IEEE SMC 2025 / DOI](https://doi.org/10.1109/SMC58881.2025.11342789) | data-augmentation mechanism, arbitrage experiments |
| 2026 | LLM-CECM: A simulation framework for strategic generation behavior in coupled electricity-carbon markets | [Publisher page](https://www.sciencedirect.com/science/article/pii/S0960148126009651) | online date, full simulation setup and validation |
| 2025 | A Review of Large Language Models for Energy Systems: Applications, Challenges, and Future Prospects | [IEEE Access / DOI](https://doi.org/10.1109/ACCESS.2025.3610994) | whether it has an electricity-market section; entry vs. standalone |
| 2025 | Virtual Power Plant Trading Strategy in the Electricity Market Based on Prompt-LLM & MAPPO | [Journal page](https://opaj.napstic.cn/periodicalArticle/0120260601343662) | Chinese record, journal full name, experiments/baselines (note: not the same as the Crossref-matched PowerCon DRL paper) |
| 2025 | An In-Context LLM for PV-BESS Operations: Adaptive Day-Ahead Strategy Recommendation for Economic Optimization | [IEEE Access / DOI](https://doi.org/10.1109/ACCESS.2025.3638429) | market bidding vs. pure operation optimization |
| 2025 | Modeling and optimization of virtual power plant energy market behavior based on news sentiment and natural semantic analysis | [Sustainable Energy Tech. & Assess. / DOI](https://doi.org/10.1016/j.seta.2025.104718) | LLM's exact role, experiments/baselines |
| 2026 | A Semantic Risk-Aware Optimization Framework for Virtual Power Plant Dispatch Using Large Language Models | [MDPI Energies / DOI](https://doi.org/10.3390/en19122820) | market dispatch vs. pure operation, baselines |
| 2026 | Large Language Model Applications in Power Systems: A Comprehensive Review and Outlook | [J. Modern Power Systems & Clean Energy / DOI](https://doi.org/10.35833/MPCE.2025.000760) | electricity-market section share; entry vs. standalone |
| 2026 | Integrating Multi-Agent Reinforcement Learning and Evolutionary Game Theory for Adaptive Virtual Bidding Strategies in Electricity Markets | [J. Power and Energy Engineering / DOI](https://doi.org/10.4236/jpee.2026.144001) | contains LLM or pure MARL |
| 2024 | Agents are all you need: Elevating Trading Dynamics with Advanced Generative AI-Driven Conversational LLM Agents and Tools | [IEEE I2CT / DOI](https://doi.org/10.1109/I2CT61223.2024.10543356) | whether "Trading Dynamics" refers to electricity/energy trading (abstract unverified) |

---

## Open research gaps

Gaps remaining after organizing by scientific question (not claimed to be verified). The "research question" column lists checkpoints worth validating after reading; the "gap" column lists what the ecosystem has not yet covered.

| Scientific question | Research question | Current gap |
| --- | --- | --- |
| Price formation & forecasting | information gain, event timeliness | no unified cross-market "text→price" benchmark; negative results under-recorded |
| Bidding & decision | forecast→profit, rule migration | LLM-native bidding environments scarce; gains mostly validated in simulation, not real markets |
| Mechanism & trading design | fairness vs incentive | fairness evaluation unstable; LLM/learning-agent tacit-collusion risk just raised, no systematic assessment |
| Modeling & simulation | behavior calibration | LLM-simulated bid distributions/prices rarely calibrated against real data |
| Rules, policy & evaluation | domain capability vs trading profit | the gap between QA scores and real trading returns is unquantified |

Specific checkpoints:

1. **Information gain**: under identical data and downstream models, does an LLM beat keywords, conventional text encoders, and handcrafted event variables?
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
