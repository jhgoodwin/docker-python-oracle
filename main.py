import cx_Oracle
import os
constr = os.getenv('ORACLE_CON_STR', 'Please set ORACLE_CON_STR environment variable to the connection string, then re-invoke')
con = cx_Oracle.connect(constr)
print(con.version)
con.close()
