# Phase 2：Cloud Sync 設計（AD 側準備）

## 1. 目的
Cloud Sync を安全に導入するため、AD 側の OU 設計・同期スコープ・属性方針を先に確定する。
誤同期（全OU同期、属性上書き）を防ぎ、運用設計として説明可能な状態にする。

## 2. 同期スコープ（OU）設計
### 方針
- 同期対象は専用 OU に限定する（事故防止）
- サーバー/管理者/既定OUは同期しない

### 想定OU
- 同期対象：OU=LabUsers,OU=Lab,DC=entra,DC=local
- 同期対象外：OU=Servers,OU=Admins,Builtin,Domain Users 等

## 3. 同期対象オブジェクト
- 同期する：User / Group（アプリ割当のため）
- 同期しない：Computer（初期は不要）

## 4. 属性方針（最小安全構成）
- UPN：<samAccountName>@entra-id-lab.onmicrosoft.com
- displayName：姓 名（または 名 姓）で固定
- mail：テスト用途では任意（後で設定）

## 5. 運用ルール
- OU/同期スコープの変更は docs 更新 + PR レビューを必須
- 影響の大きい変更（対象OU追加/属性マッピング変更）は段階適用（Report/限定ユーザー→拡大）

## 6. ロールバック方針
- 同期対象OUを縮小（専用OUのみに戻す）
- Cloud Sync を一時停止（必要に応じてエージェント無効化）


