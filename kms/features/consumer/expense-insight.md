# Expense Insight

> **Feature Type:** Consumer App (App Platform)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[pos]] · [[group-purchase]]
>
> **Access:** Installed via App Store at `/apps` → runs at `/app/expense-insight`

---

## Definition

**Expense Insight** is Halava's consumer-facing personal finance toolkit. It provides unified tools for tracking halal spending, analyzing purchase patterns, and making informed buying decisions based on personal price history.

**Core value proposition:**
- Track spending across online orders, in-store purchases, and dining
- Personal price history to find your best deals
- Budgeting insights and spending analytics
- Digital receipt storage (no more paper receipts)

> **Design Note:** This feature intentionally avoids real-time cross-merchant price comparison to maintain healthy merchant relationships. Halava supports all merchants equally rather than driving a race-to-the-bottom on pricing.

---

## How It Works

### Transaction Sources

| Source | Auto-Recorded | Linkable |
|--------|---------------|----------|
| Online orders (Marketplace) | Yes | — |
| Restaurant orders | Yes | — |
| Group purchase contributions | Yes | — |
| In-store POS purchases | No | Via QR code |

### Data Captured

Each purchase record includes:
- Date, time, and merchant
- Item breakdown (products, quantities, prices)
- Payment method and total
- Category tags (groceries, dining, etc.)
- Optional: notes or receipt photos

### What Personal Price History Does NOT Do

- ❌ Compare prices across merchants in real-time
- ❌ Show other consumers' purchase prices
- ❌ Highlight "best price" among current merchant offerings
- ❌ Alert when a merchant lowers prices

---

## User Journeys

### View Purchase History

```
Profile → Expenses → Purchases
  → View all past purchases (newest first)
  → Filter:
    - Date range (This month, Last 30 days, Custom)
    - Category (Groceries, Dining, Shopping)
    - Merchant
  → Tap transaction → Full receipt details
  → [Export] for personal records
```

### Track Spending & Budget

```
Profile → Expenses → Insights
  → Monthly spending breakdown (chart)
  → Category distribution (pie chart)
  → Top merchants by spend
  → Month-over-month comparison
  → Set budget alert (optional)
```

### View Item Price History

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

### Spot Spending Trends

```
Profile → Expenses → Frequently Bought
  → "Halal Chicken Breast 1kg"
    • Bought 8 times
    • Average price: ¥1,180
    • Range: ¥1,050 - ¥1,350
  → Helps budget for next purchase
```

### Repurchase from Product Page

```
Product Page (Halal Beef 500g) → [Your History]
  → "You've bought this 5 times"
  → Last purchase: ¥1,200 (Jan 28)
  → Your best price: ¥1,100 (Dec 20 @ Muslim Grocers)
  → Current price here: ¥1,180
  → User decides whether to buy
```

### Link In-Store Purchase

```
At Checkout → Cashier: "Save receipt digitally?"
  → Open Halava App → Profile → [My QR Code]
  → Show QR to cashier
  → Cashier scans
  → Transaction linked to account
  → Appears in Purchase History instantly
```

---

## UI/UX Specification

