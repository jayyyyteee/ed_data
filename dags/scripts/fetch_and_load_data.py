import requests
import psycopg2
from psycopg2.extras import execute_values
from psycopg2 import sql
import os
import logging
import pandas as pd


from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# Fetch data from the API
def fetch_data(api_url, max_record_count=2000):
    """
    Fetch all data from the given API URL handling pagination.

    Args:
        api_url (str): The base URL to fetch data from.
        max_record_count (int): Maximum number of records per API call (page size).

    Returns:
        list: A list of all features from the API response.

    Raises:
        ValueError: If no features are found in the API response.
        requests.RequestException: For network-related errors.
    """
    all_features = []
    offset = 0
    total_records_fetched = 0

    while True:
        paginated_url = f"{api_url}&resultRecordCount={max_record_count}&resultOffset={offset}"
        logging.info(f"Fetching data from API with offset {offset}...")
        
        try:
            response = requests.get(paginated_url, timeout=10)
            response.raise_for_status()
            data = response.json()

            if "features" not in data or not data["features"]:
                if not all_features:  
                    raise ValueError("No features found in the API response")
                break

            all_features.extend(data['features'])
            records_fetched = len(data['features'])
            total_records_fetched += records_fetched
            logging.info(f"Fetched {records_fetched} records from the API.")
            
            if records_fetched < max_record_count:
                break  

            offset += max_record_count

        except requests.RequestException as e:
            logging.error(f"Failed to fetch data from API: {e}")
            raise

    logging.info(f"Total records fetched: {total_records_fetched}")
    return all_features

#fetch data with no pagination
def fetch_data_no_pagination(api_url):
    """
    Fetch all data from the given API URL without handling pagination.

    Args:
        api_url (str): The API endpoint URL.

    Returns:
        list: A list of rows (features) from the API response.

    Raises:
        ValueError: If no rows are found in the API response.
        requests.RequestException: For network-related errors.
    """
    all_features = []

    logging.info("Fetching data from API without pagination...")
    
    try:
        response = requests.get(api_url, timeout=30)  
        response.raise_for_status()
        data = response.json()

        if not data or len(data) < 2:
            raise ValueError("No data found in the API response")

        # Separate headers and rows
        headers = data[0]
        rows = data[1:]

        logging.info(f"Fetched {len(rows)} records from the API.")
        return headers, rows

    except requests.RequestException as e:
        logging.error(f"Failed to fetch data from API: {e}")
        raise

# New function for the new API
def fetch_data_assessment_api(api_url):
    """
    Fetch data from the new API format that uses 'next' links for pagination 
    and 'results' instead of 'features'.
    """
    all_records = []
    url = api_url

    while url:
        logging.info(f"Fetching data from {url}...")
        try:
            response = requests.get(url, timeout=30)
            response.raise_for_status()
            data = response.json()

            if "results" not in data:
                raise ValueError("No 'results' found in the API response.")

            records = data["results"]
            all_records.extend(records)
            logging.info(f"Fetched {len(records)} records from the API.")

            # Move to the next page if available
            url = data.get("next", None)

        except requests.RequestException as e:
            logging.error(f"Failed to fetch data from API: {e}")
            raise

    logging.info(f"Total records fetched from new API: {len(all_records)}")
    return all_records

def load_txt_file_to_postgres(file_path, table_name):
    """
    Load a text file into a PostgreSQL table.

    Args:
        file_path (str): Path to the text file.
        table_name (str): The target database table name.
    """
    logging.info(f"Starting to process text file at {file_path}.")
    try:
        # Read the text file into a DataFrame
        df = pd.read_csv(file_path, sep=' ') 


        # Convert DataFrame to a list of records
        data = df.to_dict(orient='records')
        column_names = df.columns.tolist()

        # Log the first few rows for debugging
        logging.info(f"First few rows of the text file:\n{df.head()}")

        # Load data into PostgreSQL
        load_data_to_postgres(data, column_names, table_name)

        logging.info(f"Successfully loaded text file into table '{table_name}'.")
    except Exception as e:
        logging.error(f"Failed to process text file with error: {e}")

def load_excel_sheets_to_postgres(file_path, table_name_mapping):
    """
    Load Excel file sheets into PostgreSQL tables.

    Args:
        file_path (str): Path to the Excel file.
        table_name_mapping (dict): Mapping of sheet names to target database table names.
    """
    logging.info(f"Starting to process Excel file at {file_path}.")
    try:
        # Read the Excel file
        excel_data = pd.ExcelFile(file_path)
        for sheet_name, table_name in table_name_mapping.items():
            logging.info(f"Processing sheet '{sheet_name}' for table '{table_name}'.")

            # Read the sheet into a DataFrame
            df = excel_data.parse(sheet_name, dtype={'ncesNumber':str})


            # Convert DataFrame to a list of records
            data = df.to_dict(orient='records')
            column_names = df.columns.tolist()

            # Log the first few rows for debugging
            logging.info(f"First few rows of '{sheet_name}':\n{df.head()}")

            # Load data into PostgreSQL
            load_data_to_postgres(data, column_names, table_name)

            logging.info(f"Successfully loaded sheet '{sheet_name}' into table '{table_name}'.")
    except Exception as e:
        logging.error(f"Failed to process Excel file with error: {e}")
        raise



# New transform function for the new API
def transform_data_assessment_api(records):
    """
    Transform data from the new API, which returns records directly as a list of dicts.
    """
    logging.info("Transforming new API data...")
    if not records:
        raise ValueError("No records to transform.")

    # Extract column names from keys of the first record
    column_names = sorted(records[0].keys())
    logging.info(f"Transformed {len(records)} records using new API structure.")
    return records, column_names

# Transform API data into database-ready format
def transform_data(features):
    """
    Dynamically transform data into a format suitable for database insertion.

    Args:
        features (list): A list of features from the API response.

    Returns:
        list: Transformed data ready for database insertion.
        list: List of column names based on the API response.
    """
    logging.info("Transforming data...")
    transformed_data = []
    column_names = set()

    for feature in features:
        attrs = feature.get("attributes", {})
        column_names.update(attrs.keys())
        transformed_data.append(attrs)

    logging.info(f"Transformed {len(transformed_data)} records.")
    return transformed_data, sorted(column_names)

def transform_data2(headers, rows):
    """
    Transform API data into a format suitable for database insertion.

    Args:
        headers (list): A list of column names from the API response.
        rows (list): A list of rows from the API response.

    Returns:
        list: Transformed data ready for database insertion.
        list: List of column names (same as headers).
    """
    logging.info("Transforming data...")

    # Transform rows into a list of tuples for database insertion
    transformed_data = [dict(zip(headers, row)) for row in rows]

    logging.info(f"Transformed {len(transformed_data)} records.")
    return transformed_data, headers


# Load data into PostgreSQL
def load_data_to_postgres(data, column_names, table_name):
    """
    Load the transformed data into the specified PostgreSQL table.
    
    Args:
        data (list): Transformed data ready for database insertion.
        column_names (list): List of column names for the table.
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
            INSERT INTO {table} ({columns}) VALUES %s
        """).format(
            table=sql.Identifier(table_name),
            columns=sql.SQL(", ").join(map(sql.Identifier, column_names))
        )

        # Prepare data rows for insertion
        rows = [[row.get(col) for col in column_names] for row in data]

        # Batch insert data
        logging.info("Inserting data into the database...")
        execute_values(cur, insert_query, rows)

        # Commit changes
        conn.commit()
        logging.info(f"Inserted {len(rows)} records into the database.")
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



