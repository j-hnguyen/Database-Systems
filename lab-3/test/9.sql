SELECT n_name, COUNT(s_suppkey), MAX(s_acctbal)
FROM nation, supplier
WHERE nation.n_nationkey = supplier.s_nationkey
GROUP BY n_name
HAVING COUNT(s_nationkey)>5