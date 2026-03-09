# Phase 3：Multi-App SSO 実装（OIDC / SAML）

## 1. フェーズの目的

Phase3では、Hybrid Identity 基盤の上に複数アプリへの SSO（OIDC / SAML）を実装する。


## 2. このフェーズで実現すること

 - Terraform によるアプリVM分離
 - OIDC と SAML の両方式理解
 - Conditional Access 適用
 - MFA 強制
 - 監査ログ取得
 - KQL によるログ検証

## 3. 実装一覧

### 3.1 Grafana（OIDC）

#### 実装内容

 - App Registration 作成
 - Redirect URI 設定
 - Client Secret 作成
 - Admin Consent 実施
 - custom.ini 設定

[auth.generic_oauth]
enabled = true
email_attribute_path = userPrincipalName
login_attribute_path = userPrincipalName
name_attribute_path  = displayName

#### Conditional Access

 - CA-Grafana-MFA 作成
 - sync-test01 対象
 - MFA 強制
 - Security Defaults 無効

#### 検証

 - ☑ OIDC ログイン成功
 - ☑ MFA チャレンジ確認
 - ☑ SigninLogs 確認済み
 - ☑ multiFactorAuthentication 確認


### 3.2 ServiceNow（SAML）

 - SAML ベースのエンタープライズアプリ統合を実装する。
 - OIDCとの違いを理解する。

#### 実装内容

 - Enterprise Application を使用
 - SAML ベース SSO
 - 属性マッピング確認
 - テストユーザー：sync-test01
 - Conditional Access 適用

#### Conditional Access

 - Enterprise Application 作成
 - Single Sign-On → SAML 設定
 - Entity ID / Reply URL 設定
 - ユーザー属性マッピング確認
 - sync-test01 割り当て
 - SAML ログインテスト

#### 検証項目

 - ☑ SAML ログイン成功
 - ☑ NameID = userPrincipalName
 - ☑ MFA 適用確認
 - ☑ サインインログ確認


## 4. OIDC と SAML の違い

### 4.1 技術的な違い

| 項目 | OIDC | SAML |
|:-----|:------|:------|
| ベース規格 | OAuth 2.0 | XMLベース |
| 主な用途 | モダンWebアプリ | エンタープライズアプリ |
| 設定方法 | App Registration | Enterprise Application |
| トークン形式 | JWT（JSON） | XML Assertion |
| 通信方式 | REST / JSON | XML / Redirect / POST |
| 現在の主流 | 主流 | レガシー環境に多い |


### 4.2 実装時の違い

#### OIDC（Grafana） 
 - Client ID / Client Secret を使用
 - Redirect URI を設定
 - JWTトークンを受信
 - custom.ini に OAuth 設定を記述

メリット： 
 - 設定が比較的簡単 
 - クラウドアプリとの相性が良い 
 - API連携と統合しやすい 

#### SAML（ServiceNow）

メタデータ交換 
 - Entity ID / Reply URL 設定
 - NameID マッピング
 - XML Assertion を受信

メリット： 
 - 既存エンタープライズ製品との互換性が高い 
 - レガシー環境で広く使用 

### 4.3 実務での使い分け

| ケース      | 推奨   |
| :-------- | :---- |
| 新規Webアプリ | OIDC |
| SaaS製品   | OIDC |
| 既存企業システム | SAML |
| レガシー統合   | SAML |


### 4.4 達成観点

 - OIDC のフローを説明できる
 - SAML の Assertion 概念を理解している
 - App Registration と Enterprise Application の違いを説明できる


## 5. セキュリティ構成

Phase3では、アプリ追加時もゼロトラスト原則に従った構成とした。


### 5.1 ネットワーク構成

| 項目         | 状態           |
|:------------ |:------------- |
| Public IP    | 未使用           |
| RDP公開        | なし（Bastion限定） |
| サブネット分離      | subnet-lab    |
| NSG          | NIC単位で制御      |
| 0.0.0.0/0 許可 | なし            |

### 5.2 認証構成

| 項目               | 状態          |
|:------------------ |:----------- |
| Security Defaults  | 無効          |
| Conditional Access | 有効          |
| 対象                 | アプリ単位       |
| MFA                | 強制          |
| テストユーザー            | sync-test01 |

### 5.3 ログ・監査

| 項目       | 状態   |
|:---------- |:---- |
| サインインログ    | 取得済み |
| 条件付きアクセスログ | 確認済み |
| MFA記録      | 確認済み |
| KQL抽出      | 実施済み |
| 証跡保存       | 完了   |

### 5.4 セキュリティ評価

 - 最小公開原則を遵守
 - Bastion経由のみ管理アクセス
 - アプリ単位のMFA制御
 - ログ監査可能な状態
 - セキュリティ設定の証跡保存済み


### 5.5 SAML Authentication Flow

```text
User → ServiceNow
      ↓
   AuthnRequest
      ↓
Microsoft Entra ID
      ↓
SAML Response (NameID = email)
      ↓
ServiceNow User Lookup (email)
      ↓
Login Success
```


