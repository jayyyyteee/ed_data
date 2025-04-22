# Education Data Analysis Platform

A data pipeline and visualization platform for educational data analysis. This project combines Airflow for ETL processes, PostgreSQL for data storage, and Apache Superset for data visualization.

## Overview

This project provides a comprehensive stack for educational data analytics:

- **Airflow**: Orchestrates data pipelines and ETL processes
- **PostgreSQL**: Stores both operational data and analytics results
- **Apache Superset**: Provides interactive dashboards and visualizations
- **dbt**: Transforms raw data into analytics-ready models

## Prerequisites

- Docker and Docker Compose
- Git
- 4GB+ RAM available for containers

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/jayyyyteee/ed_data.git
   cd ed_data
   ```

2. **Create environment file**
   Create a `.env` file in the project root with the following content:
   ```
   # PostgreSQL Configuration
   POSTGRES_USER=airflow
   POSTGRES_PASSWORD=password
   POSTGRES_HOST=postgres
   POSTGRES_PORT=5432
   POSTGRES_DB=airflow_db

   AIRFLOW_UID=1000
   AIRFLOW_GID=0

   # Airflow Metadata Database
   AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:password@postgres:5432/airflow_db

   # Application Database (For ETL)
   APPLICATION_DB=airflow

   # Airflow Configuration
   AIRFLOW__CORE__EXECUTOR=LocalExecutor
   AIRFLOW__CORE__LOAD_EXAMPLES=False
   AIRFLOW__WEBSERVER__DEFAULT_USER=admin
   AIRFLOW__WEBSERVER__DEFAULT_PASSWORD=password
   AIRFLOW__WEBSERVER__SECRET_KEY=YOUR_AIRFLOW_SECRET_KEY_HERE

   # dbt Configuration
   DBT_PROFILES_DIR=/opt/airflow/.dbt

   # Superset Configuration
   SUPERSET_SECRET_KEY=YOUR_SUPERSET_SECRET_KEY_HERE
   ```
   
   Generate secure random keys for both Airflow and Superset:
   ```bash
   # For Airflow (32 bytes in hexadecimal)
   openssl rand -hex 32
   
   # For Superset (42 bytes in base64)
   openssl rand -base64 42
   ```
   Replace `YOUR_AIRFLOW_SECRET_KEY_HERE` and `YOUR_SUPERSET_SECRET_KEY_HERE` with the respective generated keys.

3. **Build and start containers**
   ```bash
   docker-compose up -d --build
   ```

4. **Wait for initialization**
   It may take a few minutes for all services to initialize the first time.

5. **Access the services**
   - Airflow: http://localhost:8080 (username: admin, password: password)
   - Superset: http://localhost:8088 (username: admin, password: admin)
   - PostgreSQL: localhost:5432 (username: airflow, password: password)

## Project Structure

- `/dags`: Airflow DAG definitions for data pipelines
- `/dags/scripts`: Python scripts used by Airflow tasks
- `/dbt_project`: dbt models for data transformation
- `/init.sql`: Initial database schema for PostgreSQL

## Using Superset

1. Log in to Superset at http://localhost:8088
2. Connect to the PostgreSQL database:
   - Go to Data → Databases → + Database
   - Select PostgreSQL
   - Use the connection string: `postgresql://airflow:password@postgres:5432/airflow_db`
3. Create datasets, charts, and dashboards using the data

## Troubleshooting

- **Port conflicts**: If you have services already using ports 8080, 8088, or 5432, modify the port mappings in docker-compose.yml
- **Container failures**: Check logs with `docker-compose logs service_name`
- **Database connection issues**: Ensure PostgreSQL is healthy with `docker-compose ps`

## Development

To add your own data pipelines:
1. Create new DAGs in the `/dags` directory
2. Add any supporting scripts to `/dags/scripts`
3. Create dbt models in `/dbt_project` for data transformation
4. Restart Airflow to pick up new DAGs: `docker-compose restart airflow-webserver airflow-scheduler`

## Stopping the Stack

```bash
docker-compose down
```

To completely reset and remove all data:
```bash
docker-compose down -v
```

## License

[MIT License](LICENSE)
