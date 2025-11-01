-- Cohort retention pivot by region + token_category (m0..m5)
WITH user_month AS (
  SELECT DISTINCT
    ft.user_id,
    COALESCE(ru.region, 'UNKNOWN') AS region,
    COALESCE(rt.category, 'UNKNOWN') AS token_category,
    DATE_TRUNC(CAST(ft.month_trade AS DATE), MONTH) AS month_trade
  FROM `third-pad-476804-p7.coinx.fact_trades` ft
  LEFT JOIN `third-pad-476804-p7.coinx.raw_users` ru
    ON ft.user_id = ru.user_id
  LEFT JOIN `third-pad-476804-p7.coinx.raw_token` rt
    ON ft.token_id = rt.token_id
),

cohort AS (
  SELECT
    user_id,
    region,
    token_category,
    MIN(month_trade) AS cohort_month
  FROM user_month
  GROUP BY user_id, region, token_category
),

user_activity AS (
  SELECT
    um.user_id,
    um.region,
    um.token_category,
    c.cohort_month,
    um.month_trade,
    DATE_DIFF(um.month_trade, c.cohort_month, MONTH) AS month_number
  FROM user_month um
  JOIN cohort c
    ON um.user_id = c.user_id
),

retention_counts AS (
  SELECT
    region,
    token_category,
    cohort_month,
    month_number,
    COUNT(DISTINCT user_id) AS active_users
  FROM user_activity
  WHERE month_number >= 0 AND month_number <= 12    -- safety bound
  GROUP BY region, token_category, cohort_month, month_number
),

cohort_size AS (
  SELECT
    region,
    token_category,
    cohort_month,
    COUNT(DISTINCT user_id) AS cohort_size
  FROM cohort
  GROUP BY region, token_category, cohort_month
),

retention_rate AS (
  SELECT
    rc.region,
    rc.token_category,
    rc.cohort_month,
    rc.month_number,
    SAFE_DIVIDE(rc.active_users, cs.cohort_size) * 100.0 AS retention_rate_pct
  FROM retention_counts rc
  JOIN cohort_size cs
    ON rc.region = cs.region
   AND rc.token_category = cs.token_category
   AND rc.cohort_month = cs.cohort_month
)

SELECT
  region,
  token_category,
  cohort_month,
  -- m0 = 100% by definition (cohort month), show explicitly
  MAX(IF(month_number = 0, 100.0, NULL)) AS m0,
  MAX(IF(month_number = 1, ROUND(retention_rate_pct,2), NULL)) AS m1,
  MAX(IF(month_number = 2, ROUND(retention_rate_pct,2), NULL)) AS m2,
  MAX(IF(month_number = 3, ROUND(retention_rate_pct,2), NULL)) AS m3,
  MAX(IF(month_number = 4, ROUND(retention_rate_pct,2), NULL)) AS m4,
  MAX(IF(month_number = 5, ROUND(retention_rate_pct,2), NULL)) AS m5
FROM retention_rate
GROUP BY region, token_category, cohort_month
ORDER BY region, token_category, cohort_month;
