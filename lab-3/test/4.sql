SELECT COUNT(l_quantity)
FROM lineitem
WHERE DATE(l_shipdate) < DATE(l_commitdate);