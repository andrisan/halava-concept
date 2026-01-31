# Restaurant Operations

> **Capability:** Restaurant Operations
> **Version:** v1.1
> **Status:** Planned
>
> **Related:** [[pos]] · [[marketplace]] · [[capabilities]] · [[directory]]

---

## Definition

**Restaurant Operations** enables food service businesses to manage menus, accept dine-in/takeaway orders, process payments (online or at counter), and coordinate kitchen workflow.

**Core value proposition:**
- Unified ordering flow for dine-in and takeaway
- Flexible payment: online or at counter
- Real-time kitchen queue and order tracking
- QR menu for contactless ordering

---

## How It Works

### Unified Ordering Flow

The key insight: **payment method determines order type**, not the other way around.

| Payment Choice | Order Type | Processing |
|----------------|------------|------------|
| Pay Online | Online Order | → Order Inbox |
| Pay at Counter | Prepared Order | → POS Queue |

### For Consumers

1. **Access menu** via QR code, storefront, or app
2. **Browse and add** items to cart
3. **Select fulfillment:** Dine-in or Takeaway
4. **Choose payment:**
   - Pay Online → Bank transfer (Phase 1) or Card (Phase 2)
   - Pay at Counter → Cash/Card at pickup
5. **Track preparation** in real-time
6. **Receive notification** when ready
7. **Collect food** at counter or table

### For Merchants

1. **Enable** Restaurant Operations capability
2. **Add menu items** with modifiers, prices, photos
3. **Configure** ordering settings (QR menu, time slots)
4. **Receive orders** in kitchen queue
5. **Mark status:** Received → Preparing → Ready
6. **Notify customer** when food is ready
7. **Complete** (hand off food, mark fulfilled)

---

## User Journey

### Consumer: Order Food (Pay Online)

```
Scan QR at Table → Menu Page
  → Browse categories
  → Add "Beef Rendang" × 1
  → Add "Nasi Goreng" × 2
  → [View Cart]
  → Fulfillment: ● Dine-in (Table 5) ○ Takeaway
  → [Checkout]
  → Payment: [Pay Online]
  → Transfer to merchant bank / Pay by card
  → Order Confirmed
  → Track: Received → Preparing → Ready
  → Notification: "Your order is ready!"
  → Served at table
```

### Consumer: Order Food (Pay at Counter)

```
Scan QR at Table → Menu Page
  → Add items to cart
  → Fulfillment: ● Dine-in (Table 5)
  → [Checkout]
  → Payment: [Pay at Counter]
  → "Proceed to counter to pay"
  → Show order QR/number at counter
  → Cashier opens Prepared Order in POS
  → Pay cash/card
  → Order Confirmed → Kitchen starts
  → Track: Preparing → Ready
  → Food served
```

### Merchant: Kitchen Workflow

```
Kitchen Queue → New Order Alert 🔔
  → View Order #0087:
      Table 5 / Dine-in
      • Beef Rendang × 1
      • Nasi Goreng × 2
  → [Start Preparing]
  → Status → Preparing (customer notified)
  → Cook food...
  → [Mark Ready]
  → Status → Ready (customer notified)
  → Server delivers to table
  → [Mark Fulfilled]
```

---

## UI/UX Specification

### Consumer Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **QR Menu** | `/m/{merchant}/menu` | Browse menu |
| **Menu Item** | `/m/{merchant}/menu/{item}` | Item details + modifiers |
| **Cart** | Drawer | Current order |
| **Checkout** | `/m/{merchant}/checkout` | Fulfillment + payment |
| **Order Status** | `/orders/{id}` | Real-time tracking |

### Menu Page Layout

```
┌──────────────────────────────────────────┐
│ [←] Halal Bistro Menu           [🛒 3]  │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │ 🔍 Search menu                       │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Categories:                              │
│ [All] [Mains] [Sides] [Drinks] [Dessert]│
│                                          │
│ ┌─────────────┐ ┌─────────────┐          │
│ │ 📷          │ │ 📷          │          │
│ │ Beef Rendang│ │ Nasi Goreng │          │
│ │ ¥1,500      │ │ ¥1,200      │          │
│ │ [+ Add]     │ │ [+ Add]     │          │
│ └─────────────┘ └─────────────┘          │
│                                          │
│ ┌─────────────┐ ┌─────────────┐          │
│ │ 📷          │ │ 📷          │          │
│ │ Satay (6pc) │ │ Mango Lassi │          │
│ │ ¥800        │ │ ¥500        │          │
│ │ [+ Add]     │ │ [+ Add]     │          │
│ └─────────────┘ └─────────────┘          │
└──────────────────────────────────────────┘
```

### Order Tracking (Consumer)

```
┌──────────────────────────────────────────┐
│ Order #ORD-0087                          │
│ Halal Bistro · Dine-in · Table 5         │
├──────────────────────────────────────────┤
│                                          │
│    ●──────────●──────────○──────────○    │
│ Confirmed  Preparing    Ready    Served  │
│                                          │
│ Estimated: 15 minutes                    │
│                                          │
├──────────────────────────────────────────┤
│ Your Order:                              │
│ • Beef Rendang × 1            ¥1,500    │
│ • Nasi Goreng × 2             ¥2,400    │
│ ─────────────────────────────────────── │
│ Total:                        ¥3,900    │
└──────────────────────────────────────────┘
```

