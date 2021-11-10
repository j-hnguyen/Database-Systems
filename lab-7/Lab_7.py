import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    try:
        sql = """CREATE TABLE warehouse (
                    w_warehousekey decimal(9,0) not null,
                    w_name char(100) not null,
                    w_capacity decimal(6,0) not null,
                    w_suppkey decimal(9,0) not null,
                    w_nationkey decimal(2,0) not null)"""
        _conn.execute(sql)
        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")
    try:
        sql = "DROP TABLE warehouse"
        _conn.execute(sql)
        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    c = _conn.cursor()
    c.execute("SELECT s_suppkey FROM supplier")
    rows = c.fetchall()
    counter = 1
    for row in rows:
        c.execute(f"""SELECT n_nationkey, n_name, s_suppkey, s_name, COUNT(*) as count, SUM(part.p_size) as capacity
                    FROM supplier
                    INNER JOIN lineitem ON s_suppkey = l_suppkey
                    INNER JOIN part ON p_partkey = l_partkey
                    INNER JOIN orders ON o_orderkey = l_orderkey
                    INNER JOIN customer ON c_custkey = o_custkey
                    INNER JOIN nation ON n_nationkey = c_nationkey
                    WHERE s_suppkey = {row[0]}
                    GROUP BY n_nationkey
                    ORDER BY count DESC, n_name;""")
        results = c.fetchall()
        nationkey1, cust1, supp1, sname1, total1, capacity = results[0]
        nationkey2, cust2, supp2, sname2, total1, capacity2 = results[1]
        warehouse1 = f"{sname1}___{cust1}"
        warehouse2 = f"{sname2}___{cust2}"
        maxcap = max([result[-1] for result in results])
        shared = maxcap * 2
        c.execute(f"""INSERT INTO warehouse VALUES ({counter}, "{warehouse1}",  {shared}, {supp1}, {nationkey1});""")
        c.execute(f"""INSERT INTO warehouse VALUES ({counter+1}, "{warehouse2}", {shared}, {supp2}, {nationkey2}); """)
        _conn.commit()
        counter += 2
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    f = open("output/1.out", "w")
    try: 
        sql = """SELECT w_warehousekey AS wId, w_name AS wName, w_capacity AS wCap, w_suppkey AS sId, w_nationkey AS nId
                 FROM warehouse;"""
        c = _conn.cursor()
        c.execute(sql)
        l = '{:>10} {:>11} {:<10} {:<10} {:<10}'.format("wId", "wName", "wCap", "sId", "nId")
        print(l)
        f.write(l + "\n")
        rows = c.fetchall()
        for row in rows:
            l = '{:>10} {:>11} {:<10} {:<10} {:<10}'.format(row[0], row[1], row[2], row[3], row[4])
            print(l)
            f.write(l + "\n")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    try:
        f = open("output/2.out", "w")
        sql = """SELECT n_name AS nation, COUNT(w_name) AS numW, SUM(w_capacity) AS totCap
                 FROM warehouse
                 JOIN nation ON n_nationkey = w_nationkey
                 GROUP BY n_name
                 ORDER BY numW DESC;"""
        c = _conn.cursor()
        c.execute(sql)
        l = '{:<20} {:>10} {:>10}'.format("nation", "numW", "totCap")
        print(l)
        f.write(l + "\n")
        rows = c.fetchall()
        for row in rows:
            l = '{:<20} {:>10} {:>10}'.format(row[0], row[1], row[2])
            print(l)
            f.write(l + "\n")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    try:
        f = open("output/3.out", "w")
        r = open("input/3.in", "r")
        input = r.read().splitlines()
        sql = """SELECT s_name, snation.n_name, w_name
                 FROM supplier
                 JOIN nation snation ON s_nationkey = snation.n_nationkey
                 JOIN warehouse ON w_suppkey = s_suppkey
                 JOIN nation wnation ON w_nationkey = wnation.n_nationkey
                 WHERE wnation.n_name = '{}'
                 ORDER BY s_name ASC""".format(input[0])
        c = _conn.cursor()
        c.execute(sql)
        l = '{:<20} {:<21} {:<10}'.format("supplier", "nation", "warehouse")
        print(l)
        f.write(l + "\n")
        rows = c.fetchall()
        for row in rows:
            l = '{:<20} {:<21} {:<10}'.format(row[0], row[1], row[2])
            print(l)
            f.write(l + "\n")

    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    try: 
        f = open("output/4.out", "w")
        r = open("input/4.in", "r")
        input = r.read().splitlines()
        sql = """SELECT w_name, w_capacity
                 FROM warehouse
                 INNER JOIN nation ON w_nationkey = n_nationkey
                 INNER JOIN region ON r_regionkey = n_regionkey
                 WHERE r_name = '{}'
                 AND w_capacity > {}
                 GROUP BY w_name
                 ORDER BY w_capacity DESC""".format(input[0], input[1])
        c = _conn.cursor()
        c.execute(sql)
        l = '{:<10} {:>37}'.format("warehouse", "capacity")
        print(l)
        f.write(l + "\n")
        rows = c.fetchall()
        for row in rows:
            l ='{:<30} {:>17}'.format(row[0], row[1])
            print(l)
            f.write(l + "\n")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    try:
        f = open("output/5.out", "w")
        r = open("input/5.in", "r")
        input = r.read().splitlines()
        sql = """SELECT r_name, CASE WHEN  THEN  ELSE 0 END
                 
                 ORDER BY r_name ASC""".format(input[0])
        c = _conn.cursor()
        c.execute(sql)
        l = '{:<6} {:>35}'.format("region", "capacity")
        print(l)
        f.write(l + "\n")
        rows = c.fetchall()
        for row in rows:
            l ='{:<11} {:>30}'.format(row[0], row[1])
            print(l)
            f.write(l + "\n")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
