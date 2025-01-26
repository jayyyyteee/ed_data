from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta
import logging
import os
from api_to_postgres import load_txt_file_to_postgres


# Default arguments
default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 1, 1),
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
}

# Define the DAG
dag = DAG(
    'newfundingdata',
    default_args=default_args,
    schedule_interval=None,  # Can be triggered manually or by ingestion DAG
    catchup=False,
    description='Run new funding script for data transformation and testing',
)

# dbt run task
fundingdatadistrictnew = '/opt/airflow/dags/scripts/data/sdf22_1a.txt'
fundingdatadistrictnew_table_name = "district_funding_new" 

run_fundingdatadistrictnew_script = PythonOperator(
    task_id='run_fundingdatadistrictnew_script',
    python_callable=load_txt_file_to_postgres,
    op_args=[fundingdatadistrictnew, fundingdatadistrictnew_table_name],
    dag=dag
)
