# Phase6 Verification

## Diagnostic Settings

確認項目

```
AuditLogs
SignInLogs
ProvisioningLogs
```

Log Analytics Workspace

```
law-entra-id-lab
```

結果

```
Success
```

証跡

```
evidence/phase6/01-diagnostic-settings.png
```

---

# Log Analytics

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

# Sign-in Logs

KQL

```
SigninLogs
| take 10
```

結果

```
ユーザーログインログ取得成功
```

証跡

```
evidence/phase6/03-signinlogs.png
```

---

# Sign-in Failure Monitoring

KQL

```
SigninLogs
| where ResultType != 0
| summarize count() by UserPrincipalName
```

結果

```
ログイン失敗検出
```

証跡

```
evidence/phase6/04-signin-failures.png
```

---

# Application Sign-in Analysis

KQL

```
SigninLogs
| summarize count() by AppDisplayName
```

結果

```
Azure Portal
My Apps
servicenow-saml-lab
```

証跡

```
evidence/phase6/05-app-signin.png
```

---

# ServiceNow SSO

KQL

```
SigninLogs
| where AppDisplayName contains "servicenow"
```

結果

```
ServiceNow SSOログ取得成功
```

証跡

```
evidence/phase6/06-servicenow-signin.png
```

---

# SCIM Provisioning

Enterprise Application

```
servicenow-saml-lab
```

結果

```
SCIM同期成功
```

証跡

```
evidence/phase6/07-provisioning-logs.png
```

---

# Phase6 Result

Identity monitoring environment successfully implemented.

