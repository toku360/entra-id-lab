# Phase5 Verification

## 目的

Zero Trust アーキテクチャの設計を行い  
Entra ID を利用したアプリケーションアクセス制御を整理する

対象アプリ

- ServiceNow

---

# Conditional Access

Conditional Access のポリシー作成を試みたが  
Microsoft Entra ID P1 Trial が失効していたため  
新規ポリシー作成は不可

確認画面

evidence/phase5/conditional-access-screen.png

---

# ライセンス状態

Microsoft Entra ID P1 Trial が

Inactive

となっていることを確認

証跡

evidence/phase5/license-expired.png

---

# ServiceNow サインイン確認

SSO によるログインが正常動作していることを確認

証跡

evidence/phase5/servicenow-signin-log.png

---

# 結論

Conditional Access 実装はライセンス制約により未実装

ただし Zero Trust 設計として

- Identity Provider
- SSO
- SCIM Provisioning

の構成を確認


