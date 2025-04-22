import os

# The SQLAlchemy connection string to your database
SQLALCHEMY_DATABASE_URI = f"postgresql+psycopg2://{os.environ.get('POSTGRES_USER')}:{os.environ.get('POSTGRES_PASSWORD')}@{os.environ.get('POSTGRES_HOST')}:{os.environ.get('POSTGRES_PORT')}/{os.environ.get('POSTGRES_DB')}"

# Use the same database for examples
SQLALCHEMY_EXAMPLES_URI = SQLALCHEMY_DATABASE_URI

# Flask-WTF settings
WTF_CSRF_ENABLED = True
WTF_CSRF_EXEMPT_LIST = ['superset.views.core.log']

# Allow public roles to access some dashboards
PUBLIC_ROLE_LIKE = 'Gamma'

# Cache configuration
CACHE_CONFIG = {
    'CACHE_TYPE': 'simple',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24,  # 1 day default (in seconds)
}

# Timeout duration for SQL Lab synchronous queries
SQLLAB_TIMEOUT = 30  # seconds

# Timeout duration for SQL Lab asynchronous queries
SQLLAB_ASYNC_TIME_LIMIT_SEC = 60 * 60  # 1 hour

# Feature flags
FEATURE_FLAGS = {
    "ALERT_REPORTS": True,
    "EMBEDDED_SUPERSET": True,
    "ENABLE_TEMPLATE_PROCESSING": True,
} 