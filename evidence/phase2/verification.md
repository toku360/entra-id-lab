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

## Step 2-5：AD 用 VM 追加（Terraform）

- ☑  snet-ad に Windows Server 2022 VM を配置
- ☑　Public IP なし（Bastion 前提）
- ☑] Terraform plan/apply のログを保存
- ☑  Portal 画面のスクリーンショット取得

## Step 2-6：Bastion 経由 RDP 接続

- ☑  Public IP を持たない AD VM に Bastion 経由で RDP 接続
- ☑  初回ログインに成功
- ☑  Bastion の接続操作が LAW に記録されている
- ☑  スクリーンショットで証跡を保存

## Step 2-7 Verification（AD DS 導入前）

- ☑  vm-dc01 に Bastion 経由で接続できる
- ☑  DNS が Azure 既定（168.63.129.16）を向いている
- ☑  NTDS / DNS サービスが未導入であることを確認
- ☑  Get-ADDomain が未実行であることを確認（想定どおり）

## Step 2-8 AD DS 構築

- ☑  AD-Domain-Services ロール導入
- ☑  新規フォレスト作成（entra-id.lab）
- ☑  NTDS / DNS サービス稼働確認
- ☑  Get-ADDomain 実行成功

## Step 2-9：VNet DNS を AD VM に向ける

- ☑  VNet (vnet-lab) の DNS サーバーが AD VM (10.10.10.4) に設定されている
- ☑  AD VM 自身の DNS が 127.0.0.1 を参照している
- ☑  nslookup entra-id.lab が AD DNS で解決できる
- ☑  次ステップ（ドメイン参加 / Cloud Sync）の前提条件を満たす

🧠 Point

「なぜ Azure 既定 DNS を使わないのか？」

・AD DS を使う場合、SRV レコードやゾーン管理が必須
・Azure 既定 DNS では AD 機能は提供されないため VNet レベルで DNS を DC に向ける設計とした
・ゼロトラスト前提でも、内部名前解決は AD が行う

## Step 2-10 ドメイン参加

- ☑  ad01 ドメイン参加成功


## Step 2-12 Cloud Sync Agent 導入（ad01）

- ☑  ad01 から DC(10.10.10.4) へ疎通できる（ping / SRV lookup）
- ☑  ad01 から login.microsoftonline.com:443 に到達できる（Test-NetConnection）
- ☑  Cloud Sync Agent を ad01 にインストールした（完了画面スクショ）
- ☑  Entra Cloud Sync の Agents に ad01 が登録され Online 相当になった（スクショ）






