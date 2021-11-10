SELECT substr(l_receiptdate, 1, 7), COUNT(l_receiptdate)
FROM lineitem, orders, customer
WHERE c_name = 'Customer#000000010'
AND c_custkey = o_custkey
AND o_orderkey = l_orderkey
AND substr(l_receiptdate, 1, 7) BETWEEN ('1993-01') AND ('1993-12')
GROUP BY substr(l_receiptdate, 1, 7);