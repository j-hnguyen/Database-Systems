SELECT c_mktsegment, MIN(c_acctbal), MAX(c_acctbal), SUM(c_acctbal)
FROM customer c 
GROUP BY c_mktsegment