# 証跡取得ルール（entra-id-lab）

## 目的
このリポジトリは「作った」だけでなく **“実務で運用できる設計・検証・監査”** を証明する。
そのため、各フェーズで **証跡（画面・ログ・KQL）** を必ず残す。

---

## 証跡の種類（必須）
1. Azure Portal の設定画面（完了状態が分かる）
2. CLI / PowerShell の実行結果（コマンドと出力）
3. Terraform（init / plan / apply）の結果
4. Log Analytics（KQL）の結果
5. エラーと対応（原因→切り分け→解決）

---

## 保存先と命名規則
保存先：`evidence/phaseX/`

- screenshots: `YYYYMMDD_<what>.png`
- logs: `YYYYMMDD_<what>.log`（コマンド + 出力を含める）
- verification: `verification.md`（チェックリスト形式）

例：
- evidence/phase1/screenshots/20251218_law_created.png
- evidence/phase1/logs/20251218_terraform_apply.log

---

## マスキング（厳守）
GitHub に上げない：
- パスワード、Client Secret、Access Token、Tenantの機密値
- 個人メール、電話番号、カード情報

ログは必要に応じて `***` で置換して保存する。

---

## 面談で説明する観点
- 何を確認するための証跡か（Why）
- このログ/画面で何が分かるか（So what）
- 失敗した場合の切り分け方（How）
