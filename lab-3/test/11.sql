SELECT COUNT(DISTINCT c_custkey)
FROM customer
JOIN orders
ON c_custkey = o_custkey
JOIN lineitem
ON o_orderkey = l_orderkey
WHERE l_discount >= '0.1'