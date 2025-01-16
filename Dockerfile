# Use the official Airflow image as the base
FROM apache/airflow:2.7.1

# Switch to root to install additional dependencies
USER root

# Install required system dependencies including dbt
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    python3-dev \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


USER airflow
# Install dbt for PostgreSQL
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir dbt-postgres pandas openpyxl

# Switch back to the default user, airflow
