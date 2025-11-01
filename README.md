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
- Data Standardization: Check & convert all data types to correct formats (e.g., string → integer/float/date). Ensure all timestamps are in UTC.
- Data Integration: Join all raw tables using foreign keys (user_id, token_id) to build unified fact tables:
<br> ● fact_trades: combines trades with token and user attributes.
<br> ● fact_p2p: combines peer-to-peer transfers with token and user attributes.
- Data Transformation:
<br> ● Calculate derived metrics such as trade_value = price_usd * quantity.
<br> ● Aggregate monthly and user-level summaries (e.g., total trade value, trade count).
- Data Validation: Check for missing or inconsistent keys, ensuring referential integrity between user, token, and transaction tables.

### 2. Data Governance
| Area                    | Objective                     | Implementation                                                                |
| ----------------------- | ----------------------------- | ----------------------------------------------------------------------------- |
| **Data Quality**        | Ensure consistency & accuracy | Run daily data validation (duplicate ID check, null validation, type casting) |
| **Data Lineage**        | Track transformation steps    | Maintain DAG via dbt / Airflow, with documented source → staging → mart flow  |
| **Access Control**      | Protect sensitive info        | Limit raw_kyc access to compliance roles only                                 |
| **Standardization**     | Enforce naming & type rules   | Apply `snake_case` and standardized timestamp (UTC)                           |
| **Monitoring & Alerts** | Detect anomalies              | Create rule-based alert for duplicate trades or >2 std dev transfer size      |

### 2. Concentration Risk
- Compute top 10 traders’ share of total volume.
- Visualize distribution across users.
- Metric used: **Herfindahl-Hirschman Index (HHI)** or % of top traders.

### 3. Analytical Framework

This analysis addresses three main business questions from leadership.

#### 3.1 Trading Concentration Risk
a. Is the platform overly dependent on a few tokens?
- Calculate trade value contribution per token using Pareto analysis.
- Identify top tokens contributing to 80% of total volume.
- Metric: token_concentration_ratio = top_20_percent_tokens_value / total_trade_value.

b. Are trading volumes genuinely growing or inflated by a small set of traders?
- Aggregate total trade volume over time and compare user growth rate.
- Calculate Gini coefficient or Herfindahl-Hirschman Index (HHI) on user trading values to measure concentration.
- Analyze volume growth vs. unique active traders.

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


