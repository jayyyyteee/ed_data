from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta
import logging
import os

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 1, 1),
    'retries': 3,  # Set the number of retries
    'retry_delay': timedelta(minutes=2),  # Set the delay between retries
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
}

# Define the DAG
dag = DAG(
    'fetch_and_load_api_data',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
    description='A DAG to fetch API data for multiple tables, transform, and load it into Postgres, followed by dbt operations',
)

# Logging setup
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# Dynamic Python task function
def task_to_run(api_url, table_name, new_api=False):
    logging.info(f"Starting the fetch_and_load_data task for table {table_name}.")
    try:
        scripts_path = os.path.join(os.getenv('AIRFLOW_HOME', '/opt/airflow'), 'scripts')
        if scripts_path not in os.sys.path:
            os.sys.path.append(scripts_path)

        if new_api:
            from fetch_and_load_data import fetch_data_assessment_api, transform_data_assessment_api, load_data_to_postgres
            records = fetch_data_assessment_api(api_url)
            data, columns = transform_data_assessment_api(records)
        else:
            from fetch_and_load_data import fetch_data, transform_data, load_data_to_postgres
            features = fetch_data(api_url)
            data, columns = transform_data(features)

        load_data_to_postgres(data, columns, table_name)
        logging.info(f"Task completed successfully for table {table_name}.")
    except Exception as e:
        logging.error(f"Task failed with error: {e}")
        raise

def task_to_run2(api_url, table_name):
    """
    Fetch data from an API, transform it, and load into PostgreSQL.
    Args:
        api_url (str): API endpoint for fetching data.
        table_name (str): Target table in PostgreSQL.
    """
    logging.info(f"Starting the fetch_and_load_data task for table {table_name}.")
    try:
        # Adjust path if necessary based on your Docker setup
        scripts_path = os.path.join(os.getenv('AIRFLOW_HOME', '/opt/airflow'), 'scripts')
        if scripts_path not in os.sys.path:
            os.sys.path.append(scripts_path)

        from fetch_and_load_data import fetch_data_no_pagination, transform_data2, load_data_to_postgres

        # Fetch, transform, and load data
        headers,rows = fetch_data_no_pagination(api_url)
        transformed_data, column_names = transform_data2(headers,rows)
        load_data_to_postgres(transformed_data, column_names, table_name)

        logging.info(f"Task completed successfully for table {table_name}.")
    except Exception as e:
        logging.error(f"Task failed with error: {e}")
        raise

def load_txt_file_to_postgres(file_path, table_name):
    """
    Load a text file into a PostgreSQL table.

    Args:
        file_path (str): Path to the text file.
        table_name (str): The target database table name.
    """
    logging.info(f"Starting to process text file at {file_path}.")
    try:
        scripts_path = os.path.join(os.getenv('AIRFLOW_HOME', '/opt/airflow'), 'scripts')
        if scripts_path not in os.sys.path:
            os.sys.path.append(scripts_path)
        
        from fetch_and_load_data import load_data_to_postgres
        import pandas as pd
        # Read the text file into a DataFrame
        df = pd.read_csv(file_path, sep='\t')

        # Clean up data (optional: handle NaNs, data types, etc.)
        # df = df.fillna(value=0)  # Replace NaN for SQL compatibility

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

def process_csv_file(csv_file_path, table_name):
    logging.info(f"Starting to process file {csv_file_path} for table {table_name}.")
    try:
        # Adjust path if necessary based on your Docker setup
        scripts_path = os.path.join(os.getenv('AIRFLOW_HOME', '/opt/airflow'), 'scripts')
        if scripts_path not in os.sys.path:
            os.sys.path.append(scripts_path)
        
        from fetch_and_load_data import load_data_to_postgres
        import pandas as pd

        # Read the caret-delimited text file
        df = pd.read_csv(
            csv_file_path,
            delimiter='^',
            encoding='utf-8',
            encoding_errors='replace',
            dtype=str  # Read all columns as strings
        )

        # Log the first few rows for debugging
        logging.info(f"First rows of the dataset:\n{df.head()}")

        # Optionally clean data
        df.replace({"*": None, "NaN": None}, inplace=True)

        # Log the cleaned data for debugging
        logging.info(f"Data after type conversion:\n{df.dtypes}")

        # Load into PostgreSQL (assuming `load_data_to_postgres` handles insertion)
        data = df.to_dict(orient='records')
        column_names = df.columns.tolist()
        load_data_to_postgres(data, column_names, table_name)
    
    except Exception as e:
        logging.error(f"Failed to process file with error: {e}")
        raise

