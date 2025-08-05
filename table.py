#!/usr/bin/env python3

import pandas as pd
import psycopg2
from psycopg2 import sql
import os
from datetime import datetime
from dotenv import load_dotenv
from psycopg2.extras import execute_batch

def connect_to_db():
    """Connect to PostgreSQL database using .env file for fill data"""
    load_dotenv()

    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            port=os.getenv("DB_PORT")
        )
        return conn
    except Exception as e:
        print(f"Error connecting to database: {e}")
        return None


def create_table_from_csv(csv_path, table_name, conn):
    """Create table and insert data from CSV"""
    try:
        df = pd.read_csv(csv_path)
        cursor = conn.cursor()

        # Drop table if exists
        cursor.execute(sql.SQL("DROP TABLE IF EXISTS {}").format(sql.Identifier(table_name)))

        # Create table
        create_stmt = sql.SQL("""
            CREATE TABLE {} (
                event_time TIMESTAMP,
                event_type TEXT,
                product_id BIGINT,
                price FLOAT,
                user_id BIGINT,
                user_session TEXT
            )
        """).format(sql.Identifier(table_name))
        cursor.execute(create_stmt)

        insert_stmt = sql.SQL("""
            INSERT INTO {} (event_time, event_type, product_id, price, user_id, user_session)
            VALUES (%s, %s, %s, %s, %s, %s)
        """).format(sql.Identifier(table_name))

        # Build list of tuples
        records = [
            (
                row['event_time'],
                row['event_type'],
                row['product_id'],
                row['price'],
                row['user_id'],
                row['user_session']
            )
            for _, row in df.iterrows()
        ]

        execute_batch(cursor, insert_stmt.as_string(conn), records, page_size=1000)


        conn.commit()
        print(f"Table '{table_name}' created and filled.")
        cursor.close()

    except Exception as e:
        print(f"Error processing {csv_path}: {e}")


if __name__ == "__main__":
    conn = connect_to_db()
    if conn:
        folder = "../subject/customer/"
        base_name = "data_202"
        months = ["2_oct", "2_nov", "2_dec", "3_jan"]

        for month in months:
            table_name = f"{base_name}{month}"
            path = f"{folder}{base_name}{month}.csv"
            create_table_from_csv(path, table_name, conn)

        conn.close()
