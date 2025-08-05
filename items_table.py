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
                product_id NUMERIC,
                category_id NUMERIC,
                category_code TEXT,
                brand TEXT
            )
        """).format(sql.Identifier(table_name))
        cursor.execute(create_stmt)

        insert_stmt = sql.SQL("""
            INSERT INTO {} (product_id, category_id, category_code, brand)
            VALUES (%s, %s, %s, %s)
        """).format(sql.Identifier(table_name))

        # Build list of tuples
        records = [
            (
                row['product_id'],
                row['category_id'],
                row['category_code'],
                row['brand']
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
        create_table_from_csv("../subject/item/item.csv", "items", conn)

        conn.close()
