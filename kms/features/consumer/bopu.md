# BOPU (Buy Online, Pick Up)

> **Feature Type:** Consumer
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[order-management]] · [[notifications]]

---

## Definition

**BOPU (Buy Online, Pick Up)** is Halava's in-store pickup fulfillment option. Consumers order online and collect their items at the merchant's physical location, avoiding delivery fees and wait times.

**Core value proposition:**
- Skip delivery fees
- Faster fulfillment (often same-day)
- Flexible pickup timing
- Verify products in person before leaving

---

## How It Works

### Consumer Flow

1. **Shop online** — Browse and add items to cart
2. **Choose pickup** — Select "Pick Up" at checkout
3. **Select location** — Choose pickup store (if multiple)
4. **Select time** — Choose pickup window (optional)
5. **Place order** — Complete payment
6. **Wait for ready** — Receive notification when ready
7. **Pick up** — Go to store, show order, collect items

### Merchant Flow

1. **Receive order** — Order appears in dashboard
2. **Prepare items** — Pack order for pickup
3. **Mark ready** — Customer notified
4. **Hand off** — Verify order number, give items
5. **Complete** — Mark as fulfilled

---

## User Journey

### Consumer: Order with Pickup

```
Cart → [Checkout]
  → Fulfillment:
    ○ Delivery (¥500)
    ● Pick Up (Free)

  → Select Pickup Location:
    ┌─────────────────────────────────────┐
    │ ● Halal Mart Shibuya               │
    │   〒150-0001 Shibuya-ku...          │
    │   0.8 km · Open until 21:00        │
    ├─────────────────────────────────────┤
    │ ○ Halal Mart Shinjuku              │
    │   〒160-0022 Shinjuku-ku...         │
    │   2.3 km · Open until 22:00        │
    └─────────────────────────────────────┘

  → Pickup Window (optional):
    [Today] [Tomorrow] [Select Date]
    [ASAP] [12:00-14:00] [14:00-16:00] ...

  → [Place Order]
  → Order confirmed
  → "We'll notify you when ready!"
```

### Consumer: Pick Up Order

```
Notification: "Your order is ready for pickup!"
  → Open app → Orders → Order #HLV-001234
  → View pickup details:
    ┌─────────────────────────────────────┐
    │ Ready for Pickup                    │
    │                                     │
    │ Halal Mart Shibuya                  │
    │ 〒150-0001 Shibuya-ku, Jingumae 1-2 │
    │                                     │
    │ Order #: HLV-001234                 │
    │ Pickup Code: 7842                   │
    │                                     │
    │ [Get Directions] [Show QR Code]     │
    └─────────────────────────────────────┘
  → Go to store
  → Show QR code or pickup code to staff
  → Receive items
  → Order marked as fulfilled
```

### Merchant: Process Pickup Order

```
Orders Dashboard → New Order Alert
  → Order #HLV-001234 (Pickup)
  → View items to prepare
  → [Start Preparing]
  → Pack items
  → [Mark Ready for Pickup]
  → Customer notified
  → Wait for customer...
  → Customer arrives, shows code
  → Verify order number
  → Hand over items
  → [Mark Fulfilled]
```

---

## UI/UX Specification

### Checkout: Fulfillment Selection

```
┌──────────────────────────────────────────┐
│ Fulfillment                              │
├──────────────────────────────────────────┤
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ ○ Delivery                     ¥500  │ │
│ │   Estimated: 2-3 days                │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ ● Pick Up                      Free  │ │
│ │   Ready in 2-4 hours                 │ │
│ │   ✓ Save on delivery fees            │ │
│ └──────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Checkout: Pickup Location

```
┌──────────────────────────────────────────┐
│ Pickup Location                          │
├──────────────────────────────────────────┤
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ ● Halal Mart Shibuya                 │ │
│ │   〒150-0001 Tokyo, Shibuya-ku,       │ │
│ │   Jingumae 1-2-3                      │ │
│ │                                      │ │
│ │   📍 0.8 km · 🕐 Open until 21:00    │ │
│ │                                      │ │
│ │   [View on Map]                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ ○ Halal Mart Shinjuku                │ │
│ │   〒160-0022 Tokyo, Shinjuku-ku...    │ │
│ │   📍 2.3 km · 🕐 Open until 22:00    │ │
│ └──────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Checkout: Pickup Time (Optional)

```
┌──────────────────────────────────────────┐
│ Pickup Time                              │
├──────────────────────────────────────────┤
│                                          │
│ When would you like to pick up?          │
│                                          │
│ [Today ▼]                                │
│                                          │
│ ┌──────┐ ┌────────────┐ ┌────────────┐  │
│ │ ASAP │ │ 12:00-14:00│ │ 14:00-16:00│  │
│ └──────┘ └────────────┘ └────────────┘  │
│ ┌────────────┐ ┌────────────┐           │
│ │ 16:00-18:00│ │ 18:00-20:00│           │
│ └────────────┘ └────────────┘           │
│                                          │
│ Note: We'll notify you when your order   │
│ is ready. Pickup anytime during store    │
│ hours after notification.                │
│                                          │
└──────────────────────────────────────────┘
```

### Order Status: Ready for Pickup

