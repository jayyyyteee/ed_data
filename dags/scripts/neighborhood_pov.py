import requests
import psycopg2
from psycopg2.extras import execute_values
from psycopg2 import sql
import os
import logging

from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# Fetch data from the API
def fetch_data(api_url):
    """
    Fetch data from the given API URL.
    
    Args:
        api_url (str): The URL to fetch data from.
    
    Returns:
        list: A list of features from the API response.
    
    Raises:
        ValueError: If no features are found in the API response.
        requests.RequestException: For network-related errors.
    """
    logging.info("Fetching data from API...")
    try:
        response = requests.get(api_url, timeout=10)
        response.raise_for_status()
        data = response.json()

        if "features" not in data or not data["features"]:
            raise ValueError("No features found in the API response")

        logging.info(f"Fetched {len(data['features'])} records from the API.")
        return data["features"]
    except requests.RequestException as e:
        logging.error(f"Failed to fetch data from API: {e}")
        raise
    except ValueError as e:
        logging.error(e)
        raise

# Transform API data into database-ready format
def transform_data(features):
    """
    Transform data into a format suitable for database insertion.
    
    Args:
        features (list): A list of features from the API response.
    
    Returns:
        list: Transformed data ready for database insertion.
    """
    logging.info("Transforming data...")
    transformed_data = []

    for feature in features:
        attrs = feature.get("attributes", {})
        # Ensure all necessary attributes are present
        if not all(key in attrs for key in ["OBJECTID", "NAME", "NCESSCH", "IPR_EST", "IPR_SE", "SCHOOLYEAR", "LAT", "LON"]):
            logging.warning(f"Skipping feature with missing attributes: {attrs}")
            continue

        transformed_data.append((
            attrs.get("OBJECTID"),
            attrs.get("NAME"),
            attrs.get("NCESSCH"),
            attrs.get("IPR_EST"),
            attrs.get("IPR_SE"),
            attrs.get("SCHOOLYEAR"),
            attrs.get("LAT"),
            attrs.get("LON")
        ))

    logging.info(f"Transformed {len(transformed_data)} records.")
    return transformed_data

# Load data into PostgreSQL
def load_data_to_postgres(data, table_name="neighborhood_pov"):
    """
    Load the transformed data into the specified PostgreSQL table.
    
    Args:
        data (list): Transformed data ready for database insertion.
        table_name (str): The target table name in the PostgreSQL database.
    """
    logging.info("Connecting to the database...")
    conn = None
    cur = None
    try:
        conn = psycopg2.connect(
            dbname=os.getenv("APPLICATION_DB"),
            user=os.getenv("POSTGRES_USER"),
            password=os.getenv("POSTGRES_PASSWORD"),
            host=os.getenv("POSTGRES_HOST"),
            port=os.getenv("POSTGRES_PORT"),
            connect_timeout=10  # Ensure connection timeout
        )
        cur = conn.cursor()

        # Clear existing data
        logging.info(f"Clearing existing data from {table_name}...")
        cur.execute(sql.SQL("TRUNCATE TABLE {table}").format(table=sql.Identifier(table_name)))


        # SQL for data insertion
        insert_query = sql.SQL("""
            INSERT INTO {table} (
                object_id, name, school_id, income_to_poverty_ratio_est,
                income_to_poverty_ratio_se, school_year, latitude, longitude
            ) VALUES %s
        """).format(table=sql.Identifier(table_name))

        # Batch insert data
        logging.info("Inserting data into the database...")
        execute_values(cur, insert_query, data)

        # Commit changes
        conn.commit()
        logging.info(f"Inserted {len(data)} records into the database.")
    except psycopg2.DatabaseError as e:
        logging.error(f"Database error occurred: {e}")
        if conn:
            conn.rollback()
        raise
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()
        logging.info("Database connection closed.")

# Orchestrate the ETL process
def fetch_and_load_data():
    """
    Orchestrates the ETL process: fetch, transform, and load.
    """
    api_url = (
        "https://services1.arcgis.com/Ua5sjt3LWTPigjyD/"
        "arcgis/rest/services/School_Neighborhood_Poverty_Estimates_Current/"
        "FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
    )
    try:
        features = fetch_data(api_url)
        transformed_data = transform_data(features)
        load_data_to_postgres(transformed_data)
        logging.info("ETL process completed successfully.")
    except Exception as e:
        logging.error(f"ETL process failed: {e}")
        raise

if __name__ == "__main__":
    fetch_and_load_data()
