SELECT SUM(c_acctbal)
FROM customer
JOIN nation
ON c_nationkey = n_nationkey
JOIN region 
ON n_regionkey = r_regionkey
WHERE r_name = 'EUROPE'
AND c_mktsegment = 'MACHINERY'