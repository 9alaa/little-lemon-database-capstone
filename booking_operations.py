import os
import argparse
import mysql.connector

parser=argparse.ArgumentParser(description='Little Lemon booking operations')
parser.add_argument('action',choices=['check','add','update','cancel'])
parser.add_argument('--date',default='2026-10-25')
parser.add_argument('--time',default='18:00:00')
parser.add_argument('--table',type=int,default=1)
parser.add_argument('--customer',type=int,default=1)
parser.add_argument('--guests',type=int,default=2)
parser.add_argument('--id',type=int)
a=parser.parse_args()
config=dict(host=os.getenv('MYSQL_HOST','localhost'),user=os.getenv('MYSQL_USER','root'),password=os.getenv('MYSQL_PASSWORD',''),database='LittleLemonDB')
conn=mysql.connector.connect(**config)
try:
    cur=conn.cursor()
    if a.action=='check': proc,params='CheckBooking',[a.date,a.time,a.table]
    elif a.action=='add': proc,params='AddValidBooking',[a.date,a.time,a.table,a.customer,a.guests]
    elif a.action=='update':
        if a.id is None: parser.error('--id required for update')
        proc,params='UpdateBooking',[a.id,a.date,a.time]
    else:
        if a.id is None: parser.error('--id required for cancel')
        proc,params='CancelBooking',[a.id]
    cur.callproc(proc,params)
    for result in cur.stored_results(): print(result.fetchall())
    conn.commit()
    print('Operation completed:',a.action)
finally:
    conn.close()