# Python callable for loading Excel sheets
def load_excel_data_task():
    """
    Task to load data from an Excel file into PostgreSQL.
    """
    logging.info("Starting to load Excel sheets into PostgreSQL tables.")
    try:
        # Path to the Excel file
        excel_file_path = '/opt/airflow/dags/scripts/data/esser_data.xlsx'  
        table_name_mapping = {
            'cares': 'esser_cares',
            'crrsa': 'esser_crrsa',
            'arp': 'esser_arp'
        }
        scripts_path = os.path.join(os.getenv('AIRFLOW_HOME', '/opt/airflow'), 'scripts')
        if scripts_path not in os.sys.path:
            os.sys.path.append(scripts_path)

        from fetch_and_load_data import load_excel_sheets_to_postgres
        load_excel_sheets_to_postgres(excel_file_path, table_name_mapping)
        logging.info("Successfully loaded Excel sheets into PostgreSQL tables.")
    except Exception as e:
        logging.error(f"Failed to load Excel sheets with error: {e}")
        raise
       
# Define API URLs and table names
#Documentation for district funding api https://api.census.gov/data/timeseries/govs/variables.html
district_funding_api_url = (
    "https://api.census.gov/data/timeseries/govs?get=SVY_COMP,GOVTYPE,AGG_DESC_LABEL,AGG_DESC,FINSRC,ENROLLSZE,NAME,EXPENDTYPE,AMOUNT_PUPIL,AMOUNT,AMOUNT_CHANGE,YEAR&for=school%20district%20(unified):*&time=2022&key=307269891283336609036ec03b90a9576a660caa"
)

district_funding_table_name = "district_funding"

school_district_boundaries_api_url = (
    "https://services1.arcgis.com/Ua5sjt3LWTPigjyD/arcgis/rest/services/School_Districts_Current/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json&returnGeometry=false"
)
school_district_boundaries_table_name = "school_district_boundaries"



school_district_characteristics_api_url = (
    "https://services1.arcgis.com/Ua5sjt3LWTPigjyD/arcgis/rest/services/School_District_Characteristics_Current/FeatureServer/1/query?where=1%3D1&outFields=*&outSR=4326&f=json&returnGeometry=false"
)

school_district_characteristics_table_name = "school_district_characteristics"

public_schools_locations_api_url = (
    "https://nces.ed.gov/opengis/rest/services/K12_School_Locations/EDGE_GEOCODE_PUBLICSCH_2223/MapServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
)
public_schools_locations_table_name = "public_school_locations"

private_schools_api_url = (
    "https://services1.arcgis.com/Ua5sjt3LWTPigjyD/arcgis/rest/services/Private_School_Locations_Current/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
)
private_schools_table_name = "private_school_locations"

neighborhood_pov_api_url = (
    "https://services1.arcgis.com/Ua5sjt3LWTPigjyD/"
    "arcgis/rest/services/School_Neighborhood_Poverty_Estimates_Current/"
    "FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
)
neighborhood_pov_table_name = "neighborhood_pov"

public_schools_characteristics_api_url = (
    "https://services1.arcgis.com/Ua5sjt3LWTPigjyD/arcgis/rest/services/School_Characteristics_Current/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
    )
public_schools_characteristics_table_name = "public_school_characteristics"


