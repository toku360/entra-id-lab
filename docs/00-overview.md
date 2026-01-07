# 実務型学習計画（entra-id-lab）

## ゴール
Entra ID を中心に、設計→構築→運用→監査までを **証跡付き**で再現し、
「月単価100万円レンジのID/クラウドエンジニア」として説明できる成果物を作る。

## フェーズ構成（12週間）
- Phase 0：設計思想（要件/脅威/運用を文章化）
- Phase 1：Terraformで基盤（RG/VNet/LAW/Bastion、診断ログ集約）
- Phase 2：Cloud Sync（AD DS→Entra、同期ログ分析）
- Phase 3：SSO（OIDC/SAMLを複数アプリで実装）
- Phase 4：SCIM（自動プロビジョニング、成功率・失敗原因を可視化）
- Phase 5：Zero Trust/Governance（CA/PIM/Access Reviews）
- Phase 6：監視/SRE（KQL/Workbook/SLI/SLO/Runbook）

## 進め方
各 Phase は以下の順で成果物化する：
1) docs に手順書（設計意図/手順/検証/ロールバック/よくある失敗）
2) evidence に証跡（画面/ログ/KQL）
3) README からリンクし「全体が追える」状態にする
