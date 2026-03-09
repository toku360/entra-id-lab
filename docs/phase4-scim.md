# Phase4：SCIM Provisioning（Entra ID → ServiceNow）

## 目的

Microsoft Entra ID のユーザーを  
ServiceNow に **自動プロビジョニング（SCIM）**する。

これにより

Entra ID  
↓  
ServiceNow  
ユーザー自動作成 / 更新 / 無効化

を実現する。

---

# アーキテクチャ

Entra ID
│
│ SCIM Provisioning
│
▼
ServiceNow
(User table)

---

# 前提条件

以下が完了していること

Phase1 Terraform Azure基盤  
Phase2 Entra Connect / Cloud Sync  
Phase3 ServiceNow SAML SSO  
Phase4 ServiceNow SCIM API

必要条件

ServiceNow plugin

SCIM v2 - ServiceNow Cross-domain Identity Management

---

# Step1 ServiceNow SCIM API作成

ServiceNow

System OAuth  
Application Registry

新規作成

Create an OAuth API endpoint for external clients

設定

Name

SCIM API

Client Type

Integration as a Service

Grant Type

Client Credentials

Client ID  
Client Secret

を取得する

証跡

evidence/phase5/02-servicenow-scim-app.png

---

# Step2 Entra Enterprise Application設定

Azure Portal

Enterprise Applications

servicenow-saml-lab

Provisioning

Provisioning Mode

Automatic

---

# Step3 管理資格情報設定

認証方法

Basic Authentication

設定

インスタンス名

dev269315

管理ユーザー

admin

パスワード

ServiceNow admin password

テスト接続

成功を確認

証跡

evidence/phase5/01-entra-provisioning-setting.png

---

# Step4 属性マッピング

Entra → ServiceNow

userPrincipalName  
↓  
user_name

mail  
↓  
email

givenName  
↓  
first_name

surname  
↓  
last_name

証跡

evidence/phase5/03-attribute-mapping.png

---

# Step5 ユーザー割当

Enterprise Applications

servicenow-saml-lab

Users and groups

Add user

テストユーザー

sync-test01  
SCIM-test01

---

# Step6 Provisioning開始

Provisioning

Start provisioning

同期周期

40分

または

Restart provisioning

でフル同期可能

---

# 検証

Provisioning Logs

Action

Create

User

SCIM-test01

証跡

evidence/phase5/04-provisioning-log.png

---

# ServiceNow側確認

ServiceNow

User Administration

Users

確認

SCIM-test01  
sync-test01

証跡

evidence/phase5/05-servicenow-user-created.png

---

# 結果

Entra ID ユーザーが  
ServiceNow に **自動作成**されることを確認

---

# ロールバック

Provisioning停止

Azure Portal

Enterprise Applications

servicenow-saml-lab

Provisioning

Stop provisioning

---

# よくある失敗

## user_name が選択できない

SCIM schema に含まれていない

対処

Schema editor で

userPrincipalName → user_name

追加

---

## access_denied エラー

原因

ServiceNow OAuth設定

対処

Basic Authentication を使用

---
