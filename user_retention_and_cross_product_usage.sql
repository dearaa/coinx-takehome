---------------Identify users who did P2P first and check if they later traded---------------

WITH first_p2p AS (
  SELECT 
    sender_id user_id,
    MIN(month_transfer) AS first_p2p_month
  FROM `third-pad-476804-p7.coinx.fact_p2p`
  GROUP BY 1
),
first_trade AS (
  SELECT 
    user_id,
    MIN(month_trade) AS first_trade_month
  FROM `third-pad-476804-p7.coinx.fact_trades`
  GROUP BY 1
)
SELECT 
  COUNT(DISTINCT p.user_id) AS total_p2p_users,
  COUNT(DISTINCT t.user_id) AS total_trade_users,
  COUNT(DISTINCT CASE WHEN t.user_id IS NOT NULL THEN p.user_id END) AS p2p_to_trade_users,
  ROUND(
    COUNT(DISTINCT CASE WHEN t.user_id IS NOT NULL THEN p.user_id END) 
    / COUNT(DISTINCT p.user_id) * 100, 2
  ) AS conversion_rate_pct
FROM first_p2p p
LEFT JOIN first_trade t
ON p.user_id = t.user_id 
AND t.first_trade_month >= p.first_p2p_month

---------------------------Retention by region & token category---------------------------

WITH active_users AS (
  SELECT DISTINCT user_id, region, date(month_trade) month_trade
  FROM `third-pad-476804-p7.coinx.fact_trades` ft
  LEFT JOIN `third-pad-476804-p7.coinx.raw_users` ru USING(user_id)
),
retention AS (
  SELECT 
    a.region,
    a.month_trade,
    COUNT(DISTINCT a.user_id) AS active_users,
    COUNT(DISTINCT b.user_id) AS retained_users,
    ROUND(COUNT(DISTINCT b.user_id) / COUNT(DISTINCT a.user_id) * 100, 2) AS retention_rate
  FROM active_users a
  LEFT JOIN active_users b
    ON a.user_id = b.user_id 
   AND b.month_trade = DATE_ADD(a.month_trade, INTERVAL 1 MONTH)
  GROUP BY 1,2
)
SELECT * FROM retention
ORDER BY region, month_trade;
