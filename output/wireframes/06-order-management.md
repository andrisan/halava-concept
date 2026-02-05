# Order Management — Wireframes

> **Priority:** 6
> **Target:** Merchant
> **MVP:** Yes
> **Status:** Not Started
> **Parent:** [Wireframes Index](../halava-ui-wireframes-index.md)
> **Feature Spec:** [kms/features/merchant/order-management.md](../../kms/features/merchant/order-management.md)

---

## Overview

Order Management allows merchants to view, process, and fulfill online orders. It provides a dashboard with order filtering, status updates, and detailed order views. Orders flow through statuses from New to Fulfilled.

## Screens

| Screen | Path | Desktop |
|--------|------|---------|
| Orders Dashboard | `/dashboard/orders` | Yes |
| Order Details | `/dashboard/orders/{id}` | Yes |

---

## Desktop Template

> Merchant dashboard and order management are desktop-only features requiring larger screens for efficient operation.

### Orders Dashboard Layout

```
┌──────────────────────────────────────────────────────────────┐
│ Orders                                              [⚙️]      │
├──────────────────────────────────────────────────────────────┤
│ [All] [New (3)] [Preparing] [Ready] [Shipped] [Fulfilled]   │
│                                                              │
│ 🔍 Search orders...            [Date Range ▼] [Type ▼]       │
│                                                              │
│ ─────────── Today ───────────                                │
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ 🔴 NEW                                       10:32 AM    │ │
│ │ #HLV-001234 · Ahmad K.                                   │ │
│ │ 3 items · ¥4,100 · Delivery                              │ │
│ │ ⏱️ Payment pending                                       │ │
│ │ [View] [Confirm Payment]                                 │ │
│ └──────────────────────────────────────────────────────────┘ │
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ 🟡 PREPARING                                  9:15 AM    │ │
│ │ #HLV-001230 · Fatima S.                                  │ │
│ │ 2 items · ¥2,800 · Pickup                                │ │
│ │ Pickup: Today 12:00 PM                                   │ │
│ │ [View] [Mark Ready]                                      │ │
│ └──────────────────────────────────────────────────────────┘ │
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ 🟢 READY                                      8:45 AM    │ │
│ │ #HLV-001228 · Yusuf M.                                   │ │
│ │ 1 item · ¥1,200 · Pickup                                 │ │
│ │ Waiting for customer                                     │ │
│ │ [View] [Complete]                                        │ │
│ └──────────────────────────────────────────────────────────┘ │
│                                                              │
│ ─────────── Yesterday ───────────                            │
│ ...                                                          │
└──────────────────────────────────────────────────────────────┘
```

### Order Details Layout

```
┌──────────────────────────────────────────────────────────────┐
│ [←] Order #HLV-001234                                        │
├──────────────────────────────────────────────────────────────┤
│ Status: 🟡 Preparing                                         │
│ Placed: Jan 28, 2026 · 10:32 AM                             │
│                                                              │
│ ─────────────────────────────────────────────────────────── │
│ Customer                                                     │
│ Ahmad K. · ahmad@email.com                                  │
│ 📞 080-1234-5678                                             │
│                                                              │
│ ─────────────────────────────────────────────────────────── │
│ Fulfillment: 🚚 Delivery                                     │
│ Address:                                                     │
│ 〒150-0001 Tokyo, Shibuya-ku,                               │
│ Jingumae 1-2-3, Apt 401                                     │
│                                                              │
│ ─────────────────────────────────────────────────────────── │
│ Items                                                        │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ Halal Beef 500g                                    × 2   │ │
│ │ ¥1,200 each                                    ¥2,400    │ │
│ ├──────────────────────────────────────────────────────────┤ │
│ │ Halal Chicken Breast 1kg                           × 1   │ │
│ │ ¥1,200 each                                    ¥1,200    │ │
│ └──────────────────────────────────────────────────────────┘ │
│                                                              │
│ Subtotal:                                          ¥3,600   │
│ Shipping:                                            ¥500   │
│ ─────────────────────────────────────────────────────────── │
│ Total:                                             ¥4,100   │
│                                                              │
│ Payment: ✅ Confirmed (Bank Transfer)                        │
│                                                              │
│ ─────────────────────────────────────────────────────────── │
│ Status History                                               │
│ • Jan 28, 11:00 — Payment confirmed                         │
│ • Jan 28, 10:32 — Order placed                              │
│ ─────────────────────────────────────────────────────────── │
│ [Mark Ready for Shipping]                                    │
│ [Cancel Order]                                               │
└──────────────────────────────────────────────────────────────┘
```

### Status Badge Colors

| Status | Color | Badge | Description |
|--------|-------|-------|-------------|
| New / Pending Payment | 🔴 Red | Urgent attention | Needs immediate action |
| Confirmed | 🔵 Blue | Ready to start | Payment received |
| Preparing | 🟡 Yellow | In progress | Being prepared |
| Ready / Shipped | 🟢 Green | Awaiting completion | Ready for pickup/delivery |
| Fulfilled | ⚪ Gray | Completed | Order complete |
| Cancelled | ⚫ Black | Closed | Order cancelled |

---

## Implementation Notes

### Key Components Needed

- `OrdersDashboard` - Main orders view with filters
- `OrderStatusTabs` - Status filter tabs with counts
- `OrderSearchBar` - Search with date range and type filters
- `OrderCard` - Order summary card in list
- `OrderStatusBadge` - Colored status indicator
- `OrderDetails` - Full order detail view
- `CustomerInfo` - Customer contact details
- `FulfillmentInfo` - Delivery/pickup details
- `OrderItemsList` - Itemized order contents
- `OrderTimeline` - Status history
- `OrderActions` - Context-appropriate action buttons

### API Dependencies

- `GET /api/orders` - List orders with filters
- `GET /api/orders/{id}` - Order details
- `PATCH /api/orders/{id}/status` - Update order status
- `POST /api/orders/{id}/cancel` - Cancel order
- `GET /api/orders/stats` - Order statistics

### Design Tokens Required

- Colors: Status badge colors (red, blue, yellow, green, gray, black)
- Typography: Order numbers, customer names, amounts
- Spacing: Card padding, section dividers
- Icons: Status icons, fulfillment icons

### Order Status Flow

```
New → Confirmed → Preparing → Ready → Shipped (if delivery) → Fulfilled
         ↓
     Cancelled (at any stage before Fulfilled)
```

### Fulfillment Types

| Type | Icon | Actions |
|------|------|---------|
| **Delivery** | 🚚 | Mark Shipped → Track → Fulfilled |
| **Pickup** | 🏪 | Mark Ready → Customer Picks Up → Fulfilled |
| **Dine-in** | 🍽️ | Mark Ready → Served → Fulfilled |

### Filter Options

- **Status:** All, New, Confirmed, Preparing, Ready, Shipped, Fulfilled, Cancelled
- **Date Range:** Today, Yesterday, This Week, This Month, Custom
- **Type:** Delivery, Pickup, Dine-in
- **Search:** Order number, customer name, email

### Quick Actions by Status

| Status | Primary Action | Secondary |
|--------|---------------|-----------|
| New | Confirm Payment | Cancel |
| Confirmed | Start Preparing | Cancel |
| Preparing | Mark Ready | — |
| Ready | Mark Shipped / Complete | — |
| Shipped | Mark Delivered | — |

---

*End of Order Management Wireframes*
