------------------------Duplicate trade check------------------------


SELECT 
  trade_id,
  COUNT(*) AS duplicate_count
FROM `third-pad-476804-p7.coinx.raw_trades`
GROUP BY trade_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

------------------Suspiciously high-value transfers------------------

SELECT 
  user_id,
  token_id,
  ROUND(SUM(price_usd * quantity), 2) AS total_value_usd
FROM `third-pad-476804-p7.coinx.raw_trades`
GROUP BY 1,2
HAVING total_value_usd > (
  SELECT AVG(price_usd * quantity) * 10 
  FROM `third-pad-476804-p7.coinx.raw_trades`
)
ORDER BY total_value_usd DESC;

------------------Data governance & quality checks------------------


SELECT 
  COUNTIF(token_id IS NULL) AS missing_token_id,
  COUNTIF(user_id IS NULL) AS missing_user_id,
  COUNTIF(price_usd <= 0 OR quantity <= 0) AS invalid_trade_values
FROM `third-pad-476804-p7.coinx.raw_trades`;
