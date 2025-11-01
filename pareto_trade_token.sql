with trade_summary as 
(
  SELECT 
   *
  FROM 
  `third-pad-476804-p7.coinx.fact_trades` rtrade
  where 
    status = 'FILLED'
),

agg as 
(
  select
    token_name,
    side,
    round(sum(sum_trade_value),3) sum_trade_value
  from trade_summary
  group by 1,2
),


ranked as 
(
   SELECT
    token_name,
    side,
    sum_trade_value,
    RANK() OVER (ORDER BY sum_trade_value DESC) AS rank_token,
    SUM(sum_trade_value) OVER () AS total_all_trade,
    round(SUM(sum_trade_value) OVER (ORDER BY sum_trade_value DESC),3) AS running_total
  FROM agg
)

SELECT
  token_name,
  side
  sum_trade_value,
  running_total,
  ROUND(100.0 * running_total / total_all_trade, 2) AS cumulative_percent
FROM ranked
ORDER BY side,sum_trade_value DESC;
