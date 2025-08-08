#!/bin/bash
set -e

# Create n8n database and user
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE n8n;
    CREATE USER n8n WITH PASSWORD 'n8npass';
    GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n;
EOSQL