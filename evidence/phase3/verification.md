# Phase 3 Verification（SSO 検証環境 / Grafana VM）

## Step 3-1：Grafana VM を Terraform で作成（subnet-lab）

### 実施内容
- grafana-vm 用 Terraform スタックを新規作成
- 既存 core-infra を data 参照
- subnet-lab に Windows Server 2022 VM を作成
- Public IP を作成せず、Bastion 経由のみ接続可能とする
- NSG を NIC に関連付け

---

### 検証内容
- Terraform apply が正常終了していること
- VM が subnet-lab に配置されていること
- Public IP が存在しないこと
- NSG が NIC に紐づいていること
- RDP（3389）が AzureBastionSubnet のみ許可されていること
- Bastion 経由で RDP 接続できること

---

- ☑  grafana-vm stack apply 成功（ログ保存済み）
- ☑  terraform validate / plan 実行済み
- ☑  VM が subnet-lab に配置されている
- ☑  Public IP が存在しない
- ☑  NSG が NIC に関連付けられている
- ☑  Inbound 3389 が AzureBastionSubnet (10.10.2.0/26) のみ許可
- ☑  0.0.0.0/0 許可が存在しない
- ☑  Bastion 経由で RDP 成功
- ☑  VM 内で ipconfig により Private IP 確認済み
- ☑  スクリーンショットを証跡として保存済み

---

## Step 3-2：Windows に Grafana をインストール

### 実施内容
- Grafana MSI をダウンロード
- Windows Service としてインストール
- サービス起動確認
- ローカルアクセス確認

### 検証内容
- Grafana サービスが Running
- http://localhost:3000 にアクセス可能
- admin ログイン成功

- ☑  Grafana サービス起動確認済み
- ☑  ローカル WebUI 表示成功
- ☑  admin ログイン成功
- ☑  スクリーンショット保存済み


## Step 3-3：Entra ID OIDC 設定

### 実施内容
- App Registration 作成
- Redirect URI 設定
- Client Secret 作成
- 管理者同意（Admin Consent）実施
- Grafana に Generic OAuth 設定追加

### 検証内容
- AzureAD ログイン画面へリダイレクト
- SSO 成功
- Entra サインインログに記録されること
- ユーザー属性が正しくマッピングされていること

- ☑  App Registration 作成済み
- ☑  Client Secret 保存済み
- ☑  Grant admin consent 実施済み
- ☑  openid / profile / email のアクセス許可付与済み
- ☑  Grafana custom.ini に下記設定を追加済み

[auth.generic_oauth]
email_attribute_path = userPrincipalName
login_attribute_path = userPrincipalName
name_attribute_path = displayName

- ☑  Grafana に AzureAD ボタン表示
- ☑  SSO ログイン成功
- ☑  Entra サインインログ取得済み
- ☑  スクリーンショット保存済み


## Step 3-5：Conditional Access（Grafana専用MFA）

### 実施内容
- Security Defaults 無効化
- Microsoft Authenticator 認証方法ポリシー有効化
- CA-Grafana-MFA 作成（sync-test01 対象）
- レポート専用 → 有効化
- sync-test01 にて MFA 登録完了

### 検証内容
- Grafana ログイン時に MFA チャレンジ発生
- 条件付きアクセスで CA-Grafana-MFA が適用
- AuthenticationRequirement が multiFactorAuthentication
- ConditionalAccessStatus が success

- ☑  Security Defaults 無効
- ☑  Authenticator 有効
- ☑  sync-test01 MFA 登録完了
- ☑  CA-Grafana-MFA 有効化済み
- ☑  MFA チャレンジ発生確認
- ☑  サインインログ確認済み
- ☑  KQL 抽出確認済み
- ☑  スクリーンショット保存済み


# Step 3-6：ServiceNow × Entra ID SAML連携

## 目的
ServiceNow を Entra ID とSAML連携し、ID統制を実現

## 構成
- IdP：Microsoft Entra ID
- SP：ServiceNow
- 認証方式：SAML 2.0
- NameID：user.userprincipalname
- User Field：email

## Architecture
User → ServiceNow  
↓  
AuthnRequest  
↓  
Microsoft Entra ID  
↓  
SAML Response (NameID=email)  
↓  
ServiceNow User Lookup  
↓  
Login Success  

Protocol: SAML 2.0  
Binding: HTTP-Redirect / HTTP-POST  
NameID Format: emailAddress  

## 検証項目

- ☑  Entra Enterprise App 作成完了
- ☑  Federation Metadata 取得
- ☑  ServiceNow IdP 作成完了
- ☑  SAMLログイン成功
- ☑  Entra Sign-in Logs 記録確認

## 監査ログ確認

Entra → Sign-in logs
Application：ServiceNow
Status：Success

### Basic Information
- Status = Success
- User = sync-test01
- Application = servicenow-saml-lab
- Authentication Requirement = Multi-factor authentication

### Authentication Details
- Policy Applied = Conditional Access
- Authentication Method = Previously satisfied
- Result = Success
- Result Detail = MFA requirement satisfied

### Conditional Access Evaluation
- Policy Name = すべてのユーザーに多要素認証...
- Grant Control = Require MFA
- Result = Success

### Conclusion
ServiceNow SAML authentication was successful and MFA was enforced via Conditional Access.



