# Phase6：Identity Monitoring（最終フェーズ）

## 概要

Phase6では、Microsoft Entra ID のログを Azure Monitor / Log Analytics に集約し、
KQL を利用して Identity の監視を行う仕組みを構築する。

本フェーズでは以下を実施した。

* Entra ID のログを Log Analytics に送信
* KQL を利用したログ分析
* サインイン監視
* アプリ別ログイン監視
* ServiceNow SSOログ監視
* SCIM Provisioningログの確認

これにより Identity の可視化と監視基盤を構築した。

---

# 構成

```
Microsoft Entra ID
        │
        │ Diagnostic Settings
        ▼
Azure Monitor
        │
        ▼
Log Analytics Workspace
        │
        ▼
KQL Query / Workbook
```

Workspace

```
law-entra-id-lab
```

---

# 1 Entra ID Diagnostic Settings

Entra ID のログを Log Analytics へ送信する設定を実施。

送信対象ログ

```
AuditLogs
SignInLogs
ProvisioningLogs
```

Log Analytics Workspace

```
law-entra-id-lab
```

証跡

```
evidence/phase6/01-diagnostic-settings.png
```

---

# 2 Log Analytics ログ確認

KQL

```
search *
| summarize count() by $table
```

確認結果

```
SigninLogs
AuditLogs
AzureMetrics
Usage
```

証跡

```
evidence/phase6/02-loganalytics-tables.png
```

---

# 3 サインインログ確認

KQL

```
SigninLogs
| take 10
```

確認内容

* ユーザーサインインログ
* IPアドレス
* アプリ
* 認証方法

証跡

```
evidence/phase6/03-signinlogs.png
```

---

# 4 サインイン失敗監視

KQL

```
SigninLogs
| where ResultType != 0
| summarize count() by UserPrincipalName
```

確認内容

* ログイン失敗ユーザー
* 失敗回数

証跡

```
evidence/phase6/04-signin-failures.png
```

---

# 5 アプリ別ログイン分析

KQL

```
SigninLogs
| summarize count() by AppDisplayName
```

確認内容

* Azure Portal
* My Apps
* ServiceNow

証跡

```
evidence/phase6/05-app-signin.png
```

---

# 6 ServiceNow SSOログ確認

KQL

```
SigninLogs
| where AppDisplayName contains "servicenow"
```

確認内容

ServiceNow SAML SSO のサインインログ。

証跡

```
evidence/phase6/06-servicenow-signin.png
```

---

# 7 SCIM Provisioningログ

Enterprise Application

```
servicenow-saml-lab
```

Provisioning Logs

例

```
Update
Source : Microsoft Entra ID
```

確認内容

* SCIMユーザー同期
* 更新処理
* エラー有無

証跡

```
evidence/phase6/07-provisioning-logs.png
```

---

# Phase6 結果

Identity Monitoring 環境を構築した。

実装内容

* Entra ID ログ収集
* Log Analytics 連携
* KQLログ分析
* SSOログ監視
* SCIM同期ログ確認

これにより

```
Identity Observability
Identity Monitoring
Zero Trust Monitoring
```

の基盤を構築した。




