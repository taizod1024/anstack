# Appsmith テンプレート使用ガイド

## 1. CRUDテンプレート (CRUD_Template)

### 必須要素
```javascript
// データソース設定
const CRUD_CONFIG = {
  table: 'employees',
  primaryKey: 'id',
  fields: {
    name: { type: 'text', required: true },
    email: { type: 'email', required: true },
    department: { type: 'select', options: ['営業', '開発', '総務'] }
  }
};

// 統一クエリ命名
- GetRecords_{{tableName}}
- CreateRecord_{{tableName}}
- UpdateRecord_{{tableName}}
- DeleteRecord_{{tableName}}
```

### レイアウト構造
1. **ヘッダー**: タイトル + 新規作成ボタン
2. **フィルター**: 検索・絞り込み機能
3. **データテーブル**: 標準グリッド表示
4. **フッター**: ページネーション

## 2. ダッシュボードテンプレート (Dashboard_Template)

### 必須コンポーネント
- **KPIカード**: 4つの主要指標
- **グラフエリア**: Chart.jsまたはApexCharts使用
- **データテーブル**: 最新データ表示
- **フィルター**: 期間・カテゴリ選択

### レイアウト
```
┌─────────────────────────────────────┐
│ [KPI1] [KPI2] [KPI3] [KPI4]        │
├─────────────────────────────────────┤
│ [大きなグラフ]    │ [小さなグラフ]  │
│                   │                 │
├─────────────────────────────────────┤
│ [データテーブル]                    │
└─────────────────────────────────────┘
```

## 3. フォームテンプレート (Form_Template)

### 必須機能
```javascript
// バリデーション設定
const FORM_VALIDATION = {
  onSubmit: () => {
    // ANStackStandards.validators使用
    const errors = {};
    if (!ANStackStandards.validators.required(NameInput.text)) {
      errors.name = '名前は必須です';
    }
    return errors;
  }
};
```

### フォーム構成
1. **入力エリア**: 標準入力コンポーネント使用
2. **バリデーション**: リアルタイム検証
3. **アクションボタン**: 保存・キャンセル・リセット
4. **確認ダイアログ**: 重要操作時の確認

## 4. 承認フローテンプレート (Approval_Template)

### ワークフロー段階
1. **申請**: 申請者による入力・提出
2. **一次承認**: 上長による確認
3. **最終承認**: 管理者による決裁
4. **完了**: 結果通知・アーカイブ

### 状態管理
```javascript
const APPROVAL_STATES = {
  DRAFT: '下書き',
  SUBMITTED: '申請中',
  APPROVED_L1: '一次承認済み',
  APPROVED_FINAL: '最終承認済み',
  REJECTED: '却下',
  COMPLETED: '完了'
};
```

## テンプレート使用手順

1. **テンプレート複製**: Fork元テンプレートをコピー
2. **設定カスタマイズ**: CONFIG変数を業務に合わせて変更
3. **デザイン適用**: corporate-theme.jsonの自動適用確認
4. **テスト実行**: 全機能の動作確認
5. **コードレビュー**: 品質チェックリスト実施
6. **本番デプロイ**: 承認後にPublish

## 品質チェックリスト

- [ ] ANStackStandards.jsをインポート済み
- [ ] 統一カラーパレット使用
- [ ] 必須バリデーション実装
- [ ] エラーハンドリング実装
- [ ] レスポンシブ対応確認
- [ ] アクセシビリティ対応
- [ ] パフォーマンステスト実行