assessment_results_file_path = '/opt/airflow/dags/scripts/data/sb_ca2024_1_csv_v1.txt'  
assessment_results_table_name = 'student_assessment_results'    
assessment_api_url = "https://educationdata.urban.org/api/v1/school-districts/edfacts/assessments/2020/grade-99/"
assessment_api_table_name = 'district_assessment_results' 
fundingdatadistrictnew = '/opt/airflow/dags/scripts/data/sdf22_1a.txt'
fundingdatadistrictnew_table_name = 'district_funding_new' 

run_fundingdatadistrictnew_script = PythonOperator(
    task_id='run_fundingdatadistrictnew_script',
    python_callable=load_txt_file_to_postgres,
    op_args=[fundingdatadistrictnew, fundingdatadistrictnew_table_name],
    dag=dag
)


run_district_assessment_script = PythonOperator(
    task_id='run_district_assessment_script',
    python_callable=task_to_run,
    op_args=[assessment_api_url, assessment_api_table_name, True],
    dag=dag
)

process_assessment_results_file = PythonOperator(
    task_id='process_assessment_results_file',
    python_callable=process_csv_file,
    op_args=[assessment_results_file_path, assessment_results_table_name],
    dag=dag
)



run_school_district_funding = PythonOperator(
    task_id='run_fetch_and_load_district_funding',
    python_callable=task_to_run2,
    op_args=[district_funding_api_url, district_funding_table_name],
    dag=dag
)

load_funding_data_task = PythonOperator(
    task_id='load_excel_data',
    python_callable=load_excel_data_task,
    dag=dag
)

run_school_district_boundaries_script = PythonOperator(
    task_id='run_fetch_and_load_school_district_boundaries',
    python_callable=task_to_run,
    op_args=[school_district_boundaries_api_url, school_district_boundaries_table_name],
    dag=dag
)
run_school_district_characteristics_script = PythonOperator(
    task_id='run_fetch_and_load_school_district_characteristics',
    python_callable=task_to_run,
    op_args=[school_district_characteristics_api_url, school_district_characteristics_table_name],
    dag=dag
)

run_neighborhood_pov_script = PythonOperator(
    task_id='run_fetch_and_load_neighborhood_pov',
    python_callable=task_to_run,
    op_args=[neighborhood_pov_api_url, neighborhood_pov_table_name],
    dag=dag
)

run_public_schools_script = PythonOperator(
    task_id='run_fetch_and_load_public_schools',
    python_callable=task_to_run,
    op_args=[public_schools_characteristics_api_url, public_schools_characteristics_table_name],
    dag=dag
)

run_private_schools_script = PythonOperator(
    task_id='run_fetch_and_load_private_schools',
    python_callable=task_to_run,
    op_args=[private_schools_api_url, private_schools_table_name],
    dag=dag
)

run_public_schools_location_script = PythonOperator(
    task_id='run_fetch_and_load_public_schools_location',
    python_callable=task_to_run,
    op_args=[public_schools_locations_api_url, public_schools_locations_table_name],
    dag=dag
)

dbt_run = BashOperator(
    task_id='dbt_run',
    bash_command='dbt run --profiles-dir /opt/airflow/.dbt --project-dir /opt/airflow/dbt_project --debug',
    retries=0,
    retry_delay=timedelta(minutes=3),
    dag=dag
)

dbt_test = BashOperator(
    task_id='dbt_test',
    bash_command='dbt test --profiles-dir /opt/airflow/.dbt --project-dir /opt/airflow/dbt_project --debug',
    retries=0,
    retry_delay=timedelta(minutes=3),
    dag=dag
)


# Define task dependencies
[
    run_district_assessment_script,
    process_assessment_results_file,
    run_school_district_funding,
    load_funding_data_task,
    run_school_district_boundaries_script,
    run_school_district_characteristics_script,
    run_neighborhood_pov_script,
    run_public_schools_script,
    run_private_schools_script,
    run_public_schools_location_script
] >> dbt_test >> dbt_run





