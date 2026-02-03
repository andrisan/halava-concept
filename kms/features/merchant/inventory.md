# Inventory (Stock Management)

> **Capability:** Part of Shop / Marketplace / POS
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[products]] · [[marketplace]] · [[pos]] · [[notifications]]

---

## Definition

**Inventory** is Halava's stock management system that tracks product quantities across all sales channels. It provides real-time visibility, low-stock alerts, and unified inventory control for online and in-store sales.

**Core value proposition:**
- Unified stock across online shop and POS
- Automatic updates on every sale
- Low-stock alerts prevent stockouts
- Inventory history and adjustments

---

## How It Works

### Unified Inventory

All sales channels share a single inventory count:

```
                    ┌─────────────┐
                    │  Inventory  │
                    │  Stock: 50  │
                    └─────────────┘
                          │
          ┌───────────────┼───────────────┐
          ▼               ▼               ▼
    ┌───────────┐   ┌───────────┐   ┌───────────┐
    │  Online   │   │    POS    │   │Restaurant │
    │   Shop    │   │           │   │  (future) │
    └───────────┘   └───────────┘   └───────────┘
```

### Stock Flow

| Event | Stock Change |
|-------|--------------|
| Online order placed | -quantity (reserved) |
| Online order cancelled | +quantity (released) |
| POS sale completed | -quantity |
| Manual adjustment | ±quantity |
| Stock received | +quantity |
| Damaged/expired | -quantity (adjustment) |

### Stock States

