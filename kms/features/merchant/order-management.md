# Order Management

> **Capability:** Order Management
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[pos]] · [[restaurant-ops]] · [[notifications]] · [[api-spec]]

---

## Definition

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

```
Order (extended from [[marketplace]])
├── id: UUID
├── order_number: string (HLV-XXXXXX)
├── merchant_id: FK → Merchant
├── consumer_id: FK → User
├── source: enum (marketplace, group_purchase, restaurant)
│
├── status: enum
│   └── placed, pending_payment, confirmed, preparing, 
│       ready, shipped, fulfilled, cancelled, refunded
├── status_history: JSONB
│   └── [{ status, timestamp, actor_id, note }]
│
├── items: OrderItem[]
├── subtotal, discount_amount, shipping_fee, total: decimal
│
├── fulfillment_type: enum (delivery, pickup, dine_in, takeout)
├── shipping_address: JSONB (nullable)
├── pickup_location_id: FK (nullable)
├── scheduled_at: timestamp (nullable)
│
├── payment_method: enum (bank_transfer, card, cash)
├── payment_status: enum (pending, confirmed, failed, refunded)
├── payment_confirmed_at: timestamp (nullable)
│
├── tracking_number: string (nullable)
├── courier: string (nullable)
│
├── notes: text (customer notes)
├── internal_notes: text (merchant notes)
│
├── created_at, updated_at: timestamp

OrderStatusHistory
├── order_id: FK → Order
├── from_status: enum
├── to_status: enum
├── changed_by: FK → User (staff/system)
├── note: text (nullable)
├── created_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/merchant/orders` | List orders (with filters) |
| `GET` | `/api/v1/merchant/orders/{id}` | Get order details |
| `PUT` | `/api/v1/merchant/orders/{id}/status` | Update order status |
| `POST` | `/api/v1/merchant/orders/{id}/confirm-payment` | Confirm payment received |
| `POST` | `/api/v1/merchant/orders/{id}/cancel` | Cancel order |
| `POST` | `/api/v1/merchant/orders/{id}/refund` | Initiate refund |
| `PUT` | `/api/v1/merchant/orders/{id}/tracking` | Add tracking info |
| `GET` | `/api/v1/merchant/orders/stats` | Order statistics |

### Query Parameters

```
GET /api/v1/merchant/orders?
  status=preparing,ready
  &fulfillment=delivery
  &from=2026-01-01
  &to=2026-01-31
  &sort=created_at_desc
  &limit=20
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
