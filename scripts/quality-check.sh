#!/bin/bash
# Appsmith品質チェック自動化スクリプト

echo "=== ANStack Appsmith 品質チェック ==="

# 1. テーマ適用確認
echo "1. テーマファイル確認中..."
if [ -f "/home/taizo/projects/anstack/appsmith/theme/corporate-theme.json" ]; then
    echo "✅ コーポレートテーマファイル存在"
else
    echo "❌ コーポレートテーマファイルが見つかりません"
    exit 1
fi

# 2. 標準JSライブラリ確認
echo "2. 標準ライブラリ確認中..."
if [ -f "/home/taizo/projects/anstack/appsmith/standards.js" ]; then
    echo "✅ ANStackStandards.js存在"
else
    echo "❌ 標準ライブラリが見つかりません"
    exit 1
fi

# 3. Docker環境確認
echo "3. Docker環境確認中..."
if docker compose ps | grep -q "appsmith.*Up"; then
    echo "✅ Appsmithコンテナ稼働中"
else
    echo "❌ Appsmithコンテナが停止しています"
    echo "docker compose up -d で起動してください"
    exit 1
fi

# 4. PostgreSQL接続確認
echo "4. データベース接続確認中..."
if docker compose exec postgres pg_isready -U postgres; then
    echo "✅ PostgreSQL接続OK"
else
    echo "❌ PostgreSQL接続エラー"
    exit 1
fi

# 5. テーマファイルの検証
echo "5. テーマファイル構文確認中..."
if jq . /home/taizo/projects/anstack/appsmith/theme/corporate-theme.json > /dev/null 2>&1; then
    echo "✅ テーマファイルのJSON構文OK"
else
    echo "❌ テーマファイルのJSON構文エラー"
    exit 1
fi

# 6. 統一カラーパレット確認
echo "6. カラーパレット確認中..."
PRIMARY_COLOR=$(jq -r '.colors.primary' /home/taizo/projects/anstack/appsmith/theme/corporate-theme.json)
if [ "$PRIMARY_COLOR" = "#0066cc" ]; then
    echo "✅ プライマリカラー統一済み ($PRIMARY_COLOR)"
else
    echo "⚠️ プライマリカラーが標準と異なります ($PRIMARY_COLOR)"
fi

echo ""
echo "=== 品質チェック完了 ==="
echo "🎯 Appsmith統制環境の準備完了"
echo ""
echo "次のステップ:"
echo "1. http://localhost:8080 でAppsmithにアクセス"
echo "2. 初回セットアップ実行"
echo "3. テンプレートアプリケーション作成"
echo "4. コーポレートテーマ適用確認"
echo ""
echo "📋 開発者向けリソース:"
echo "- 開発ガイドライン: docs/APPSMITH_STANDARDS.md"
echo "- テンプレート使用法: docs/TEMPLATE_GUIDE.md"
echo "- 標準ライブラリ: appsmith/standards.js"
