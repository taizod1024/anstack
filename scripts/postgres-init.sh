#!/bin/bash
set -e

# Create n8n database and user
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE n8n;
    CREATE USER n8n WITH PASSWORD 'n8npass';
    GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n;
    
    -- Grant permissions on the public schema
    \c n8n;
    GRANT ALL ON SCHEMA public TO n8n;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO n8n;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO n8n;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO n8n;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO n8n;
EOSQL