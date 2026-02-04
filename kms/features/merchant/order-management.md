# Order Management

> **Capability:** Order Management
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[pos]] · [[restaurant-ops]] · [[notifications]] · [[api-spec]]

---

## Definition

> **Core Logic:** The classification of order types is based on the principles defined in [[order-concepts]].

**Order Management** is Halava's unified system for merchants to receive, process, and fulfill orders from all channels — online marketplace, group purchases, and restaurant orders. It provides a single inbox and workflow for efficient order handling.

**Core value proposition:**
- Single dashboard for all incoming orders
- Real-time notifications for new orders
- Status tracking and customer communication
- Order history and fulfillment analytics

---

## How It Works

### Order Sources

| Source | Order Type | Fulfillment Options |
|--------|------------|---------------------|
| [[marketplace]] | Online order | Delivery, Pickup |
| [[group-purchase]] | Group order | Delivery, Pickup |
| [[restaurant-ops]] | Dine-in / Takeout | Table service, Counter pickup |
| [[pos]] | Walk-in sale | Immediate (no fulfillment) |

### Order Lifecycle

```
New Order → Review → Confirm → Prepare → Ready/Shipped → Fulfilled
     ↓                                         ↓
 Rejected                               Cancelled/Refunded
```

### Merchant Workflow

1. **Receive** — Order appears in inbox with notification
2. **Review** — Check items, customer details, fulfillment type
3. **Confirm** — Accept order, confirm payment received (Phase 1)
4. **Prepare** — Pick items, prepare package or food
5. **Ready/Ship** — Mark ready for pickup or hand to courier
6. **Fulfill** — Complete order, trigger receipt

---

## User Journey

### Merchant: Process New Order

```
🔔 Notification: "New order #HLV-001234"
  → Orders Dashboard
  → Order Card (highlighted as NEW):
    • Customer: Ahmad K.
    • Items: Halal Beef 500g × 2, Chicken 1kg × 1
    • Total: ¥4,100
    • Fulfillment: Delivery
  → [View Details]
  → Check payment status (Phase 1: pending bank transfer)
  → ...Payment received...
  → [Confirm Payment] → Status: Confirmed
  → Prepare items
  → [Mark Preparing]
  → Pack and label
  → [Mark Shipped] → Enter tracking number (optional)
  → Customer receives
  → [Mark Fulfilled]
```

### Merchant: Handle Pickup Order

```
Order Card: Pickup order
  → [Confirm] → [Mark Preparing]
  → Items ready
  → [Mark Ready for Pickup]
  → Customer notified
  → Customer arrives, shows order code
  → [Verify & Complete]
  → Order fulfilled
```

### Merchant: Cancel/Reject Order

