# Phase4 Verification

## 目的

Microsoft Entra ID から ServiceNow への  
SCIMプロビジョニングが正常に動作することを確認する。

---

# 検証項目

| No | 検証内容 | 期待結果 |
|---|---|---|
| 1 | Provisioning接続テスト | Connection successful |
| 2 | 属性マッピング確認 | userPrincipalName → user_name |
| 3 | ユーザー割当 | Enterprise Applicationにユーザー追加 |
| 4 | プロビジョニング実行 | Provisioning logs に Create |
| 5 | ServiceNow確認 | ユーザー作成 |

---

# 検証手順

## 1 Provisioning接続テスト

Azure Portal

Enterprise Applications  
servicenow-saml-lab  
Provisioning

Test connection

結果　
Connection successful

証跡　
Connection successful


---

## 2 属性マッピング確認

Entra ID

userPrincipalName  
↓  
ServiceNow

user_name

証跡　
evidence/phase4/03-attribute-mapping.png


---

## 3 ユーザー割当

Enterprise Applications

servicenow-saml-lab

Users and groups

追加ユーザー　
sync-test01　
SCIM-test01　



---

## 4 Provisioning実行

Provisioning

Start provisioning

または

Restart provisioning

確認

Provisioning Logs

Action: Create　
User: SCIM-test01　
Status: Success　

証跡　
evidence/phase4/04-provisioning-log.png


---

## 5 ServiceNow側確認

ServiceNow

User Administration  
Users

確認ユーザー　
sync-test01　
SCIM-test01　


証跡　
evidence/phase4/05-servicenow-user-created.png　



---

# 検証結果

| 項目 | 結果 |
|---|---|
| SCIM接続 | 成功 |
| 属性マッピング | 正常 |
| ユーザー同期 | 成功 |
| ServiceNow作成 | 成功 |

---

# 結論

Microsoft Entra ID から ServiceNow への  
SCIMユーザープロビジョニングが正常に動作することを確認した。

---

# 補足

同期周期 40分 
手動同期 Restart provisioning

---

# 次フェーズ

Phase5

Zero Trust / Governance

- Conditional Access
- PIM
- Access Reviews
- Entitlement Management