| State | Condition | Behavior |
|-------|-----------|----------|
| **In Stock** | stock > low_threshold | Normal display |
| **Low Stock** | 0 < stock ≤ low_threshold | Alert triggered |
| **Out of Stock** | stock = 0 | Hidden from shop, blocked in POS |
| **Negative** | stock < 0 | Oversold warning (shouldn't happen) |

---

## User Journey

### Merchant: View Inventory Status

```
Dashboard → Inventory
  → Overview:
    - Total products: 156
    - In stock: 142
    - Low stock: 11 ⚠️
    - Out of stock: 3 ❌
  → Filter by status
  → View individual product stock
```

### Merchant: Receive Low Stock Alert

```
Notification: "Low stock alert: Halal Beef 500g (8 remaining)"
  → Tap notification
  → View product inventory page
  → Options:
    - [Order More] (external, future integration)
    - [Adjust Stock] (received shipment)
    - [Update Threshold]
```

### Merchant: Adjust Stock (Received Shipment)

```
Inventory → Select Product → [Adjust Stock]
  → Adjustment Type:
    ● Add stock (received)
    ○ Remove stock (damaged/expired)
    ○ Set to exact count (stocktake)
  → Quantity: +30
  → Reason: "Shipment received - Invoice #12345"
  → [Confirm Adjustment]
  → Stock updated: 8 → 38
  → Logged in inventory history
```

### Merchant: Perform Stocktake

```
Inventory → [Stocktake Mode]
  → Scan or search products
  → Enter actual count
  → System shows discrepancy:
    - Expected: 45
    - Actual: 42
    - Difference: -3
  → [Submit Stocktake]
  → All adjustments logged with "stocktake" reason
```

### Merchant: Review Inventory History

```
Inventory → Product → History
  → View all stock changes:
    ┌─────────────────────────────────────────────┐
    │ Jan 28, 14:32 │ -2  │ Online Order #HLV-001 │
    │ Jan 28, 11:15 │ -1  │ POS Sale #TXN-042     │
    │ Jan 27, 09:00 │ +30 │ Shipment received     │
    │ Jan 25, 16:45 │ -3  │ Stocktake adjustment  │
    └─────────────────────────────────────────────┘
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Inventory Overview** | `/merchant/inventory` | Stock status dashboard |
| **Product Stock** | `/merchant/inventory/{id}` | Individual product stock |
| **Adjustments** | `/merchant/inventory/adjustments` | Adjustment history |
| **Stocktake** | `/merchant/inventory/stocktake` | Physical count mode |
| **Alerts** | `/merchant/inventory/alerts` | Low stock notifications |

### Inventory Overview

```
┌──────────────────────────────────────────────────────────────┐
│ Inventory                                    [Stocktake]      │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌──────────┐│
│ │ Total       │ │ In Stock    │ │ Low Stock   │ │ Out of   ││
│ │ 156         │ │ 142         │ │ 11 ⚠️       │ │ Stock 3  ││
│ │ products    │ │             │ │             │ │ ❌       ││
│ └─────────────┘ └─────────────┘ └─────────────┘ └──────────┘│
│                                                              │
│ [All] [Low Stock] [Out of Stock]     🔍 Search...           │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│ Product              │ Stock   │ Threshold │ Status         │
│──────────────────────┼─────────┼───────────┼────────────────│
│ Halal Beef 500g      │ 8       │ 10        │ ⚠️ Low Stock   │
│ Chicken Breast       │ 5       │ 10        │ ⚠️ Low Stock   │
│ Sambal Sauce         │ 0       │ 5         │ ❌ Out of Stock│
│ Lamb Chops 300g      │ 23      │ 10        │ ✓ In Stock     │
│ Basmati Rice 5kg     │ 45      │ 15        │ ✓ In Stock     │
├──────────────────────────────────────────────────────────────┤
│ [< Prev]                                          [Next >]   │
└──────────────────────────────────────────────────────────────┘
```

### Product Stock Detail

```
┌──────────────────────────────────────────────────────────────┐
│ [←] Halal Beef 500g                          [Adjust Stock]  │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ Current Stock                                                │
│ ┌──────────────────────────────────────────────────────────┐│
│ │                                                          ││
│ │                         8                                ││
│ │                       units                              ││
│ │                                                          ││
│ │              ⚠️ Below threshold (10)                     ││
│ │                                                          ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
│ Settings                                                     │
│ ─────────                                                    │
│ Low stock threshold: [10    ] units                         │
│ Track inventory:     ☑ Yes                                  │
│ Allow overselling:   ☐ No                                   │
│                                                              │
│ Quick Actions                                                │
│ ─────────────                                                │
│ [+ Add Stock]  [- Remove Stock]  [Set Exact Count]          │
│                                                              │
│ Recent History                                               │
│ ──────────────                                               │
│ ┌──────────────────────────────────────────────────────────┐│
│ │ Jan 28, 14:32 │ -2  │ Online Order #HLV-001234          ││
│ │ Jan 28, 11:15 │ -1  │ POS Sale #TXN-20260128-042        ││
│ │ Jan 28, 09:30 │ -3  │ Online Order #HLV-001230          ││
│ │ Jan 27, 09:00 │ +30 │ Manual: Shipment received         ││
│ │ Jan 25, 16:45 │ -5  │ POS Sale #TXN-20260125-018        ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
│ [View Full History]                                          │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Stock Adjustment Modal

```
┌──────────────────────────────────────────────────────────────┐
│ Adjust Stock: Halal Beef 500g                           [×]  │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ Current stock: 8 units                                       │
│                                                              │
│ Adjustment Type                                              │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐          │
│ │ ● Add Stock  │ │ ○ Remove    │ │ ○ Set Exact  │          │
│ │   (received) │ │   (damaged) │ │   (stocktake)│          │
│ └──────────────┘ └──────────────┘ └──────────────┘          │
│                                                              │
│ Quantity                                                     │
│ ┌────────────────────────────────────────────────┐          │
│ │ + 30                                           │          │
│ └────────────────────────────────────────────────┘          │
│                                                              │
│ New stock will be: 38 units                                  │
│                                                              │
│ Reason (required)                                            │
│ ┌────────────────────────────────────────────────┐          │
│ │ Shipment received - Invoice #INV-2026-0042    │          │
│ └────────────────────────────────────────────────┘          │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│ [Cancel]                              [Confirm Adjustment]   │
└──────────────────────────────────────────────────────────────┘
```

### Stocktake Mode

```
┌──────────────────────────────────────────────────────────────┐
│ Stocktake Mode                          [Exit Stocktake]     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ Progress: 45 / 156 products counted                          │
│ ████████████░░░░░░░░░░░░░░░░░░ 29%                          │
│                                                              │
│ 🔍 Search or scan barcode...                                │
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐│
│ │ Halal Beef 500g                                          ││
│ │ SKU: BEEF-500G-AU                                        ││
│ │                                                          ││
│ │ Expected: 8        Actual: [    ]                        ││
│ │                                                          ││
│ │ [Confirm Count]                                          ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
│ Recent Counts                                                │
│ ─────────────                                                │
│ ✓ Lamb Chops 300g      Expected: 23  Actual: 23  ✓ Match   │
│ ✓ Chicken Breast       Expected: 10  Actual: 8   ⚠️ -2      │
│ ✓ Sambal Sauce         Expected: 0   Actual: 0   ✓ Match   │
│                                                              │
│ Discrepancies: 1 product                                     │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│ [Save Progress]                    [Complete Stocktake]      │
└──────────────────────────────────────────────────────────────┘
```

### Low Stock Alerts Panel

```
┌──────────────────────────────────────────────────────────────┐
│ Low Stock Alerts                        [Alert Settings]     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ 11 products need attention                                   │
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐│
│ │ ⚠️ Halal Beef 500g                                       ││
│ │ Stock: 8 / Threshold: 10                                 ││
│ │ [View] [Adjust Stock]                                    ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐│
│ │ ⚠️ Chicken Breast                                        ││
│ │ Stock: 5 / Threshold: 10                                 ││
│ │ [View] [Adjust Stock]                                    ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐│
│ │ ❌ Sambal Sauce (OUT OF STOCK)                           ││
│ │ Stock: 0 / Threshold: 5                                  ││
│ │ [View] [Adjust Stock]                                    ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Notifications

| Event | Notification |
|-------|--------------|
| Low stock reached | "Low stock: [Product] has [X] units remaining" |
| Out of stock | "Out of stock: [Product] is now unavailable" |
| Stock replenished | "Stock updated: [Product] now has [X] units" |
| Stocktake reminder | "Weekly reminder: Perform inventory stocktake" |

### Alert Settings

```
┌──────────────────────────────────────────────────────────────┐
│ Alert Settings                                          [×]  │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ Notification Channels                                        │
│ ☑ In-app notifications                                      │
│ ☑ Email alerts                                              │
│ ☐ SMS alerts (coming soon)                                  │
│                                                              │
│ Alert Frequency                                              │
│ ● Immediate (when threshold reached)                        │
│ ○ Daily digest                                              │
│ ○ Weekly summary                                            │
│                                                              │
│ Default Threshold                                            │
│ Alert when stock falls below: [10] units                    │
│ (Can be customized per product)                             │
│                                                              │
│ Stocktake Reminder                                          │
│ ☑ Weekly reminder to perform stocktake                      │
│ Day: [Sunday ▼]  Time: [09:00 ▼]                            │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│ [Cancel]                                      [Save Settings]│
└──────────────────────────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                   InventoryAdjustment                            │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  item_id         UUID FK → Item                                 │
│  merchant_id     UUID FK → Merchant                             │
│  adjustment_type ENUM(sale, restock, return, damage,            │
│                       stocktake, correction)                    │
│  quantity_change INT NOT NULL (positive or negative)            │
│  quantity_before INT NOT NULL                                   │
│  quantity_after  INT NOT NULL                                   │
│  reason          TEXT                                           │
│  source          ENUM(order, pos, manual, stocktake)            │
│  source_id       UUID (FK → Order or POSTransaction)            │
│  staff_id        UUID FK → User                                 │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       Stocktake                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  status          ENUM(in_progress, completed, cancelled)        │
│  started_at      TIMESTAMP NOT NULL                             │
│  completed_at    TIMESTAMP                                      │
│  products_counted INT DEFAULT 0                                 │
│  discrepancies_found INT DEFAULT 0                              │
│  notes           TEXT                                           │
│  started_by      UUID FK → User                                 │
│  completed_by    UUID FK → User                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                      StocktakeItem                               │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  stocktake_id    UUID FK → Stocktake                            │
│  item_id         UUID FK → Item                                 │
│  expected_count  INT NOT NULL                                   │
│  actual_count    INT                                            │
│  discrepancy     INT                                            │
│  counted_by      UUID FK → User                                 │
│  counted_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘
```

### Related: ProductExtension (see [[products#Data Model]])

Stock is stored in `ProductExtension`:
- `stock_count` — Current inventory level
- `low_stock_threshold` — Alert trigger level

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `inventory_adjustment` | `item_id, created_at DESC` | Item history |
| `inventory_adjustment` | `merchant_id, created_at DESC` | Merchant audit |
| `inventory_adjustment` | `source, source_id` | Order/POS lookup |
| `stocktake` | `merchant_id, status` | Active stocktakes |
| `stocktake_item` | `stocktake_id, item_id` | Stocktake lookup |

---

## API Endpoints

> Full API index: [[api-spec#6.4 Inventory]]

### GET /v1/merchant/inventory

List inventory status for all products.

```
Query Parameters:
  status        string    Filter: in_stock, low_stock, out_of_stock
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "items": [
    {
      "item_id": "uuid",
      "name": "Halal Beef 500g",
      "stock_count": 8,
      "low_stock_threshold": 10,
      "status": "low_stock",
      "channels": ["shop", "pos"]
    }
  ],
  "summary": {
    "total": 156,
    "in_stock": 142,
    "low_stock": 11,
    "out_of_stock": 3
  }
}
```

### GET /v1/merchant/inventory/{item_id}

Get stock details for a specific item.

```json
// Response
{
  "item_id": "uuid",
  "name": "Halal Beef 500g",
  "stock_count": 8,
  "low_stock_threshold": 10,
  "status": "low_stock",
  "last_updated": "2026-01-28T14:32:00+09:00",
  "channels": ["shop", "pos"]
}
```

### POST /v1/merchant/inventory/{item_id}/adjust

Adjust stock count.

```json
// Request
{
  "adjustment_type": "add",  // add, remove, set
  "quantity": 30,
  "reason": "Shipment received - Invoice #INV-2026-0042"
}

