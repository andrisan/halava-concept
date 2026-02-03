# Group Purchase

> **Capability:** Part of Shop / Marketplace
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[web-app-spec]] · [[order-management]] · [[notifications]]

**v1.2 Enhancement:**
- **In-city Group Delivery** — Collaborative cart with dynamic shipping and distribution support

---

## Definition

**Group Purchase** allows multiple consumers to contribute items to a shared order from a single merchant. An "Initiator" creates the group, invites participants, and pays the merchant as a single transaction.

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

### Consumer Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Create Group** | `/m/{merchant}/group/new` | Start a group purchase |
| **Group Lobby** | `/group/{code}` | View group, add items |
| **Invite** | `/group/{code}/invite` | Share with friends |
| **Checkout (Initiator)** | `/group/{code}/checkout` | Submit and pay |

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

```
GroupPurchase
├── id: UUID
├── code: string (invite code, e.g., "HALAL-ABCD")
├── initiator_id: FK → User
├── merchant_id: FK → Merchant
├── status: enum (open, closed, submitted, fulfilled)
├── deadline: timestamp
├── order_id: FK → Order (after submission)
├── created_at, updated_at

GroupPurchaseParticipant
├── id: UUID
├── group_id: FK → GroupPurchase
├── user_id: FK → User
├── joined_at: timestamp

GroupPurchaseItem
├── id: UUID
├── group_id: FK → GroupPurchase
├── participant_id: FK → GroupPurchaseParticipant
├── item_id: FK → Item
├── quantity: int
├── unit_price: decimal (snapshot)
├── added_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/v1/groups` | Create group purchase |
| `GET` | `/api/v1/groups/{code}` | Get group details |
| `POST` | `/api/v1/groups/{code}/join` | Join as participant |
| `POST` | `/api/v1/groups/{code}/items` | Add item (participant) |
| `DELETE` | `/api/v1/groups/{code}/items/{id}` | Remove item |
| `POST` | `/api/v1/groups/{code}/submit` | Submit order (initiator) |
| `GET` | `/api/v1/groups/{code}/breakdown` | Get participant breakdown |

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

## In-city Group Delivery

> **Version:** v1.2

In-city Group Delivery enhances Group Purchase for urban communities where participants are geographically close and can coordinate pickup/distribution.

### Key Enhancements

| Feature | MVP | v1.2 |
|---------|-----|------|
| Collaborative cart | ✓ | ✓ |
| Single payer | ✓ | ✓ |
| Free shipping threshold | ✓ | Enhanced |
| Delivery to initiator | ✓ | ✓ |
| Distribution tracking | — | ✓ New |
| Participant addresses | — | ✓ New |
| Route optimization | — | ✓ New |

### Use Case

A group of friends/neighbors in the same area want to order halal groceries together:
- Combine orders to reach free delivery threshold
- Initiator receives all items
- Initiator distributes to participants nearby
- Clear breakdown for reimbursement

### Enhanced Flow

```
Initiator creates group
  → Participants join and add items
  → Each participant adds their address (optional)
  → System shows:
    - Combined order total
    - Distance between participants
    - Suggested distribution route
  → Initiator submits order
  → Order delivered to Initiator
  → Initiator marks items as "Distributed" per participant
  → Participants notified to reimburse
```

### Dynamic Shipping Thresholds

```
┌──────────────────────────────────────────┐
│ Shipping                                 │
├──────────────────────────────────────────┤
│                                          │
│ Order Total: ¥8,500                      │
│                                          │
│ ████████████████████░░░░ ¥8,500/¥10,000 │
│                                          │
│ 🚚 Standard Delivery: ¥500              │
│                                          │
│ Add ¥1,500 more for FREE delivery!      │
│ Add ¥3,500 more for FREE priority!      │
│                                          │
│ [Invite More Friends]                    │
│                                          │
└──────────────────────────────────────────┘
```

### Participant Addresses

Optional feature for distribution planning:

```
┌──────────────────────────────────────────┐
│ Group Members                            │
├──────────────────────────────────────────┤
│                                          │
│ 👤 Ahmad (Initiator) — Shibuya          │
│    Delivery address: 〒150-0001...       │
│                                          │
│ 👤 Fatima — 0.8 km away                  │
│    📍 Add pickup address                 │
│                                          │
│ 👤 Yusuf — 1.2 km away                   │
│    📍 Shinjuku-ku, Nishi-Shinjuku...     │
│                                          │
│ Distribution Route:                      │
│ Ahmad → Yusuf (1.2 km) → Fatima (0.5 km) │
│ Total: ~15 min by bicycle                │
│                                          │
└──────────────────────────────────────────┘
```

### Distribution Tracking

After order is delivered to Initiator:

```
┌──────────────────────────────────────────┐
│ Distribute Items                         │
├──────────────────────────────────────────┤
│                                          │
│ Order delivered to you! Time to          │
│ distribute to your group members.        │
│                                          │
│ ☑ Ahmad (you) — ¥3,600                  │
│   Items collected                        │
│                                          │
│ ☐ Fatima — ¥2,940                       │
│   [Mark as Distributed]                  │
│   → Sends notification + payment request │
│                                          │
│ ☐ Yusuf — ¥1,300                        │
│   [Mark as Distributed]                  │
│                                          │
│ Suggested route: You → Yusuf → Fatima    │
│ [Open in Maps]                           │
│                                          │
└──────────────────────────────────────────┘
```

### Reimbursement Request

When Initiator marks "Distributed":

```
Notification to Participant:
┌──────────────────────────────────────────┐
│ 📦 Your items are ready!                 │
├──────────────────────────────────────────┤
│                                          │
│ Ahmad has your items from the group      │
│ order at Halal Mart.                     │
│                                          │
│ Your items:                              │
│ • Lamb Chops 300g × 3         ¥2,940    │
│                                          │
│ Please reimburse Ahmad:                  │
│ Amount: ¥2,940                           │
│                                          │
│ [Copy Amount] [Open PayPay] [Open LINE]  │
│                                          │
│ Already paid? [Mark as Paid]             │
│                                          │
└──────────────────────────────────────────┘
```

### Data Model Additions

```
GroupPurchase (v1.2 additions)
├── delivery_type: enum (standard, group_delivery)
├── distribution_status: enum (pending, in_progress, completed)

GroupPurchaseParticipant (v1.2 additions)
├── address: string (nullable)
├── location: PostGIS Point (nullable)
├── distribution_status: enum (pending, distributed, confirmed)
├── distributed_at: timestamp (nullable)
├── reimbursement_status: enum (pending, paid)
```

### Success Metrics (v1.2)

| Metric | Target |
|--------|--------|
| Groups using addresses | > 40% |
| Distribution completion rate | > 90% |
| Avg. order value (group delivery) | +30% vs standard |
| Reimbursement confirmation rate | > 70% |

---

## Dependencies

- [[marketplace]] — Cart and checkout flow
- [[monetization]] — Transaction fees apply to total
- [[notifications]] — Distribution and reimbursement alerts

---

#halava #feature #group-purchase #consumer
