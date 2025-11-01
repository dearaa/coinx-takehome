Dea Rahma's Assessment

# Coin X Takehome – Trading Concentration & Anomaly Risk Analysis

## 📌 Objective
This project analyzes **trading concentration risk** and **anomaly detection** in a SaaS-based cryptocurrency trading platform.  
The goal is to assess whether a few users dominate trading activity and to detect abnormal trade patterns that could indicate bots, wash trading, or system issues.

---

## 📂 Data Description
_raw_trades_ 
 <br> ● source schema:: raw_transaction 
 <br> ● PK: trade_id 
 <br> ● FK: user_id, token_id 

_raw_p2p_transfers_ 
 <br> ● source schema: raw_transaction 
 <br> ● PK: transfer_id 
 <br> ● FK: sender_id, receiver_id, token_id 

_raw_users_ 
 <br> ● source schema: raw_kyc 
 <br> ● PK: user_id 
 <br> ● FK: - 

_raw_tokens_ 
 <br> ● source schema: raw_config 
 <br> ● PK: token_id 
 <br> ● FK: -

---
## ERD Dataset
![alt text](https://github.com/dearaa/coinx-takehome/blob/main/ERD.png?raw=true)

## ⚙️ Methodology
### 1. Data Preparation
- Environment Setup: Google BigQuery
<br> Google BigQuery was selected as the central data warehouse for this analysis because of its scalability, SQL compatibility, and built-in transformation capabilities. The following setup was created:
<br> - **Project ID**: third-pad-476804-p7
<br> - **Dataset Name**: coinx
<br> - **Tables Created**:
<br> a. Raw tables: _raw_trades_, _raw_p2p_transfers_, _raw_users_, _raw_token_
<br> b. Fact tables (transformed views): _fact_trades_, _fact_p2p_
<br> c. Analytical views: _pareto_trade_buy_, _pareto_trade_sell_, _pareto_p2p_, and _trade_value_per_user_

<br> ![alt text](https://github.com/dearaa/coinx-takehome/blob/main/Environment%20Setup.png?raw=true)

- Data Standardization: Check & convert all data types to correct formats (e.g., string → integer/float/date). Ensure all timestamps are in UTC.
- Data Integration: Join all raw tables using foreign keys (user_id, token_id) to build unified fact tables:
<br> - fact_trades: combines trades with token and user attributes.
<br> - fact_p2p: combines peer-to-peer transfers with token and user attributes.
- Data Transformation:
<br> - Calculate derived metrics such as trade_value = price_usd * quantity.
<br> - Aggregate monthly and user-level summaries (e.g., total trade value, trade count).
- Data Validation: Check for missing or inconsistent keys, ensuring referential integrity between user, token, and transaction tables.


### 2. Data Governance
| Area                    | Objective                     | Implementation                                                                |
| ----------------------- | ----------------------------- | ----------------------------------------------------------------------------- |
| **Data Quality**        | Ensure consistency & accuracy | Run daily data validation (duplicate ID check, null validation, type casting) |
| **Data Lineage**        | Track transformation steps    | Maintain DAG via dbt / Airflow, with documented source → staging → mart flow  |
| **Access Control**      | Protect sensitive info        | Limit raw_user access to compliance roles only                                 |
| **Standardization**     | Enforce naming & type rules   | Apply `snake_case` and standardized timestamp (UTC)                           |
| **Monitoring & Alerts** | Detect anomalies              | Create rule-based alert for duplicate trades or >2 std dev transfer size      |

### 3. Analytical Framework

This analysis addresses three main business questions from leadership.

#### 3.1 Trading Concentration Risk
**a. Is the platform overly dependent on a few tokens and users?**
- Calculate p2p value contribution per user using Pareto analysis.
<br> ![alt text](https://github.com/dearaa/coinx-takehome/blob/main/pareto_p2p_user.png?raw=true)

- Calculate trade value contribution per user using Pareto analysis.
  
  _**Pareto Trade Buy**_
<br> ![alt text](https://github.com/dearaa/coinx-takehome/blob/main/pareto_trade_buy.png?raw=true)

   _**Pareto Trade Sell**_
<br> ![alt text](https://github.com/dearaa/coinx-takehome/blob/main/pareto_trade_sell.png?raw=true)

- Identify top tokens contributing to 80% of total volume.
<br> ![alt text](https://github.com/dearaa/coinx-takehome/blob/main/pareto_trade_token.png?raw=true)
  
**SUMMARY**

From both _pareto_trade_buy_ and _pareto_trade_sell_:

- The top 2–3 users contribute over 70–80% of total trade value, while the remaining 90% of users contribute marginally.
- This shows a classic 80/20 Pareto pattern: a very small number of users dominate the platform’s trading activity.
- On the _buy_ side, user U032 and U029 control ~67% of the cumulative trade value.
- On the _sell_ side, user U029 and U032 again dominate, accounting for ~80% of total sales value.
- The same dominant users (U029, U032) are active across both buy and sell sides — suggesting internal liquidity cycling or even potential wash trading.

_**Risk Implication**_

- The platform is highly dependent on a small trader base. If one or two of these users churn or reduce activity, overall volume could drop drastically.
- Artificial growth signals may appear if these whales increase activity, making real organic user growth hard to distinguish from volume inflation.

_**Recommendation**_

- Monitor high value users separately with early warning metrics (e.g., inactivity alerts).
- Encourage distribution: introduce loyalty programs or reduced fees for small/medium traders to balance contribution.
- Add "whale exposure" metric in the trading dashboard (e.g., top 10 users’ % of total volume).



**b. Are trading volumes genuinely growing or inflated by a small set of traders?**

- Aggregate total trade volume over time and compare user growth rate.
<br> ![alt text](https://github.com/dearaa/coinx-takehome/blob/main/user_growth.png?raw=true)

From Jan–Jun 2024, trade volume goes up and down sharply, but active users keep dropping.
_Example_:
- Feb: trade volume +223%, but users –12%
- Apr: trade volume +152%, but users –9%
  * This means a few users are driving most trades — a sign of concentration risk.
  * The platform depends on a small group of heavy traders (“whales”). If they stop trading, total volume can drop fast. It might also indicate fake or inflated trading activity or data issues.

#### 3.2 User Retention & Cross-Product Usage
a. Do users who start with P2P transfers eventually trade, or churn?
- Identify cohorts of users whose first action is P2P transfer.
- Track transition rate to fact_trades within N days (e.g., 30, 60, 90 days).
- Measure churn rate for those who never trade.

b. How does retention differ by region and token category?
- Use raw_users.region and raw_tokens.category.
- Compute monthly active users (MAU) and returning users.
- Compare retention curve by region and category.

#### 3.3 Data Reliability & Compliance
a. Detect anomalies (duplicate trades, suspiciously high-value transfers).
- Duplicate check: Identify trades with same user_id, token_id, timestamp, and amount.
- High-value anomaly detection: Use statistical thresholds (e.g., z-score > 3 or top 0.5% percentile) on trade_value and transfer_value.

b. Ensure trusted dashboards and data quality.
- Apply data validation rules before loading data to BI tools.
- Build audit tables tracking rejected or flagged records.
- Set up alerts for sudden spikes or data inconsistencies.


