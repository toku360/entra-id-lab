ここは Phase 開始時に、アーキテクチャ図（Mermaid）＋手順書を追記して完成させる）

# Phase0: Design Overview（設計方針）

## 1. 目的とゴール

本プロジェクトは、Microsoft Entra ID を中心とした  
ID・認証基盤を **Terraform により再現性高く構築・運用できること**を  
実務レベルで示すことを目的とする。

単なるリソース構築ではなく、以下を重視する。

- なぜこの構成にしたのかを説明できること
- 環境差分・誤操作を考慮した設計であること
- 将来の拡張（Entra ID / SSO / 条件付きアクセス）に耐えうること

本 Phase0 は **実装を行わず、設計判断を言語化するフェーズ**と位置づける。

---

## 2. 前提条件・制約

- 個人所有の Azure サブスクリプションを利用
- 実在のオンプレミス Active Directory は使用しない
- コストを最小限に抑えつつ、実務構成を再現する
- 検証環境（lab）を前提とし、破棄可能であることを重視する

---

## 3. 全体アーキテクチャ方針

Phase1 では、アプリケーションや VM は配置せず、  
後続フェーズの共通基盤となる以下のリソースのみを構築する。

- Resource Group
- Virtual Network / Subnet
- Azure Bastion
- Log Analytics Workspace
- Diagnostic Settings

これは、ID 管理やセキュリティ機能を実装する前に、  
**ネットワーク・監査・運用の土台を先に確立する**ためである。

---

## 4. 環境分離戦略（lab / dev / prod）

Terraform 構成は、以下のディレクトリ分離を前提とする。

terraform/
└── envs/
    ├── lab/
    ├── dev/
    └── prod/


- `lab`：検証・学習用途（破棄前提）
- `dev`：構成検証・差分確認
- `prod`：本番想定（将来）

環境差分（subscription_id 等）は `tfvars` で注入し、  
**Git 管理対象外**とすることで、誤ったサブスクリプションへの apply を防止する。

---

## 5. ネットワーク設計方針

- VNet は `/16` とし、将来の拡張（AD DS / VPN / Private Endpoint）を考慮
- 通常用途の Subnet と Bastion 用 Subnet を分離
- Bastion 用 Subnet は Azure の要件に従い `AzureBastionSubnet` とする

CIDR 設計は「初期は広く、後から細かく切る」方針を採用する。

---

## 6. セキュリティ設計方針

- VM に Public IP は付与しない
- 管理アクセスは Azure Bastion 経由のみとする
- 初期段階から Log Analytics Workspace を作成し、監査ログを集約する

これは以下の考え方に基づく。

- ゼロトラストを前提とした管理アクセス
- 事後対応ではなく、**最初から可観測性を組み込む設計**

---

## 7. Terraform 設計方針

- Provider / variables / outputs を役割ごとに分離
- `subscription_id` は provider に直書きせず、変数化する
- 環境差分は `terraform.tfvars` で注入する

```hcl
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
```

この設計により下記を実現する。

- 環境ごとのコード差分を最小化
- 誤applyのリスク低減
- 再利用性・可読性の向上

---

## 8. 運用・検証・ロールバック方e 方針

- すべての変更は terraform plan で事前確認する
- apply 後は Azure Portal / Azure CLI の両方で確認する
- lab 環境では terraform destroy により即時ロールバック可能とする
- Terraform の state は Git 管理せず、ローカルまたは将来の remote backend 管理を前提とする。


## 9. Phase1 以降への拡張計画

- Phase1：Azure 基盤（network / bastion / logging）
- Phase2：Entra ID（azuread provider）による ID 管理
- Phase3：SSO（SAML / OIDC）および条件付きアクセス
- Phase4：運用・監査・セキュリティポリシーの高度化
- Phase0/Phase1 で構築した基盤は、これらすべての土台として再利用される。


