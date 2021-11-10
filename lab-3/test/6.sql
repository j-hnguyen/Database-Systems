SELECT DISTINCT n_name
FROM nation, customer, orders
WHERE n_nationkey = c_nationkey
AND c_custkey = o_custkey
AND DATE(o_orderdate) BETWEEN DATE('1996-09-10') AND DATE('1996-09-12');
/*JOIN customer 
ON  nation.n_nationkey = customer.c_nationkey
JOIN orders 
ON customer.c_custkey = orders.o_custkey
WHERE DATE(orders.o_orderdate) BETWEEN DATE(1996-09-10) AND DATE(1996-09-12);