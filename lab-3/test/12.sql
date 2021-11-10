SELECT r_name, COUNT(o_orderstatus)
FROM region
JOIN nation
ON r_regionkey = n_regionkey
JOIN customer
ON n_nationkey = c_nationkey
JOIN orders
ON c_custkey = o_custkey
WHERE o_orderstatus = 'F'
GROUP BY r_name