```
Order Details → [Cancel Order]
  → Select Reason:
    • Out of stock
    • Cannot fulfill by requested date
    • Customer request
    • Payment not received (timeout)
  → [Confirm Cancellation]
  → Customer notified
  → If paid: Initiate refund flow
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Orders Dashboard** | `/merchant/orders` | All orders inbox |
| **Order Details** | `/merchant/orders/{id}` | Single order view |
| **Order History** | `/merchant/orders/history` | Past orders |
| **Order Settings** | `/merchant/settings/orders` | Preferences |

### Orders Dashboard Layout

```
┌──────────────────────────────────────────┐
│ Orders                           [⚙️]    │
├──────────────────────────────────────────┤
│ [All] [New (3)] [Preparing] [Ready] [Shipped] │
│                                          │
│ ─────────── Today ───────────            │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 🔴 NEW                    10:32 AM   │ │
│ │ #HLV-001234 · Ahmad K.               │ │
│ │ 3 items · ¥4,100 · Delivery          │ │
│ │ ⏱️ Payment pending                   │ │
│ │ [View] [Confirm Payment]             │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 🟡 PREPARING                9:15 AM  │ │
│ │ #HLV-001230 · Fatima S.              │ │
│ │ 2 items · ¥2,800 · Pickup            │ │
│ │ Pickup: Today 12:00 PM               │ │
│ │ [View] [Mark Ready]                  │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 🟢 READY                    8:45 AM  │ │
│ │ #HLV-001228 · Yusuf M.               │ │
│ │ 1 item · ¥1,200 · Pickup             │ │
│ │ Waiting for customer                 │ │
│ │ [View] [Complete]                    │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ─────────── Yesterday ───────────        │
│ ...                                      │
└──────────────────────────────────────────┘
```

### Order Details Layout

```
┌──────────────────────────────────────────┐
│ [←] Order #HLV-001234                    │
├──────────────────────────────────────────┤
│ Status: 🟡 Preparing                     │
│ Placed: Jan 28, 2026 · 10:32 AM         │
│                                          │
│ ─────────────────────────────────────── │
│ Customer                                 │
│ Ahmad K. · ahmad@email.com              │
│ 📞 080-1234-5678                         │
│                                          │
│ ─────────────────────────────────────── │
│ Fulfillment: 🚚 Delivery                 │
│ Address:                                 │
│ 〒150-0001 Tokyo, Shibuya-ku,           │
│ Jingumae 1-2-3, Apt 401                 │
│                                          │
│ ─────────────────────────────────────── │
│ Items                                    │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Beef 500g              × 2     │ │
│ │ ¥1,200 each             ¥2,400       │ │
│ ├──────────────────────────────────────┤ │
│ │ Halal Chicken Breast 1kg     × 1     │ │
│ │ ¥1,200 each             ¥1,200       │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Subtotal:              ¥3,600            │
│ Shipping:              ¥500              │
│ ─────────────────────────────────────── │
│ Total:                 ¥4,100            │
│                                          │
│ Payment: ✅ Confirmed (Bank Transfer)    │
│                                          │
│ ─────────────────────────────────────── │
│ [Mark Ready for Shipping]                │
│ [Cancel Order]                           │
└──────────────────────────────────────────┘
```

### Status Badge Colors

| Status | Color | Badge |
|--------|-------|-------|
| New / Pending Payment | 🔴 Red | Urgent attention |
| Confirmed | 🔵 Blue | Ready to start |
| Preparing | 🟡 Yellow | In progress |
| Ready / Shipped | 🟢 Green | Awaiting completion |
| Fulfilled | ⚪ Gray | Completed |
| Cancelled | ⚫ Black | Closed |

---

## Notifications

### Merchant Notifications

| Event | Channel | Message |
|-------|---------|---------|
| New order | Push + Sound | "New order #HLV-001234 — ¥4,100" |
| Payment confirmed | Push | "Payment received for #HLV-001234" |
| Pickup reminder | Push | "#HLV-001230 pickup scheduled in 1 hour" |
| Customer message | Push | "Message from Ahmad K. on #HLV-001234" |

### Customer Notifications

| Event | Channel | Message |
|-------|---------|---------|
| Order confirmed | Push + Email | "Your order is confirmed!" |
| Preparing | Push | "Your order is being prepared" |
| Shipped | Push + Email | "Your order is on the way" |
| Ready for pickup | Push + Email | "Your order is ready!" |

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         Order                                    │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  consumer_id     UUID FK → User                                 │
│  merchant_id     UUID FK → Merchant                             │
│  order_number    VARCHAR(20) UNIQUE NOT NULL                    │
│  status          ENUM(placed, pending_payment, confirmed,       │
│                       preparing, ready, shipped, fulfilled,     │
│                       cancelled)                                │
│  order_type      ENUM(online, group, pos)                       │
│  subtotal        DECIMAL(10,2) NOT NULL                         │
│  discount_amount DECIMAL(10,2) DEFAULT 0                        │
│  shipping_fee    DECIMAL(10,2) DEFAULT 0                        │
│  tax_amount      DECIMAL(10,2) DEFAULT 0                        │
│  total           DECIMAL(10,2) NOT NULL                         │
│  payment_method  VARCHAR(50)                                    │
│  payment_status  ENUM(pending, paid, refunded, failed)          │
│  fulfillment_type ENUM(delivery, pickup, dine_in)               │
│  shipping_address JSONB                                         │
│  notes           TEXT                                           │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       OrderItem                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  order_id        UUID FK → Order                                │
│  item_id         UUID FK → Item                                 │
│  name            VARCHAR(255) NOT NULL (snapshot)               │
│  quantity        INT NOT NULL                                   │
│  unit_price      DECIMAL(10,2) NOT NULL                         │
│  total_price     DECIMAL(10,2) NOT NULL                         │
│  modifiers       JSONB                                          │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    OrderStatusHistory                            │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  order_id        UUID FK → Order                                │
│  from_status     VARCHAR(50)                                    │
│  to_status       VARCHAR(50) NOT NULL                           │
│  changed_by      UUID FK → User                                 │
│  note            TEXT                                           │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘
```

### Order Status Flow

```
placed → pending_payment → confirmed → preparing → ready/shipped → fulfilled
                ↓                          ↓
            cancelled                  cancelled
```

| Status | Consumer Sees | Merchant Action |
|--------|---------------|-----------------|
| `placed` | "Order Placed" | Review order |
| `pending_payment` | "Awaiting Payment" | Wait for transfer |
| `confirmed` | "Payment Confirmed" | Confirm, start prep |
| `preparing` | "Preparing" | Pack items |
| `shipped` | "Shipped" | Provide tracking |
| `ready` | "Ready for Pickup" | Wait for customer |
| `fulfilled` | "Completed" | Done |

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `order` | `consumer_id, created_at DESC` | Purchase history |
| `order` | `merchant_id, status, created_at` | Dashboard filtering |
| `order` | `order_number` (unique) | Order lookup |
| `order_item` | `order_id` | Order items |
| `order_status_history` | `order_id, created_at` | Status timeline |

