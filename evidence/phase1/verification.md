# Phase1 Verification

- ☑  Terraform apply がエラーなく完了した
- ☑  RG が作成されている
- ☑  VNet / Subnet / BastionSubnet が存在する
- ☑  Log Analytics Workspace が作成されている
- ☑  Bastion が Standard SKU で作成されている
- ☑  Azure CLI で全リソースを確認できた

## Log Analytics Workspace 状態確認

### 実行クエリ

## Log Analytics Workspace 状態確認

### 実行クエリ

search "*"
| summarize Count=count() by $table
| sort by Count desc

### 結果
- AzureMetrics が取得されていることを確認
- Usage テーブルが存在することを確認
- AzureDiagnostics / AzureActivity は未取得

### 判断
- Log Analytics Workspace は正常に稼働している
- Phase 1 では VM を作成していないため、
  Bastion 接続ログや管理操作ログは未発生
- ログ未取得は設計どおりであり、
  Phase 2（VM 作成・Bastion 接続）で取得予定


