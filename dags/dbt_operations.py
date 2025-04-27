from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

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
    'dbt_operations',
    default_args=default_args,
    schedule_interval=None, 
    catchup=False,
    description='Run dbt commands for data transformation and testing',
)

# dbt run task
dbt_run = BashOperator(
    task_id='dbt_run',
    bash_command='dbt run --profiles-dir /opt/airflow/.dbt --project-dir /opt/airflow/dbt_project --debug',
    retries=0,
    retry_delay=timedelta(minutes=3),
    dag=dag
)

# dbt test task
dbt_test = BashOperator(
    task_id='dbt_test',
    bash_command='dbt test --profiles-dir /opt/airflow/.dbt --project-dir /opt/airflow/dbt_project --debug',
    retries=0,
    retry_delay=timedelta(minutes=3),
    dag=dag
)

# Task dependencies
dbt_run >> dbt_test
