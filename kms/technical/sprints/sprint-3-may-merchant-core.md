# Sprint 3 — Merchant Core (May 2026)

> **Period:** May 1 – May 31, 2026
> **Goal:** complete merchant operating workflows across catalog, fulfillment, stock, POS, and restaurant operations
> **Strategy:** [[sprint-strategy]]

```mermaid
gantt
    title Sprint 3 — May 2026
    dateFormat YYYY-MM-DD
    axisFormat %d

    section Commerce Ops
    Merchant Listing and Storefront     :a1, 2026-05-01, 2026-05-07
    Products and Catalog                :a2, 2026-05-03, 2026-05-12
    Orders and Fulfillment              :a3, 2026-05-08, 2026-05-16

    section Inventory and POS
    Inventory Sync                      :b1, 2026-05-10, 2026-05-18
    Inventory Operations                :b2, 2026-05-15, 2026-05-24
    POS Core                            :b3, 2026-05-12, 2026-05-22

    section Merchant Growth
    Restaurant Operations               :c1, 2026-05-18, 2026-05-26
    Promotions and Featured Listings    :c2, 2026-05-22, 2026-05-29
    Pickup Locations and Merchant Setup :c3, 2026-05-24, 2026-05-31
```

| Workstream | Feature Coverage | Target Outcomes |
|------------|------------------|-----------------|
| Merchant listing and storefront | Directory merchant side, storefront publishing | Merchant place listing management, halal evidence fields, storefront data |
| Products and catalog | Products | Product CRUD, categories, imports/exports, photos, item-channel visibility |
| Orders and fulfillment | Order Management | Merchant order inbox, status flow, shipping, pickup handling, order preferences |
| Inventory sync | Inventory core | Shared stock events across marketplace, POS, and restaurant channels |
| Inventory operations | Inventory advanced | Adjustments log, stocktake, alerts, reorder thresholds, variance approval |
| POS core | POS | Cashier flow, offline sync, receipt generation, transaction history, quota visibility |
| Restaurant operations | Restaurant Operations, Menu Management, QR Menu, Kitchen Queue | Menu CRUD, modifiers, QR ordering, kitchen queue, dine-in and takeout flow |
| Promotions and featured listings | Promotions | Coupon logic, usage tracking, automatic discounts, featured listings |
| Pickup locations and merchant setup | BOPU merchant side | Pickup location CRUD, hours, prep windows, capacity, pickup readiness rules |

## Sprint 3 Exit Criteria

- Merchants can run core catalog, fulfillment, stock, POS, and restaurant workflows on shared live data.
- Inventory remains consistent across channels.
- Merchant-side promotion and pickup management are usable in production.

---

#halava #sprint #may #merchant
