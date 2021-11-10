SELECT COUNT(o_orderpriority)
FROM orders
JOIN customer
ON o_custkey = c_custkey
JOIN nation
ON c_nationkey = n_nationkey
WHERE o_orderpriority = '1-URGENT'
AND n_name = 'BRAZIL'
AND substr(o_orderdate, 1 , 4) BETWEEN '1994' AND '1997'