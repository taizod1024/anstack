// ANStack 統一JSライブラリ
// 全Appsmithアプリで必須インポート

export const ANStackStandards = {
  // 統一カラーパレット
  colors: {
    primary: '#0066cc',
    primaryDark: '#004080',
    secondary: '#6c757d',
    success: '#28a745',
    danger: '#dc3545',
    warning: '#ffc107',
    info: '#17a2b8',
    light: '#f8f9fa',
    dark: '#343a40'
  },
  
  // 統一スタイル設定
  styles: {
    button: {
      borderRadius: '8px',
      fontWeight: '600',
      padding: '12px 24px'
    },
    input: {
      borderRadius: '8px',
      border: '1px solid #ced4da',
      height: '40px'
    },
    container: {
      borderRadius: '8px',
      border: '1px solid #e9ecef',
      padding: '24px',
      backgroundColor: '#ffffff'
    }
  },
  
  // 統一バリデーション
  validators: {
    email: (value) => {
      const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return regex.test(value) || "有効なメールアドレスを入力してください";
    },
    
    required: (value) => {
      return (value && value.length > 0) || "必須項目です";
    },
    
    minLength: (min) => (value) => {
      return (value && value.length >= min) || `${min}文字以上で入力してください`;
    }
  },
  
  // 統一フォーマッター
  formatters: {
    currency: (value) => {
      return new Intl.NumberFormat('ja-JP', {
        style: 'currency',
        currency: 'JPY'
      }).format(value);
    },
    
    date: (date) => {
      return new Date(date).toLocaleDateString('ja-JP');
    },
    
    percentage: (value) => {
      return `${(value * 100).toFixed(1)}%`;
    }
  },
  
  // 統一メッセージ
  messages: {
    success: {
      save: 'データを保存しました',
      delete: 'データを削除しました',
      update: 'データを更新しました'
    },
    error: {
      network: 'ネットワークエラーが発生しました',
      validation: '入力内容を確認してください',
      permission: 'アクセス権限がありません'
    }
  },
  
  // 統一設定適用関数
  applyStandardStyles: (widget) => {
    // 標準スタイルを強制適用
    return {
      ...widget,
      borderRadius: ANStackStandards.styles.container.borderRadius,
      backgroundColor: ANStackStandards.colors.light
    };
  }
};

// 使用例：
// {{ANStackStandards.colors.primary}}
// {{ANStackStandards.validators.email(EmailInput.text)}}
// {{ANStackStandards.formatters.currency(1000)}}
