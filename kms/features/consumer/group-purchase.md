# Group Order

> **Capability:** Part of Shop / Marketplace
> **Status:** Active
>
> **Related:** [[marketplace]] · [[web-app-spec]] · [[order-management]] · [[notifications]]

---

## Definition

**Group Order** allows multiple consumers to contribute items to a shared order from a single merchant. An "Initiator" creates the group, invites participants, and pays the merchant as a single transaction.

**Core value proposition:**
- Friends/families coordinate bulk orders together
- Merchants receive larger consolidated orders
- Potential for free shipping when order exceeds threshold

---

## How It Works

### Flow Overview

1. **Initiator** creates a group purchase for a merchant
2. **Initiator** shares invite link with participants
3. **Participants** join and add items to shared cart
4. **Deadline** expires or Initiator closes the group
5. **Initiator** reviews combined order and submits
6. **Initiator** pays the merchant (single payer model)
7. **Participants** reimburse Initiator externally
8. **Merchant** fulfills as a single order

### Why Single Payer?

- Simpler for merchants: one order, one payment, one fulfillment
- Avoids complex split-payment infrastructure in MVP
- Participants trust the Initiator (friends/family context)
- Halava provides per-participant breakdown for reimbursement

---

## User Journey

### Initiator: Create and Manage Group

```
Merchant Shopfront → [Start Group Order]
  → Set deadline (e.g., "Close in 3 days")
  → [Create Group]
  → Share Link: Copy / WhatsApp / LINE
  → Add own items to shared cart
  → Wait for participants...
  → [Review & Submit] when ready
  → Checkout: Pay full amount (delivery + items)
  → Receive order, distribute to participants
```

### Participant: Join and Contribute

```
Receive Invite Link → Open in Halava
  → "Join [Initiator]'s Group Order at Halal Mart"
  → [Join Group]
  → Browse merchant's products
  → Add items to shared cart
  → See real-time cart total
  → Wait for Initiator to submit...
  → Receive notification: "Order submitted!"
  → Reimburse Initiator (external)
```

---

## UI/UX Specification

