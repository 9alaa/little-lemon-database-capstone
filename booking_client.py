import os
import mysql.connector

conn = mysql.connector.connect(
    host=os.getenv("MYSQL_HOST", "localhost"),
    user=os.getenv("MYSQL_USER", "root"),
    password=os.getenv("MYSQL_PASSWORD", ""),
    database="LittleLemonDB"
)

cursor = conn.cursor()

def run(sql, params=()):
    cursor.execute(sql, params)
    if cursor.with_rows:
        print(cursor.fetchall())
    while cursor.nextset():
        if cursor.with_rows:
            print(cursor.fetchall())

run("CALL GetMaxQuantity()")

run(
    "CALL AddBooking(%s,%s,%s,%s)",
    (99, 99, 99, "2022-12-10")
)

run(
    "CALL UpdateBooking(%s,%s)",
    (99, "2022-01-10")
)

run(
    "CALL CancelBooking(%s)",
    (99,)
)

conn.commit()
cursor.close()
conn.close()
