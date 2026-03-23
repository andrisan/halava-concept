# Halava — KMS ↔ Implementation Discrepancies

> **Last updated:** March 2026
> **Status:** All discrepancies resolved — KMS updated to match implementation

---

## Resolution Summary

All discrepancies have been resolved by updating KMS documents to match the implementation (source of truth).

| Category | Count | Resolution |
|----------|-------|------------|
| Architectural Divergences (A) | 3 | KMS updated — App Platform added, Expense Insight moved to apps |
| Route Path Mismatches (B) | 7 | KMS routes rewritten to match implementation paths |
| Features with Zero Implementation (C) | 15 | Kept in KMS as unfinished work — no version gating |
| Implemented Routes with No KMS (D) | 7 | Added to routes-spec.md |
| KMS Internal Inconsistencies (E) | 2 | Resolved by standardizing on implementation naming |
| New Findings (F) | 12 | KMS updated — template architecture, directory structure, route groups |
| **Total** | **46** | **All resolved** |

---

## Files Updated

| File | Changes |
|------|---------|
| `routes-spec.md` | Full rewrite — 113 routes with ✅/❌ status, added App Platform, Discovery, Messaging sections |
| `web-app-spec.md` | Removed version columns, added App Platform + Messaging, removed Expense Insight from consumer features |
| `pages-navigation-ux-spec.md` | Rewrote dual-template to CSS-breakpoint approach, updated to `src/shared/` paths |
| `roadmap.md` | Collapsed to single v1.0 release, added implementation status column |
| `group-purchase.md` | Renamed to "Group Order", fixed all route paths to `/group-order/` prefix |
| `expense-insight.md` | Moved to App Platform model (`/app/expense-insight`), removed "Always Available" |
| `discrepancies.md` | This file — marked all resolved |

---

#halava #kms #discrepancies #resolved
