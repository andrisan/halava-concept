# Personal Price History

> **Feature Type:** Consumer (Always Available)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[purchase-history]] · [[marketplace]] · [[directory]]

---

## Definition

**Personal Price History** is a personal finance tool within Halava that helps consumers track what they've paid for items over time. It uses only the consumer's own purchase history — not cross-merchant comparisons — to surface insights about spending patterns.

**Core value proposition:**
- See what you paid for an item across your past purchases
- Identify your best previous deal for repurchasing
- Track personal spending trends on frequently bought items
- Make informed decisions based on your own history

> **Design Note:** This feature intentionally avoids real-time cross-merchant price comparison to maintain healthy merchant relationships. Halava supports all merchants equally rather than driving a race-to-the-bottom on pricing.

---

## How It Works

### Data Sources

| Source | Description | Scope |
|--------|-------------|-------|
| Your Online Orders | Prices from Marketplace purchases | Your account only |
| Your POS Transactions | Linked in-store purchases | Your account only |
| Your Restaurant Orders | Menu item prices from dining | Your account only |

### What This Feature Does NOT Do

- ❌ Compare prices across merchants in real-time
- ❌ Show other consumers' purchase prices
- ❌ Highlight "best price" among current merchant offerings
- ❌ Alert when a merchant lowers prices

---

## User Journey

### Consumer: View Item Price History

```
Purchase History → Tap past purchase
  → Tap item "Halal Beef 500g"
  → [See My Price History]
  → View all times YOU bought this item:
    • Jan 28: ¥1,200 @ Halal Mart
    • Dec 20: ¥1,100 @ Muslim Grocers ← Your best price
    • Nov 5: ¥1,350 @ Online Store
  → "You paid least at Muslim Grocers (Dec 20)"
  → [View Merchant] → Shop again
```

### Consumer: Spot Spending Trends

```
Purchase History → Insights → Frequently Bought
  → "Halal Chicken Breast 1kg"
    • Bought 8 times
    • Average price: ¥1,180
    • Range: ¥1,050 - ¥1,350
  → Helps budget for next purchase
```

### Consumer: Repurchase Decision

```
Product Page (Halal Beef 500g) → [Your History]
  → "You've bought this 5 times"
  → Last purchase: ¥1,200 (Jan 28)
  → Your best price: ¥1,100 (Dec 20 @ Muslim Grocers)
  → Current price here: ¥1,180
  → User decides whether to buy
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **My Price History** | `/purchases/item/{id}` | Your purchase history for one item |
| **Frequently Bought** | `/purchases/frequent` | Items you buy regularly |

### My Price History Layout

```
┌──────────────────────────────────────────┐
│ [←] My Price History                     │
├──────────────────────────────────────────┤
│ Halal Beef 500g                          │
│ Your purchase history                    │
│                                          │
│ Summary                                  │
│ ┌──────────────────────────────────────┐ │
│ │ Bought: 5 times                      │ │
│ │ Total spent: ¥6,000                  │ │
│ │ Average price: ¥1,200                │ │
│ │ Your best price: ¥1,100              │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Your Purchases                           │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 28, 2026                         │ │
│ │ Halal Mart Shibuya                   │ │
│ │ ¥1,200                               │ │
│ │ [View Receipt] [Shop Here]           │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Dec 20, 2025 · ⭐ Your Best Price    │ │
│ │ Muslim Grocers                       │ │
│ │ ¥1,100                               │ │
│ │ [View Receipt] [Shop Here]           │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Nov 5, 2025                          │ │
│ │ Online Halal Store                   │ │
│ │ ¥1,350                               │ │
│ │ [View Receipt] [Shop Here]           │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Frequently Bought Items

```
┌──────────────────────────────────────────┐
│ [←] Frequently Bought                    │
├──────────────────────────────────────────┤
│ Items you purchase regularly             │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Chicken Breast 1kg             │ │
│ │ Bought 12 times · Avg ¥1,150         │ │
│ │ Last: Jan 25 @ Halal Mart            │ │
│ │ [View History] [Buy Again]           │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Beef 500g                      │ │
│ │ Bought 5 times · Avg ¥1,200          │ │
│ │ Last: Jan 28 @ Halal Mart            │ │
│ │ [View History] [Buy Again]           │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Basmati Rice 5kg                     │ │
│ │ Bought 3 times · Avg ¥1,800          │ │
│ │ Last: Dec 15 @ Muslim Grocers        │ │
│ │ [View History] [Buy Again]           │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Product Page Integration

```
┌──────────────────────────────────────────┐
│ [←] Halal Beef 500g              [♡]     │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │         [Product Image]              │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ¥1,180                                   │
│ Halal Mart Shibuya                       │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 📊 Your History                      │ │
│ │ You've bought this 5 times           │ │
│ │ Your best: ¥1,100 (Dec 20)           │ │
│ │ [View Full History]                  │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [Add to Cart]                            │
└──────────────────────────────────────────┘
```

---

## Data Model

```
PersonalPriceHistory (view/aggregate from PurchaseRecord)
├── user_id: FK → User
├── item_id: FK → Item (matched product)
├── merchant_id: FK → Merchant
├── price: decimal
├── quantity: int
├── purchased_at: timestamp
├── source_order_id: FK → Order or POSTransaction

FrequentItem (computed/cached)
├── user_id: FK → User
├── item_id: FK → Item
├── purchase_count: int
├── avg_price: decimal
├── min_price: decimal
├── max_price: decimal
├── last_purchased_at: timestamp
├── last_merchant_id: FK → Merchant
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/purchases/items/{item_id}` | Get your price history for an item |
| `GET` | `/api/v1/purchases/frequent` | Get your frequently bought items |

### Query Parameters

```
GET /api/v1/purchases/items/{item_id}?
  limit=20
  &offset=0

GET /api/v1/purchases/frequent?
  min_count=3
  &limit=10
```

---

## Privacy & Data

- Price history is **strictly personal** — only your own purchases
- No aggregation across users
- No exposure of pricing data to merchants or other consumers
- Aligns with expense tracking in [[purchase-history]]

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Users viewing item price history | > 20% of active users |
| "Buy Again" clicks from history | > 10% conversion |
| Frequently bought items engagement | > 15% of users |

---

## Future Considerations

Post-MVP, with merchant opt-in and proper incentive design:
- **Merchant Promotions:** Merchants can offer personalized deals to returning customers
- **Restock Reminders:** "You usually buy this every 2 weeks — time to restock?"
- **Opt-in Price Alerts:** Merchants can notify past buyers of sales (with user consent)

---

## Dependencies

- [[purchase-history]] — Source data for personal price tracking
- [[marketplace]] — Product pages with history integration

---

#halava #feature #price-history #consumer #personal-finance