### Merchant Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Kitchen Queue** | `/merchant/kitchen` | Incoming orders |
| **Menu Management** | `/merchant/menu` | Add/edit items |
| **Order History** | `/merchant/orders` | Past orders |

### Kitchen Queue Layout

```
┌──────────────────────────────────────────────────────────────┐
│ Kitchen Queue                        [🔔 Sound: On] [⚙️]    │
├──────────────────────────────────────────────────────────────┤
│ New (2)          │ Preparing (3)      │ Ready (1)           │
│ ──────────────── │ ────────────────── │ ─────────────────── │
│ ┌──────────────┐ │ ┌────────────────┐ │ ┌─────────────────┐ │
│ │ #0089        │ │ │ #0087          │ │ │ #0085           │ │
│ │ Table 7      │ │ │ Table 5        │ │ │ Takeaway        │ │
│ │ Dine-in      │ │ │ Dine-in        │ │ │                 │ │
│ │ ──────────── │ │ │ ────────────── │ │ │ Waiting for     │ │
│ │ Satay × 2    │ │ │ Rendang × 1    │ │ │ pickup          │ │
│ │ Mango Lassi  │ │ │ Nasi Goreng ×2 │ │ │                 │ │
│ │              │ │ │                │ │ │ [Fulfilled]     │ │
│ │ [Accept]     │ │ │ [Ready]        │ │ └─────────────────┘ │
│ └──────────────┘ │ └────────────────┘ │                     │
│ ┌──────────────┐ │ ┌────────────────┐ │                     │
│ │ #0090        │ │ │ #0086          │ │                     │
│ │ Takeaway     │ │ │ Table 3        │ │                     │
│ │ [Accept]     │ │ │ [Ready]        │ │                     │
│ └──────────────┘ │ └────────────────┘ │                     │
└──────────────────────────────────────────────────────────────┘
```

---

## Data Model

```
MenuItem (extends Item base)
├── item_type: 'menu_item'
├── enabled_channels: ['restaurant', 'pos']
│
└── MenuItemExtension
    ├── modifiers: JSONB
    │   └── [{ name: "Spice Level", options: ["Mild", "Medium", "Hot"], 
    │          required: true, price_adjustments: { "Hot": 100 } }]
    ├── prep_time_minutes: int
    ├── course_type: enum (appetizer, main, dessert, drink)
    ├── dietary_tags: string[] (vegetarian, vegan, gluten-free)
    └── available_times: JSONB (breakfast, lunch, dinner)

RestaurantOrder (extends Order base)
├── type: 'restaurant'
├── fulfillment_type: enum (dine_in, takeaway)
├── table_number: string (nullable)
├── requested_time: timestamp (for scheduled orders)
├── prep_started_at: timestamp
├── ready_at: timestamp
├── served_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/merchants/{id}/menu` | Get public menu |
| `GET` | `/api/v1/merchants/{id}/menu/{itemId}` | Get item details |
| `POST` | `/api/v1/merchant/menu` | Add menu item |
| `PUT` | `/api/v1/merchant/menu/{id}` | Update menu item |
| `GET` | `/api/v1/merchant/kitchen/queue` | Get kitchen queue |
| `PUT` | `/api/v1/merchant/orders/{id}/status` | Update order status |

### Order Status Updates

```
PUT /api/v1/merchant/orders/{id}/status
{
  "status": "preparing",  // or "ready", "fulfilled"
  "estimated_ready_minutes": 15  // optional
}
```

---

## Order Status Flow

### Online Payment Orders

```
placed → confirmed → preparing → ready → fulfilled
```

### Pay at Counter Orders

```
prepared → (payment at POS) → confirmed → preparing → ready → fulfilled
```

---

## QR Menu System

### QR Code Generation

Merchants get unique QR codes for:
- General menu: `/m/{merchant}/menu`
- Table-specific: `/m/{merchant}/menu?table=5`

### Table Detection

When customer scans table QR:
1. Table number auto-fills in checkout
2. "Dine-in at Table 5" shown in cart
3. Order tagged with table for kitchen

---

## Notifications

| Event | Consumer Notification | Merchant Notification |
|-------|----------------------|----------------------|
| Order placed | "Order confirmed!" | 🔔 New order sound |
| Preparing | "Your order is being prepared" | — |
| Ready | "Your order is ready!" | — |
| Ready (Takeaway) | "Pickup at counter" | — |

---

## Future Enhancements (v1.2+)

- **Reservations:** Table booking system
- **Split bills:** Divide check among diners
- **Modifiers pricing:** Complex modifier combinations
- **Scheduled orders:** Order ahead for specific time
- **Kitchen display system:** Dedicated kitchen screen mode

---

## Success Metrics

| Metric | Target (v1.1) |
|--------|---------------|
| Order placement to ready | < 20 min avg |
| Kitchen queue adoption | 80% of restaurants |
| QR menu usage | 60% of dine-in orders |
| Customer notification open rate | > 70% |

---

## Dependencies

- [[web-app-spec#Capability lifecycle]] — Restaurant Operations must be enabled
- [[pos]] — Prepared Orders queue integration
- [[directory]] — Place page for discovery

---

#halava #feature #restaurant #merchant #v1.1