> **Template Support:** Mobile + Desktop (see [[pages-navigation-ux-spec#1. Dual-Template Architecture]])

### Screens

| Screen | Path | Mobile | Desktop |
|--------|------|--------|---------|
| **Create Group** | `/m/{merchant}/group-order/new` | Full-screen | Modal |
| **Group Lobby** | `/group-order/{code}` | Full-screen | Page |
| **Join** | `/group-order/join/{code}` | Share sheet | Modal |
| **Checkout (Initiator)** | `/group-order/{code}/checkout` | Full-screen steps | Side panel |

### Group Lobby Layout

```
┌──────────────────────────────────────────┐
│ Group Order at Halal Mart                │
│ Created by: Ahmad (you)                  │
│ Deadline: 2 days left                    │
├──────────────────────────────────────────┤
│ Participants (3)                         │
│ ┌──────────────────────────────────────┐ │
│ │ 👤 Ahmad (Initiator)                 │ │
│ │    • Halal Beef 500g × 2   ¥2,400   │ │
│ │    • Rice 5kg × 1          ¥1,200   │ │
│ ├──────────────────────────────────────┤ │
│ │ 👤 Fatima                            │ │
│ │    • Lamb Chops 300g × 3   ¥2,940   │ │
│ ├──────────────────────────────────────┤ │
│ │ 👤 Yusuf                             │ │
│ │    • Chicken Breast × 2    ¥1,300   │ │
│ └──────────────────────────────────────┘ │
├──────────────────────────────────────────┤
│ Subtotal:                 ¥7,840        │
│ Shipping:                 FREE ✓        │
│ (Free over ¥5,000)                      │
│ ─────────────────────────────────────── │
│ Total:                    ¥7,840        │
├──────────────────────────────────────────┤
│ [+ Add More Items]    [📤 Invite More]  │
│                                          │
│ [ Submit Order ] (Initiator only)        │
└──────────────────────────────────────────┘
```

### Participant Breakdown Receipt

After order is placed, Initiator sees:

```
┌──────────────────────────────────────────┐
│ Order #HLV-GP-0042                       │
│ Group Purchase Breakdown                 │
├──────────────────────────────────────────┤
│ Ahmad's items:                  ¥3,600  │
│ Fatima's items:                 ¥2,940  │
│ Yusuf's items:                  ¥1,300  │
│ ─────────────────────────────────────── │
│ Subtotal:                       ¥7,840  │
│ Shipping:                           ¥0  │
│ Total Paid by Ahmad:            ¥7,840  │
├──────────────────────────────────────────┤
│ [ Share Breakdown ]  [ Download PDF ]    │
└──────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                      GroupPurchase                               │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  initiator_id    UUID FK → User                                 │
│  merchant_id     UUID FK → Merchant                             │
│  invite_code     VARCHAR(20) UNIQUE NOT NULL                    │
│  name            VARCHAR(255)                                   │
│  deadline        TIMESTAMP NOT NULL                             │
│  status          ENUM(open, closed, submitted, cancelled)       │
│  order_id        UUID FK → Order (after submission)             │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                GroupPurchaseParticipant                          │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  group_id        UUID FK → GroupPurchase                        │
│  user_id         UUID FK → User                                 │
│  is_initiator    BOOLEAN DEFAULT false                          │
│  joined_at       TIMESTAMP NOT NULL                             │
│  UNIQUE(group_id, user_id)                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                  GroupPurchaseItem                               │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  group_id        UUID FK → GroupPurchase                        │
│  participant_id  UUID FK → GroupPurchaseParticipant             │
│  item_id         UUID FK → Item                                 │
│  quantity        INT NOT NULL                                   │
│  unit_price      DECIMAL(10,2) NOT NULL                         │
│  modifiers       JSONB                                          │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `group_purchase` | `invite_code` (unique) | Join link lookup |
| `group_purchase` | `initiator_id, status` | My groups list |
| `group_purchase` | `deadline, status` | Auto-close job |
| `group_purchase_participant` | `group_id, user_id` (unique) | Membership check |
| `group_purchase_participant` | `user_id` | User's participations |
| `group_purchase_item` | `group_id` | Group cart contents |

---

## API Endpoints

> Full API index: [[api-spec#4.4 Group Purchases]]

### POST /v1/marketplace/group-purchases

Create a new group purchase.

```json
// Request
{
  "merchant_id": "uuid",
  "deadline": "2026-01-25T18:00:00Z",
  "name": "Weekend grocery run"  // optional
}

// Response
{
  "id": "uuid",
  "invite_code": "ABC123",
  "invite_url": "https://halava.app/group-order/ABC123",
  "deadline": "2026-01-25T18:00:00Z",
  "status": "open"
}
```

### GET /v1/marketplace/group-purchases/{code}

Get group purchase details by invite code.

```json
// Response
{
  "id": "uuid",
  "invite_code": "ABC123",
  "merchant": { "id": "uuid", "name": "Halal Mart" },
  "initiator": { "id": "uuid", "name": "Ahmad" },
  "deadline": "2026-01-25T18:00:00Z",
  "status": "open",
  "participants": [
    { "id": "uuid", "name": "Ahmad", "is_initiator": true, "items": [...], "subtotal": 3600 },
    { "id": "uuid", "name": "Fatima", "is_initiator": false, "items": [...], "subtotal": 2940 }
  ],
  "subtotal": 6540,
  "shipping_fee": 0,
  "total": 6540
}
```

### POST /v1/marketplace/group-purchases/{code}/join

Join a group purchase as participant.

```json
// Request
{}

// Response
{
  "message": "Joined group",
  "participant_id": "uuid"
}
```

### POST /v1/marketplace/group-purchases/{code}/items

Add item to group purchase (as current participant).

```json
// Request
{
  "product_id": "uuid",
  "quantity": 2
}

// Response
{
  "item": {
    "id": "uuid",
    "product": { ... },
    "quantity": 2,
    "unit_price": 1200,
    "total_price": 2400
  },
  "participant_subtotal": 2400,
  "group_total": 8940
}
```

### DELETE /v1/marketplace/group-purchases/{code}/items/{id}

Remove item from group purchase.

```json
// Response
{
  "message": "Item removed",
  "participant_subtotal": 0,
  "group_total": 6540
}
```

### POST /v1/marketplace/group-purchases/{code}/submit

Submit group purchase order (initiator only).

```json
// Request
{
  "fulfillment_type": "delivery",
  "shipping_address": { ... },
  "payment_method": "bank_transfer"
}

// Response
{
  "order_id": "uuid",
  "order_number": "HLV-GP-0042",
  "status": "placed",
  "total": 6540
}
```

### GET /v1/marketplace/group-purchases/{code}/breakdown

Get per-participant breakdown for reimbursement.

```json
// Response
{
  "order_number": "HLV-GP-0042",
  "participants": [
    { "name": "Ahmad", "items": [...], "subtotal": 3600 },
    { "name": "Fatima", "items": [...], "subtotal": 2940 }
  ],
  "shipping_fee": 0,
  "total_paid_by": "Ahmad",
  "total": 6540
}
```

---

## Business Rules

### Deadlines

- Initiator sets deadline at creation (default: 3 days)
- Group auto-closes at deadline if not submitted
- Initiator can close early via "Submit Order"

### Shipping Logic

```
if (order_total >= merchant.free_shipping_threshold) {
  shipping_fee = 0;
} else {
  shipping_fee = merchant.standard_shipping_fee;
}
```

Example thresholds:
- ¥5,000 → Free shipping
- ¥10,000 → Free priority shipping

### Participant Limits

- MVP: No limit on participants
- Future: Merchant-configurable limits

---

## Edge Cases

| Scenario | Handling |
|----------|----------|
| Participant adds out-of-stock item | Show "Only X available" |
| Item price changes before submit | Use snapshot price at add time |
| Deadline passes with no submit | Group marked "expired", items released |
| Initiator leaves group | Group cancelled, participants notified |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Groups created | Track |
| Avg. participants per group | > 2 |
| Group order value vs solo | +50% |
| Free shipping conversion | > 60% |

---

## Dependencies

- [[marketplace]] — Cart and checkout flow
- [[monetization]] — Transaction fees apply to total
- [[notifications]] — Distribution and reimbursement alerts

---

#halava #feature #group-order #consumer

