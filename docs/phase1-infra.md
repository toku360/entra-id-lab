# Phase 1：Terraform × Azure 基盤（RG/VNet/LAW/Bastion）【証跡付き】

## 1. ゴール（完了条件）
- Terraform で以下が作成されている
  - Resource Group
  - Virtual Network / Subnet
  - Log Analytics Workspace（LAW）
  - Azure Bastion（Standard）
- Bastion の Diagnostic settings を LAW に送信し、KQL でログが確認できる
- 証跡（スクショ・ログ・KQL結果）が `evidence/phase1/` に揃っている

---

## 2. アーキテクチャ（Phase 1）

```mermaid
flowchart LR
  subgraph Azure["Azure Subscription"]
    RG["rg-entra-id-lab"]
    VNET["vnet-lab (Private)"]
    SUB["subnet-lab"]
    LAW["Log Analytics Workspace (LAW)"]
    BAS["Azure Bastion (Standard)"]
    BASDIAG["Diagnostic settings<br/>Bastion → LAW"]
  end

  RG --> VNET --> SUB
  RG --> LAW
  RG --> BAS
  BAS --> BASDIAG --> LAW

  NOTE1["運用方針：VMにPublic IPを付与しない"]
  NOTE2["管理アクセス：RDP/SSHはBastion経由に統一"]

  NOTE1 --- VNET
  NOTE2 --- BAS


