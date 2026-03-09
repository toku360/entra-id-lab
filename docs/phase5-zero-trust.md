# Phase5 Zero Trust Architecture

## 目的

Microsoft Entra ID を利用した  
Zero Trust アクセス制御の設計を整理する

対象アプリケーション

- ServiceNow

---

# Zero Trust 構成

Identity Provider

Microsoft Entra ID

SSO

SAML / OIDC

Provisioning

SCIM

---

# 想定 Conditional Access

ポリシー

CA-ServiceNow-MFA

条件

User

SCIM-test01

Application

servicenow-saml-lab

Grant

Require MFA

---

# Conditional Access 実装結果

Conditional Access のポリシー作成を試みたが  
Microsoft Entra ID Premium P1 Trial が失効していたため  
ポリシー作成は不可

そのため本フェーズでは

Zero Trust 設計のみ実施する

---

# 証跡

以下の証跡を取得

## Conditional Access 画面

evidence/phase5/conditional-access-screen.png


内容

Conditional Access ポリシー画面

---

## Entra ID ライセンス状態

evidence/phase5/license-expired.png


内容

Microsoft Entra ID P1 Trial が

Inactive

であることを確認

---

## ServiceNow サインインログ

evidence/phase5/servicenow-signin-log.png


内容

ServiceNow への SSO サインイン成功ログ

---

# アーキテクチャ

User
│
▼
Microsoft Entra ID
│
│ SSO (SAML)
▼
ServiceNow
│
│ SCIM Provisioning
▼
ServiceNow User Table



---

# Phase5まとめ

Zero Trust アーキテクチャとして

- Identity Provider
- SSO
- SCIM Provisioning

の構成を確認

Conditional Access は  
ライセンス制約により未実装

---


