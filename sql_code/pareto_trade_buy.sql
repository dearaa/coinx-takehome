with trade_summary as 
(
  SELECT 
   *
  FROM 
  `third-pad-476804-p7.coinx.fact_trades` rtrade
  where 
    status = 'FILLED'
    and side = 'BUY'
),

agg as 
(
  select
    user_id,
    round(sum(sum_trade_value),3) sum_trade_value
  from trade_summary
  group by 1
),


ranked as 
(
   SELECT
    user_id,
    sum_trade_value,
    RANK() OVER (ORDER BY sum_trade_value DESC) AS rank_user,
    SUM(sum_trade_value) OVER () AS total_all_trade,
    SUM(sum_trade_value) OVER (ORDER BY sum_trade_value DESC) AS running_total
  FROM agg
)

SELECT
  user_id,
  sum_trade_value,
  running_total,
  ROUND(100.0 * running_total / total_all_trade, 2) AS cumulative_percent
FROM ranked
ORDER BY sum_trade_value DESC;
