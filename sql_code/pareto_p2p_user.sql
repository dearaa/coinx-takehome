with p2p_summary as
(
  SELECT 
   *
  from `coinx.fact_p2p`
),

agg as 
(
  select
    sender_id user_id,
    round(sum(sum_p2p_value),3) total_p2p_value
  from p2p_summary
  group by 1
),

ranked AS (
  SELECT
    user_id,
    total_p2p_value,
    RANK() OVER (ORDER BY total_p2p_value DESC) AS rank_user,
    SUM(total_p2p_value) OVER () AS total_all_p2p,
    SUM(total_p2p_value) OVER (ORDER BY total_p2p_value DESC) AS running_total
  FROM agg
)

SELECT
  user_id,
  total_p2p_value,
  running_total,
  ROUND(100.0 * running_total / total_all_p2p, 2) AS cumulative_percent
FROM ranked
ORDER BY total_p2p_value DESC;
