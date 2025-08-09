"""
Apache Airflow DAG Example: PostgreSQL Integration Demo
完全フリー（Apache 2.0ライセンス）でSaaS提供可能なワークフロー自動化

このDAGは以下を実行します：
1. PostgreSQLデータベース接続テスト
2. サンプルデータの処理
3. レポート生成
"""

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook

default_args = {
    'owner': 'anstack',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'postgres_integration_demo',
    default_args=default_args,
    description='PostgreSQL統合デモワークフロー',
    schedule_interval='@daily',
    catchup=False,
    tags=['database', 'reporting', 'demo'],
)

def test_postgres_connection():
    """PostgreSQL接続テスト"""
    hook = PostgresHook(postgres_conn_id='postgres_default')
    connection = hook.get_conn()
    cursor = connection.cursor()
    
    # 簡単なクエリを実行
    cursor.execute("SELECT version();")
    result = cursor.fetchone()
    
    print(f"PostgreSQL Version: {result[0]}")
    
    cursor.close()
    connection.close()
    return "PostgreSQL接続成功"

def process_sample_data():
    """サンプルデータ処理"""
    hook = PostgresHook(postgres_conn_id='postgres_default')
    
    # サンプルデータの処理ロジック
    records_processed = 100  # 実際のデータ処理結果
    
    print(f"処理済みレコード数: {records_processed}")
    return records_processed

def generate_report():
    """レポート生成"""
    import json
    
    report = {
        'date': datetime.now().isoformat(),
        'workflow': 'postgres_integration_demo',
        'status': 'completed',
        'records_processed': 100,
        'execution_time': '5.2 seconds'
    }
    
    print(f"生成されたレポート: {json.dumps(report, indent=2, ensure_ascii=False)}")
    return report

# タスク定義
test_connection_task = PythonOperator(
    task_id='test_postgres_connection',
    python_callable=test_postgres_connection,
    dag=dag,
)

create_table_task = PostgresOperator(
    task_id='create_sample_table',
    postgres_conn_id='postgres_default',
    sql="""
    CREATE TABLE IF NOT EXISTS workflow_log (
        id SERIAL PRIMARY KEY,
        workflow_name VARCHAR(100),
        execution_date TIMESTAMP,
        status VARCHAR(20),
        records_processed INTEGER
    );
    """,
    dag=dag,
)

process_data_task = PythonOperator(
    task_id='process_sample_data',
    python_callable=process_sample_data,
    dag=dag,
)

log_execution_task = PostgresOperator(
    task_id='log_workflow_execution',
    postgres_conn_id='postgres_default',
    sql="""
    INSERT INTO workflow_log (workflow_name, execution_date, status, records_processed)
    VALUES ('postgres_integration_demo', NOW(), 'completed', 100);
    """,
    dag=dag,
)

generate_report_task = PythonOperator(
    task_id='generate_report',
    python_callable=generate_report,
    dag=dag,
)

# タスク依存関係の定義
test_connection_task >> create_table_task >> process_data_task >> log_execution_task >> generate_report_task