```
┌──────────────────────────────────────────┐
│ [←] Order #HLV-001234                    │
├──────────────────────────────────────────┤
│                                          │
│    ●──────────●──────────●──────────○    │
│ Confirmed  Preparing    Ready    Picked Up│
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │         Ready for Pickup!            │ │
│ │                                      │ │
│ │ Your order is waiting at:            │ │
│ │                                      │ │
│ │ 📍 Halal Mart Shibuya                │ │
│ │ 〒150-0001 Shibuya-ku, Jingumae 1-2  │ │
│ │                                      │ │
│ │ Store Hours: 10:00 - 21:00           │ │
│ │                                      │ │
│ │ ─────────────────────────────────── │ │
│ │                                      │ │
│ │ Pickup Code:                         │ │
│ │ ┌────────────────────────────────┐  │ │
│ │ │           7842                 │  │ │
│ │ └────────────────────────────────┘  │ │
│ │                                      │ │
│ │ [Show QR Code]  [Get Directions]    │ │
│ │                                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Order Details                            │
│ ─────────────                            │
│ Halal Beef 500g × 2          ¥2,400     │
│ Lamb Chops 300g × 1            ¥980     │
│ ───────────────────────────────────     │
│ Total:                       ¥3,380     │
│                                          │
└──────────────────────────────────────────┘
```

### Pickup QR Code Modal

```
┌──────────────────────────────────────────┐
│ Pickup Code                         [×]  │
├──────────────────────────────────────────┤
│                                          │
│ Show this to staff at pickup:            │
│                                          │
│         ┌──────────────────┐             │
│         │                  │             │
│         │    [QR CODE]     │             │
│         │                  │             │
│         │                  │             │
│         └──────────────────┘             │
│                                          │
│         Order #HLV-001234                │
│         Code: 7842                       │
│                                          │
│ Can't scan? Tell staff your code: 7842   │
│                                          │
└──────────────────────────────────────────┘
```

### Merchant: Pickup Order Card

```
┌──────────────────────────────────────────┐
│ #HLV-001234 · Pickup                     │
│ Ahmad K.                                 │
├──────────────────────────────────────────┤
│                                          │
│ Items:                                   │
│ • Halal Beef 500g × 2                   │
│ • Lamb Chops 300g × 1                   │
│                                          │
│ Requested: Today, ASAP                   │
│                                          │
│ Status: Preparing                        │
│                                          │
│ [Mark Ready for Pickup]                  │
│                                          │
└──────────────────────────────────────────┘
```

---

## Pickup Locations

### Single Location Merchant

- Pickup location = merchant's registered address
- No selection needed at checkout

### Multi-Location Merchant

- Merchant configures multiple pickup points
- Consumer selects preferred location
- Inventory checked per location

### Pickup Location Data

```
PickupLocation
├── id: UUID
├── merchant_id: FK → Merchant
├── name: string ("Shibuya Store")
├── address: string
├── location: PostGIS Point
├── operating_hours: JSONB
├── is_active: boolean
├── instructions: text (optional)
│   └── "Enter from back door, ask at counter"
```

---

## Order Status Flow

```
placed → confirmed → preparing → ready → fulfilled
                                  ↓
                              expired (if not picked up)
```

### Status Descriptions

| Status | Consumer Sees | Duration |
|--------|---------------|----------|
| `confirmed` | "Order confirmed" | Until prep starts |
| `preparing` | "Being prepared" | Typical: 1-4 hours |
| `ready` | "Ready for pickup!" | Until collected |
| `fulfilled` | "Picked up" | Final |
| `expired` | "Pickup expired" | After hold period |

### Hold Period

- Orders held for **48 hours** after ready
- After 48h: Merchant contacts customer
- After 72h: Order marked expired, refund initiated

---

## Notifications

| Event | Notification |
|-------|--------------|
| Order placed | "Order confirmed! We'll notify you when ready." |
| Ready | "Your order is ready for pickup at [Location]!" |
| Reminder (24h) | "Don't forget! Your order is waiting at [Location]." |
| Expiring soon | "Please pick up your order today or contact the store." |

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/v1/merchant/pickup-locations` | List merchant's pickup locations |
| `GET` | `/v1/consumer/orders/{id}/pickup` | Get pickup details and QR code |
| `POST` | `/v1/merchant/orders/{id}/ready` | Mark ready for pickup |
| `POST` | `/v1/merchant/orders/{id}/fulfilled` | Mark picked up |

### Checkout Request (with Pickup)

```json
{
  "cart_id": "uuid",
  "fulfillment": {
    "type": "pickup",
    "location_id": "uuid",
    "requested_time": "2026-01-28T14:00:00+09:00"
  },
  "payment_method": "bank_transfer"
}
```

---

## Business Rules

### Pickup Availability

- Only shown if merchant has `pickup_enabled: true`
- Grayed out if selected location is closed
- Time slots respect store operating hours

### Inventory

- Inventory reserved at order placement
- Released if order cancelled or expired
- Same inventory pool as delivery orders

### Fees

- BOPU is **free** (no fulfillment fee)
- Merchants may offer pickup-only discounts (future)

---

## Edge Cases

| Scenario | Handling |
|----------|----------|
| Store closes before pickup | Notify customer, extend to next business day |
| Customer no-show | Hold 48h, then contact, then expire |
| Wrong items prepared | Merchant corrects on-site, adjust order if needed |
| Partial pickup | Not supported in MVP (full order only) |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| BOPU selection rate | > 25% of eligible orders |
| Ready-to-pickup time | < 4 hours average |
| Pickup completion rate | > 95% |
| No-show rate | < 5% |

---

## Dependencies

- [[marketplace]] — Cart and checkout flow
- [[order-management]] — Order status management
- [[notifications]] — Ready notifications
- [[pos]] — Staff verification at pickup

---

#halava #feature #bopu #pickup #consumer #fulfillment
