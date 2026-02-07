# Phase 2 Verification

## Step 2-1：Windows Server VM 作成（Bastion前提）

- Terraform plan/apply 実行ログ：evidence/phase2/logs/
- Portal スクリーンショット：evidence/phase2/screenshots/

### 確認項目
- ☑  VM（vm-dc01）が作成されている
- ☑  Public IP が付与されていない
- ☑  snet-ad が作成されている
- ☑  NSG で RDP(3389) は BastionSubnet からのみ許可

