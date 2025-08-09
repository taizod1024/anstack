#!/bin/bash

# Apache Airflow初期化スクリプト
# 初回実行時にAirflowデータベースを初期化します

echo "🔧 Airflow初期化を開始します..."

# Airflowデータベース初期化
echo "📊 Airflowデータベースを初期化中..."
docker exec airflow-webserver airflow db init

# 管理者ユーザー作成
echo "👤 管理者ユーザーを作成中..."
docker exec airflow-webserver airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@anstack.local

# PostgreSQL接続設定
echo "🗄️ PostgreSQL接続を設定中..."
docker exec airflow-webserver airflow connections add \
    --conn-id postgres_default \
    --conn-type postgres \
    --conn-host postgres \
    --conn-schema "${APP_DB_NAME:-anstack}" \
    --conn-login "${APP_DB_USERNAME:-anstack}" \
    --conn-password "${APP_DB_PASSWORD:-password}" \
    --conn-port 5432

echo "✅ Airflow初期化完了"
echo ""
echo "🌐 Airflow Web UI: http://localhost:8081"
echo "👤 ユーザー名: admin"
echo "🔑 パスワード: （作成時に設定したパスワード）"
