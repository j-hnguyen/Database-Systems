SELECT substr(o_orderdate, 1, 4), COUNT(o_orderpriority)
FROM orders
JOIN lineitem
ON o_orderkey = l_orderkey
JOIN supplier
ON l_suppkey = s_suppkey
JOIN nation
ON s_nationkey = n_nationkey
WHERE o_orderpriority = '3-MEDIUM' 
AND n_name = 'CANADA'
GROUP BY substr(o_orderdate, 1, 4)