// Response
{
  "item_id": "uuid",
  "previous_count": 8,
  "new_count": 38,
  "adjustment_id": "uuid"
}
```

### GET /v1/merchant/inventory/{item_id}/history

Get stock adjustment history.

```
Query Parameters:
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "history": [
    {
      "id": "uuid",
      "adjustment_type": "sale",
      "quantity_change": -2,
      "quantity_before": 10,
      "quantity_after": 8,
      "source": "order",
      "source_id": "order-uuid",
      "created_at": "2026-01-28T14:32:00+09:00"
    }
  ],
  "total": 45
}
```

### GET /v1/merchant/inventory/alerts

Get low stock alerts.

```json
// Response
{
  "alerts": [
    {
      "item_id": "uuid",
      "name": "Halal Beef 500g",
      "stock_count": 8,
      "threshold": 10,
      "status": "low_stock"
    }
  ],
  "total": 11
}
```

### PUT /v1/merchant/inventory/settings

Update inventory alert settings.

```json
// Request
{
  "default_threshold": 10,
  "email_alerts": true,
  "alert_frequency": "immediate"  // immediate, daily, weekly
}

// Response
{
  "message": "Settings updated"
}
```

### POST /v1/merchant/stocktake

Start a new stocktake session.

```json
// Request
{
  "notes": "Monthly inventory count"
}

