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
## Data lineage and ERD
![alt text](https://github.com/dearaa/coinx-takehome/blob/main/ERD.png?raw=true)

## ⚙️ Methodology
### 1. Data Cleaning
- Check nulls, duplicates, and outliers.
- Convert timestamps to datetime format.
- Aggregate trade values by user and pair.

### 2. Concentration Risk
- Compute top 10 traders’ share of total volume.
- Visualize distribution across users.
- Metric used: **Herfindahl-Hirschman Index (HHI)** or % of top traders.

### 3. Anomaly Detection
- Daily total volume per pair.
- Compute Z-score or IsolationForest anomaly score.
- Visualize anomalies over time.

### 4. Key Metrics
| Metric | Description |
|---------|--------------|
| Top 10 Share | % of total volume from top 10 users |
| HHI | Market concentration index |
| Anomaly Count | Number of detected outlier trading days |

---

## 📊 Example Output
- `charts/top10_traders` → shows concentration
- `charts/anomaly_trend` → daily volume anomalies

---

## 🧠 Tools & Libraries
- Python 3.10+
- pandas, numpy, matplotlib, seaborn, scikit-learn

Install dependencies:
```bash
pip install -r requirements.txt

