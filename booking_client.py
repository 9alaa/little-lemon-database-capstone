import os
import mysql.connector
from mysql.connector import Error

config = dict(host=os.getenv('MYSQL_HOST','localhost'), user=os.getenv('MYSQL_USER','root'), password=os.getenv('MYSQL_PASSWORD',''), database='LittleLemonDB')

def main():
    try:
        with mysql.connector.connect(**config) as conn:
            cur=conn.cursor()
            print('Connected to LittleLemonDB')
            cur.callproc('CheckBooking',['2026-10-20','18:00:00',1])
            for result in cur.stored_results():
                print('Booking availability:',result.fetchall())
            cur.execute('SELECT COUNT(*) FROM Bookings')
            print('Bookings:',cur.fetchone()[0])
            cur.close()
    except Error as e:
        print('Database error:',e)

if __name__=='__main__': main()