// Response
{
  "id": "uuid",
  "status": "in_progress",
  "started_at": "2026-01-28T09:00:00+09:00",
  "products_to_count": 156
}
```

### PUT /v1/merchant/stocktake/{id}

Update stocktake with counted items.

```json
// Request
{
  "counts": [
    { "item_id": "uuid", "actual_count": 42 },
    { "item_id": "uuid", "actual_count": 23 }
  ]
}

// Response
{
  "id": "uuid",
  "products_counted": 45,
  "discrepancies_found": 3
}
```

### POST /v1/merchant/stocktake/{id}/complete

Complete stocktake and apply adjustments.

```json
// Request
{
  "apply_adjustments": true
}

// Response
{
  "id": "uuid",
  "status": "completed",
  "completed_at": "2026-01-28T12:00:00+09:00",
  "adjustments_made": 3
}
```

---

## Stock Reservation (Online Orders)

When an online order is placed:

1. **Reserve stock** — `stock_count -= order_quantity`
2. **Order confirmed** — Stock remains reserved
3. **Order fulfilled** — Reservation finalized
4. **Order cancelled** — `stock_count += order_quantity` (released)

This prevents overselling when multiple customers order simultaneously.

---

## Edge Cases

| Scenario | Handling |
|----------|----------|
| Simultaneous orders exceed stock | First order succeeds, second fails with "insufficient stock" |
| POS sale with 0 stock | Warning shown, sale blocked (unless allow_overselling enabled) |
| Negative stock after sync | Flag for review, show warning in dashboard |
| Stocktake during high traffic | Pause online sales or accept temporary discrepancy |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Stockout rate | < 5% of products |
| Low stock alert response time | < 24 hours |
| Inventory accuracy (post-stocktake) | > 98% |
| Merchants using stocktake | > 40% monthly |

---

## Dependencies

- [[products]] — Product catalog
- [[marketplace]] — Online order stock deduction
- [[pos]] — In-store sale stock deduction
- [[notifications]] — Low stock alerts
- [[order-management]] — Order cancellation stock release

---

#halava #feature #inventory #stock #merchant
