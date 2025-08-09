# ANStack
エンタープライズ対応の統合開発・自動化プラットフォーム  
**Apache 2.0ライセンス** - SaaS提供可能

## 🚀 技術スタック

| コンポーネント | 役割 | ライセンス | ポート |
|---------------|------|-----------|--------|
| **Appsmith** | ローコードUI開発 | Apache 2.0 | 8080 |
| **Apache Airflow** | ワークフロー自動化 | Apache 2.0 | 8081 |
| **PostgreSQL** | データベース | PostgreSQL | 5432 |

## ✨ 特徴

- 🎨 **デザイン統制**: 統一されたコーポレートテーマ
- 📊 **データ統合**: PostgreSQL中心のデータアーキテクチャ  
- 🔄 **ワークフロー**: Airflowによる高度な自動化
- 🏢 **SaaS対応**: Apache 2.0で商用利用・再配布可能
- 🛡️ **品質管理**: 自動化された品質チェック体制

## 🛠️ クイックスタート

```bash
# 環境起動
docker compose up -d

# 品質チェック実行  
./scripts/quality-check.sh

# Airflow初期化（初回のみ）
./scripts/airflow-init.sh
```

## 📱 アクセス

- **Appsmith**: http://localhost:8080
- **Airflow**: http://localhost:8081  
- **PostgreSQL**: localhost:5432

## 📚 ドキュメント

- [Appsmith開発ガイド](./docs/appsmith.md)
- [開発標準・ガイドライン](./appsmith/APPSMITH_STANDARDS.md)  
- [テンプレート活用法](./docs/TEMPLATE_GUIDE.md)

## ⚖️ ライセンス

**Apache 2.0** - 商用利用・SaaS提供・再配布可能

---
**ANStack** - あなたのアイデアを素早く形にする統合開発環境
