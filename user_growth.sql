WITH trade_summary AS (
  SELECT
    DATE_TRUNC(trade_created_time, MONTH) AS month,
    ROUND(SUM(price_usd * quantity), 2) AS total_trade_volume,
    COUNT(DISTINCT user_id) AS active_users
  FROM `third-pad-476804-p7.coinx.raw_trades`
  GROUP BY 1
)
SELECT
  month,
  total_trade_volume,
  active_users,
  ROUND(
    (total_trade_volume - LAG(total_trade_volume) OVER (ORDER BY month)) / 
    LAG(total_trade_volume) OVER (ORDER BY month) * 100, 2
  ) AS volume_growth_pct,
  ROUND(
    (active_users - LAG(active_users) OVER (ORDER BY month)) / 
    LAG(active_users) OVER (ORDER BY month) * 100, 2
  ) AS user_growth_pct
FROM trade_summary
ORDER BY month