---

## API Endpoints

> Full API index: [[api-spec#6.5 Orders]]

### GET /v1/merchant/orders

List orders with filters.

```
Query Parameters:
  status        string    Filter: placed, pending_payment, confirmed, preparing, ready, shipped, fulfilled, cancelled
  fulfillment   string    Filter: delivery, pickup, dine_in
  from          date      Start date (YYYY-MM-DD)
  to            date      End date (YYYY-MM-DD)
  sort          string    created_at_desc, created_at_asc
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "orders": [
    {
      "id": "uuid",
      "order_number": "HLV-001234",
      "status": "preparing",
      "customer": { "name": "Ahmad K." },
      "items_count": 3,
      "total": 4100,
      "fulfillment_type": "delivery",
      "created_at": "2026-01-28T10:32:00+09:00"
    }
  ],
  "total": 45
}
```

### GET /v1/merchant/orders/{id}

Get order details.

```json
// Response
{
  "id": "uuid",
  "order_number": "HLV-001234",
  "status": "preparing",
  "customer": {
    "id": "uuid",
    "name": "Ahmad K.",
    "email": "ahmad@email.com",
    "phone": "080-1234-5678"
  },
  "items": [
    {
      "id": "uuid",
      "name": "Halal Beef 500g",
      "quantity": 2,
      "unit_price": 1200,
      "total_price": 2400
    }
  ],
  "subtotal": 3600,
  "shipping_fee": 500,
  "total": 4100,
  "payment_status": "paid",
  "fulfillment_type": "delivery",
  "shipping_address": {...},
  "created_at": "2026-01-28T10:32:00+09:00"
}
```

### PUT /v1/merchant/orders/{id}/status

Update order status.

```json
// Request
{
  "status": "preparing",
  "note": "Started packing"
}

// Response
{
  "id": "uuid",
  "status": "preparing",
  "updated_at": "2026-01-28T10:45:00+09:00"
}
```

### POST /v1/merchant/orders/{id}/confirm-payment

Confirm payment received (Phase 1: manual confirmation).

```json
// Request
{
  "payment_method": "bank_transfer",
  "note": "Received via Mizuho Bank"
}

// Response
{
  "id": "uuid",
  "payment_status": "paid",
  "confirmed_at": "2026-01-28T11:00:00+09:00"
}
```

### POST /v1/merchant/orders/{id}/cancel

Cancel an order.

```json
// Request
{
  "reason": "out_of_stock",
  "note": "Halal Beef 500g unavailable"
}

// Response
{
  "id": "uuid",
  "status": "cancelled",
  "cancelled_at": "2026-01-28T11:30:00+09:00"
}
```

### POST /v1/merchant/orders/{id}/refund

Initiate refund for an order.

```json
// Request
{
  "amount": 4100,  // Full or partial
  "reason": "Order cancelled due to stock unavailability"
}

// Response
{
  "id": "uuid",
  "refund_status": "pending",
  "refund_amount": 4100
}
```

### PUT /v1/merchant/orders/{id}/tracking

Add shipping tracking information.

```json
// Request
{
  "carrier": "yamato",
  "tracking_number": "1234-5678-9012"
}

// Response
{
  "id": "uuid",
  "tracking": {
    "carrier": "yamato",
    "tracking_number": "1234-5678-9012",
    "tracking_url": "https://..."
  }
}
```

### GET /v1/merchant/orders/stats

Get order statistics.

```
Query Parameters:
  period        string    today, week, month, year
```

```json
// Response
{
  "period": "today",
  "total_orders": 23,
  "total_revenue": 45200,
  "by_status": {
    "new": 3,
    "preparing": 5,
    "ready": 2,
    "fulfilled": 13
  },
  "by_fulfillment": {
    "delivery": 15,
    "pickup": 8
  }
}
```

---

## Order Settings

| Setting | Options | Default |
|---------|---------|---------|
| New order sound | On / Off | On |
| Auto-print order slip | On / Off | Off |
| Pickup slot duration | 15min / 30min / 1hr | 30min |
| Max orders per slot | Unlimited / 5 / 10 / 20 | Unlimited |
| Auto-cancel unpaid after | 1hr / 24hr / 48hr / Never | 24hr |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Order confirmation time | < 15 min avg |
| Fulfillment rate | > 95% |
| Cancellation rate | < 5% |
| Customer satisfaction (post-order) | > 4.0 |

---

## Dependencies

- [[marketplace]] — Online order source
- [[group-purchase]] — Group order source
- [[restaurant-ops]] — Restaurant order source
- [[notifications]] — Order alerts
- [[pos]] — Walk-in transactions (no fulfillment flow)

---

#halava #feature #order-management #merchant
