# Phase 2 Verification（ハイブリッド ID / Bastion）

## Step 2-2：Azure Bastion 監査ログ取得

### 実施内容
- Azure Bastion に Diagnostic Settings を設定
- Log Analytics Workspace（law-entra-id-lab）へ送信

### 検証内容
- MicrosoftAzureBastionAuditLogs が取得できること
- RDP 接続操作が OperationName として記録されること

- ☑  Bastion 診断設定が Log Analytics に送信されている
- ☑  MicrosoftAzureBastionAuditLogs を確認
- ☑  RDP 接続操作が監査ログとして記録されている
- ☑  スクリーンショットを証跡として保存済み

### 検証手順
```kql
MicrosoftAzureBastionAuditLogs
| where TimeGenerated > ago(30d)
| order by TimeGenerated desc
| take 50
```

## Step 2-3：AD 用サブネット設計

- ☑  AD/Cloud Sync 用に snet-ad を分離
- ☑  Bastion 専用サブネット（AzureBastionSubnet）を分離
- ☑  CIDR が将来拡張を考慮した設計になっている
- ☑  アーキテクチャ図で第三者に説明可能

## Step 2-4：Cloud Sync 導入準備（設計）

- ☑  同期対象OUを専用OUに限定する方針を確定
- ☑  同期対象（User/Group）と非対象（Computer）を定義
- ☑  UPN/DisplayName の属性方針を定義
- ☑  運用ルール（変更管理）とロールバック方針を文書化
- [ ] （VM 作成後）Cloud Sync エージェント導入・同期検証に進む