> **Template Support:** Mobile + Desktop (see [[pages-navigation-ux-spec#1. Dual-Template Architecture]])

### Screens

| Screen | Path | Mobile | Desktop |
|--------|------|--------|---------|
| **Purchases** | `/app/expense-insight` | Full-screen list | Sidebar or main content |
| **Transaction Detail** | `/app/expense-insight` (modal) | Full-screen receipt | Modal overlay |
| **Insights** | `/app/expense-insight` (tab) | Full-screen charts | Dashboard cards |
| **Price History** | `/app/expense-insight` (tab) | Full-screen list | Table view |
| **Frequently Bought** | `/app/expense-insight` (tab) | Card list | Grid view |
| **My QR Code** | `/profile/qr` | Full-screen QR | Modal |

---

### Mobile Template

#### Navigation (Mobile)

Accessible from Profile tab in bottom navigation:

```
Profile → [Expense Insight]
  → Purchases
  → Insights
  → My Prices
  → Frequently Bought
```

#### Purchase History (Mobile)

```
┌──────────────────────────────────────────┐
│ [←] Expense Insight              [🔍]   │
├──────────────────────────────────────────┤
│ This Month: ¥45,200  ▲ 12%              │
│ Budget: ¥60,000 · 75% used              │
├──────────────────────────────────────────┤
│ [Purchases] [Insights] [My Prices]       │
├──────────────────────────────────────────┤
│ [All] [Groceries] [Dining] [Shopping]   │
│                                          │
│ ▼ January 2026                           │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 28 · Halal Mart Shibuya         │ │
│ │ Groceries · 5 items          ¥3,450 │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 26 · Halal Bistro               │ │
│ │ Dining · Dine-in             ¥2,900 │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 24 · Muslim Grocers (POS)       │ │
│ │ Groceries · In-store         ¥1,850 │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ▼ December 2025                          │
│ ...                                      │
└──────────────────────────────────────────┘
```

### Transaction Detail

```
┌──────────────────────────────────────────┐
│ [←] Receipt                     [Share]  │
├──────────────────────────────────────────┤
│ Halal Mart Shibuya                       │
│ January 28, 2026 · 2:45 PM              │
│ Transaction #: TXN-2026-0142             │
├──────────────────────────────────────────┤
│ Items:                                   │
│ Halal Beef 500g          ¥1,200 × 2     │
│ Lamb Chops 300g            ¥980 × 1     │
│ Sambal Sauce               ¥350 × 1     │
│ ─────────────────────────────────────── │
│ Subtotal:                     ¥3,730    │
│ Tax (10%):                      ¥373    │
│ ─────────────────────────────────────── │
│ Total:                        ¥4,103    │
│                                          │
│ Payment: Cash (In-store)                │
├──────────────────────────────────────────┤
│ [View Merchant] [Buy Again]              │
└──────────────────────────────────────────┘
```

### Insights Dashboard

```
┌──────────────────────────────────────────┐
│ [←] Spending Insights           [Export] │
├──────────────────────────────────────────┤
│ January 2026                             │
│                                          │
│ Total Spent: ¥45,200                     │
│ vs Last Month: ▲ 12%                     │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ [Bar Chart: Weekly Spending]         │ │
│ │ Week 1: ¥12,000                      │ │
│ │ Week 2: ¥8,500                       │ │
│ │ Week 3: ¥15,200                      │ │
│ │ Week 4: ¥9,500                       │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ By Category:                             │
│ ┌──────────────────────────────────────┐ │
│ │ [Pie Chart]                          │ │
│ │ Groceries: 55% (¥24,860)             │ │
│ │ Dining: 35% (¥15,820)                │ │
│ │ Shopping: 10% (¥4,520)               │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Top Merchants:                           │
│ 1. Halal Mart Shibuya — ¥12,450         │
│ 2. Halal Bistro — ¥8,200                │
│ 3. Muslim Grocers — ¥6,100              │
│                                          │
│ [Set Budget Goal]                        │
└──────────────────────────────────────────┘
```

### Item Price History

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

### Desktop Template

#### Expense Dashboard (Desktop)

Full dashboard view with sidebar navigation:

```
┌────────────────────────────────────────────────────────────────────────────────┐
│ [Logo]  🔍 Search...                           [Location ▼]  [Profile]         │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│  ┌──────────────┐  ┌────────────────────────────────────────────────────────┐  │
│  │ PROFILE      │  │ Expense Insight                                       │  │
│  │ ───────────  │  │                                                        │  │
│  │ My Orders    │  │  This Month: ¥45,200  ▲ 12%    Budget: ¥60,000 (75%)  │  │
│  │ Saved Items  │  │                                                        │  │
│  │ ► Expenses   │  │  [Purchases] [Insights] [My Prices] [Frequent]         │  │
│  │ Settings     │  │  ─────────────────────────────────────────────────     │  │
│  │              │  │                                                        │  │
│  │              │  │  [All] [Groceries] [Dining] [Shopping]  [Export ▼]     │  │
│  │              │  │                                                        │  │
│  │              │  │  ┌─────────────────────────────────────────────────┐   │  │
│  │              │  │  │ Jan 28 · Halal Mart Shibuya                    │   │  │
│  │              │  │  │ Groceries · 5 items                    ¥3,450  │   │  │
│  │              │  │  ├─────────────────────────────────────────────────┤   │  │
│  │              │  │  │ Jan 26 · Halal Bistro                          │   │  │
│  │              │  │  │ Dining · Dine-in                       ¥2,900  │   │  │
│  │              │  │  └─────────────────────────────────────────────────┘   │  │
│  │              │  │                                                        │  │
│  └──────────────┘  └────────────────────────────────────────────────────────┘  │
│                                                                                │
└────────────────────────────────────────────────────────────────────────────────┘
```

#### Insights Dashboard (Desktop)

```
┌────────────────────────────────────────────────────────────────────────────────┐
│  Spending Insights · January 2026                                  [Export]    │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│  ┌─────────────────────────────┐  ┌─────────────────────────────────────────┐  │
│  │ Total Spent                 │  │ Weekly Spending                         │  │
│  │ ¥45,200                     │  │ [Bar Chart]                             │  │
│  │ ▲ 12% vs last month         │  │ W1: ████████ ¥12,000                   │  │
│  └─────────────────────────────┘  │ W2: █████ ¥8,500                       │  │
│                                    │ W3: ██████████ ¥15,200                │  │
│  ┌─────────────────────────────┐  │ W4: ██████ ¥9,500                      │  │
│  │ By Category (Pie)           │  └─────────────────────────────────────────┘  │
│  │ Groceries: 55%              │                                               │
│  │ Dining: 35%                 │  ┌─────────────────────────────────────────┐  │
│  │ Shopping: 10%               │  │ Top Merchants                           │  │
│  └─────────────────────────────┘  │ 1. Halal Mart — ¥12,450                 │  │
│                                    │ 2. Halal Bistro — ¥8,200                │  │
│                                    └─────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                     PurchaseRecord                               │
│             (view/aggregate from Order + POSTransaction)         │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  consumer_id     UUID FK → User                                 │
│  merchant_id     UUID FK → Merchant                             │
│  source_type     ENUM(order, pos, group_purchase)               │
│  source_id       UUID NOT NULL (FK → Order or POSTransaction)   │
│  items           JSONB (item details snapshot)                  │
│  subtotal        DECIMAL(10,2) NOT NULL                         │
│  tax_amount      DECIMAL(10,2) DEFAULT 0                        │
│  total           DECIMAL(10,2) NOT NULL                         │
│  category        ENUM(groceries, dining, shopping, other)       │
│  tags            TEXT[]                                         │
│  notes           TEXT                                           │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                  PersonalPriceHistory                            │
│                     (view/aggregate)                             │
├─────────────────────────────────────────────────────────────────┤
│  user_id         UUID FK → User                                 │
│  item_id         UUID FK → Item                                 │
│  merchant_id     UUID FK → Merchant                             │
│  price           DECIMAL(10,2) NOT NULL                         │
│  quantity        INT NOT NULL                                   │
│  purchased_at    TIMESTAMP NOT NULL                             │
│  source_order_id UUID (FK → Order or POSTransaction)            │
│  PRIMARY KEY (user_id, item_id, purchased_at)                   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                     FrequentItem                                 │
│                    (computed/cached)                             │
├─────────────────────────────────────────────────────────────────┤
│  user_id         UUID FK → User                                 │
│  item_id         UUID FK → Item                                 │
│  purchase_count  INT NOT NULL                                   │
│  avg_price       DECIMAL(10,2) NOT NULL                         │
│  min_price       DECIMAL(10,2) NOT NULL                         │
│  max_price       DECIMAL(10,2) NOT NULL                         │
│  last_purchased_at  TIMESTAMP NOT NULL                          │
│  last_merchant_id   UUID FK → Merchant                          │
│  PRIMARY KEY (user_id, item_id)                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                     SpendingInsight                              │
│                    (computed/cached)                             │
├─────────────────────────────────────────────────────────────────┤
│  user_id         UUID FK → User                                 │
│  period          VARCHAR(10) NOT NULL (e.g., '2026-01')         │
│  total_spent     DECIMAL(12,2) NOT NULL                         │
│  category_breakdown  JSONB                                      │
│  top_merchants   JSONB                                          │
│  transaction_count  INT NOT NULL                                │
│  computed_at     TIMESTAMP NOT NULL                             │
│  PRIMARY KEY (user_id, period)                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                      BudgetGoal                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User                                 │
│  period          ENUM(monthly, weekly)                          │
│  amount          DECIMAL(10,2) NOT NULL                         │
│  category        VARCHAR(50) (nullable for overall)             │
│  alert_threshold_percent  INT DEFAULT 80                        │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `purchase_record` | `consumer_id, created_at DESC` | Expense list |
| `purchase_record` | `consumer_id, category, created_at` | Category filtering |
| `personal_price_history` | `user_id, item_id, purchased_at DESC` | Item price history |
| `frequent_item` | `user_id, purchase_count DESC` | Top frequently bought |
| `spending_insight` | `user_id, period` (unique) | Quick insight lookup |
| `budget_goal` | `user_id, category` | Budget lookup |

---

## API Endpoints

> Full API index: [[api-spec#5.3 Expense Insight]]

### GET /v1/consumer/expenses/purchases

List user's purchases.

```
Query Parameters:
  from        string    Start date (YYYY-MM-DD)
  to          string    End date (YYYY-MM-DD)
  category    string    Filter: groceries, dining, shopping, other
  merchant_id uuid      Filter by merchant
  limit       int       Results per page (default: 20)
  offset      int       Pagination offset
```

```json
// Response
{
  "purchases": [
    {
      "id": "uuid",
      "merchant": { "name": "Halal Mart" },
      "total": 4103,
      "category": "groceries",
      "item_count": 5,
      "created_at": "2026-01-28T14:32:00Z"
    }
  ],
  "total": 24
}
```

### GET /v1/consumer/expenses/purchases/{id}

Get purchase details (full receipt).

```json
// Response
{
  "id": "uuid",
  "merchant": { "id": "uuid", "name": "Halal Mart Shibuya" },
  "items": [
    { "name": "Halal Beef 500g", "quantity": 2, "unit_price": 1200, "total": 2400 }
  ],
  "subtotal": 3730,
  "tax_amount": 373,
  "total": 4103,
  "payment_method": "cash",
  "source_type": "pos",
  "created_at": "2026-01-28T14:32:00Z"
}
```

### GET /v1/consumer/expenses/purchases/export

Export purchases as CSV or JSON.

```
Query Parameters:
  from        string    Start date (YYYY-MM-DD)
  to          string    End date (YYYY-MM-DD)
  format      string    Export format: csv, json
```

### GET /v1/consumer/expenses/insights

Get spending analytics for a period.

```
Query Parameters:
  period      string    Period type: month, week
  date        string    Period date (YYYY-MM or YYYY-Www)
```

```json
// Response
{
  "period": "2026-01",
  "total_spent": 45200,
  "transaction_count": 24,
  "vs_previous": { "amount": 4800, "percent": 12 },
  "by_category": {
    "groceries": 24860,
    "dining": 15820,
    "shopping": 4520
  },
  "top_merchants": [
    { "id": "uuid", "name": "Halal Mart Shibuya", "amount": 12450 }
  ]
}
```

### GET /v1/consumer/expenses/prices/{item_id}

Get personal price history for an item.

```json
// Response
{
  "item": { "id": "uuid", "name": "Halal Beef 500g" },
  "summary": {
    "purchase_count": 5,
    "total_spent": 6000,
    "avg_price": 1200,
    "min_price": 1100,
    "max_price": 1350
  },
  "history": [
    { "date": "2026-01-28", "merchant": {...}, "price": 1200, "is_best_price": false }
  ]
}
```

### GET /v1/consumer/expenses/frequent

Get frequently bought items.

```
Query Parameters:
  min_count   int       Minimum purchase count (default: 3)
  limit       int       Max items (default: 10)
```

```json
// Response
{
  "items": [
    {
      "item": { "id": "uuid", "name": "Halal Chicken Breast 1kg" },
      "purchase_count": 12,
      "avg_price": 1150,
      "last_purchased_at": "2026-01-25"
    }
  ]
}
```

### GET /v1/consumer/expenses/budgets

Get budget goals.

```json
// Response
{
  "budgets": [
    {
      "id": "uuid",
      "period": "monthly",
      "amount": 60000,
      "category": null,
      "alert_threshold_percent": 80
    }
  ]
}
```

### PUT /v1/consumer/expenses/budgets

Create or update budget goal.

```json
// Request
{
  "period": "monthly",
  "amount": 60000,
  "category": null,
  "alert_threshold_percent": 80
}

// Response
{
  "id": "uuid",
  "created_at": "2026-01-28T10:00:00Z"
}
```

### DELETE /v1/consumer/expenses/budgets/{id}

Delete budget goal.

```json
// Response
{
  "message": "Budget deleted"
}
```

### GET /v1/consumer/qr

Get user's QR code for POS linking.

```json
// Response
{
  "qr_token": "eyJhbGciOiJIUzI1...",
  "expires_at": "2026-01-28T15:00:00Z"
}
```

---

## Privacy & Data

- All financial data is **strictly personal** — visible only to the account owner
- No cross-user price comparisons or data sharing
- Merchants see only their own transaction data
- Export available in CSV/JSON for personal use
- Data retention follows platform privacy policy

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Expense tracker views/month | > 3 per active user |
| QR linking rate at POS | > 30% |
| Price history usage | > 20% of users |
| "Buy Again" clicks from history | > 10% conversion |
| Frequently bought engagement | > 15% of users |
| Insights page engagement | > 15% of users |
| Users with budget set | > 25% |

---

## Future Considerations

Post-MVP, with merchant opt-in and proper incentive design:
- **Merchant Promotions:** Merchants can offer personalized deals to returning customers
- **Restock Reminders:** "You usually buy this every 2 weeks — time to restock?"
- **Opt-in Price Alerts:** Merchants can notify past buyers of sales (with user consent)

---

## Dependencies

- [[marketplace]] — Online order records
- [[pos]] — In-store transaction linking
- [[restaurant-ops]] — Restaurant order records
- [[group-purchase]] — Group purchase contributions

---

#halava #feature #expense-insight #consumer #personal-finance
