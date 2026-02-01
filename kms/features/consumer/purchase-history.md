# Purchase History (Expense Tracking)

> **Feature Type:** Consumer (Always Available)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[pos]] · [[restaurant-ops]] · [[directory]]

---

## Definition

**Purchase History** is Halava's unified expense tracking and price comparison system. It aggregates all consumer transactions — online orders, in-store purchases (when linked), and restaurant orders — into a single view for personal finance management.

**Core value proposition:**
- Track halal spending across all channels in one place
- Compare prices for the same product across merchants
- Budget and analyze personal halal consumption
- Digital receipt storage (no more paper receipts)

---

## How It Works

### Transaction Sources

| Source | Auto-Recorded | Linkable |
|--------|---------------|----------|
| Online orders (Marketplace) | ✅ Yes | — |
| Restaurant orders | ✅ Yes | — |
| Group purchase contributions | ✅ Yes | — |
| In-store POS purchases | ❌ No | ✅ Via QR code |

### Data Captured

Each purchase record includes:
- Date, time, and merchant
- Item breakdown (products, quantities, prices)
- Payment method and total
- Category tags (groceries, dining, etc.)
- Optional: notes or receipt photos

---

## User Journey

### Consumer: View Purchase History

```
Profile → Purchase History
  → View all past purchases (newest first)
  → Filter:
    - Date range (This month, Last 30 days, Custom)
    - Category (Groceries, Dining, Shopping)
    - Merchant
  → Tap transaction → Full receipt details
  → [Export] for personal records
```

### Consumer: Track Expenses

```
Purchase History → Insights tab
  → Monthly spending breakdown (chart)
  → Category distribution (pie chart)
  → Top merchants by spend
  → Month-over-month comparison
  → Set budget alert (optional)
```

### Consumer: Compare Prices

```
Purchase History → Search "halal beef"
  → View all past purchases of this item
  → See prices across different merchants:
    • Halal Mart: ¥1,200 (Jan 15)
    • Muslim Grocers: ¥1,100 (Dec 20)
    • Online Shop: ¥1,350 (Nov 5)
  → "Best price was at Muslim Grocers"
  → [View Merchant] → Shop again
```

### Consumer: Link In-Store Purchase

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

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Purchase History** | `/purchases` | All transactions |
| **Transaction Detail** | `/purchases/{id}` | Full receipt |
| **Insights** | `/purchases/insights` | Spending analytics |
| **Price Compare** | `/purchases/compare` | Historical prices |
| **My QR Code** | `/profile/qr` | For in-store linking |

### Purchase History Layout

```
┌──────────────────────────────────────────┐
│ Purchase History                   [🔍]  │
├──────────────────────────────────────────┤
│ [All] [Groceries] [Dining] [Shopping]   │
│                                          │
│ This Month: ¥45,200                      │
│ ▼ January 2026                           │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 28 · Halal Mart Shibuya         │ │
│ │ 🛒 Groceries · 5 items              │ │
│ │                           ¥3,450    │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 26 · Halal Bistro               │ │
│ │ 🍽️ Dining · Dine-in                 │ │
│ │                           ¥2,900    │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 24 · Muslim Grocers (POS)       │ │
│ │ 🛒 Groceries · In-store             │ │
│ │                           ¥1,850    │ │
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
│ Spending Insights                        │
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
│ │ 🛒 Groceries: 55% (¥24,860)          │ │
│ │ 🍽️ Dining: 35% (¥15,820)             │ │
│ │ 🛍️ Shopping: 10% (¥4,520)            │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Top Merchants:                           │
│ 1. Halal Mart Shibuya — ¥12,450         │
│ 2. Halal Bistro — ¥8,200                │
│ 3. Muslim Grocers — ¥6,100              │
└──────────────────────────────────────────┘
```

### Price Comparison

```
┌──────────────────────────────────────────┐
│ Price Compare                            │
├──────────────────────────────────────────┤
│ 🔍 Search: "halal beef"                  │
│                                          │
│ Halal Beef 500g                          │
│ Your purchase history:                   │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ ★ Best Price                         │ │
│ │ Muslim Grocers · ¥1,100              │ │
│ │ Dec 20, 2025                         │ │
│ │ [Shop Now]                           │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Mart Shibuya · ¥1,200          │ │
│ │ Jan 28, 2026                         │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Online Halal Store · ¥1,350          │ │
│ │ Nov 5, 2025                          │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Price Range: ¥1,100 - ¥1,350            │
│ You've bought this 5 times               │
└──────────────────────────────────────────┘
```

---

## Data Model

```
PurchaseRecord (view/aggregate)
├── id: UUID
├── consumer_id: FK → User
├── merchant_id: FK → Merchant
├── source_type: enum (order, pos_transaction, group_purchase)
├── source_id: UUID (FK to Order or POSTransaction)
│
├── merchant_name: string (denormalized)
├── items: JSONB
│   └── [{ name, quantity, unit_price, subtotal }]
├── subtotal: decimal
├── tax_amount: decimal
├── total: decimal
├── payment_method: string
│
├── category: enum (groceries, dining, shopping, other)
├── tags: string[] (user-defined)
├── notes: text (optional)
│
├── created_at: timestamp

PriceHistory (for comparison)
├── id: UUID
├── item_id: FK → Item
├── merchant_id: FK → Merchant
├── price: decimal
├── recorded_at: timestamp
├── source_type: enum (catalog, purchase)
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/purchases` | List user's purchases |
| `GET` | `/api/v1/purchases/{id}` | Get purchase details |
| `GET` | `/api/v1/purchases/insights` | Get spending analytics |
| `GET` | `/api/v1/purchases/compare` | Price comparison search |
| `GET` | `/api/v1/profile/qr` | Get user's linking QR code |

### Query Parameters

```
GET /api/v1/purchases?
  from=2026-01-01
  &to=2026-01-31
  &category=groceries
  &merchant_id=xxx
  &limit=20
  &offset=0
```

---

## Privacy & Data

- Purchase history is **private** to each consumer
- Merchants see their own transaction data, not consumer's full history
- Price comparison data is anonymized/aggregated
- Export available in CSV/JSON for personal use
- Data retention follows platform privacy policy

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Purchase history views/month | > 3 per active user |
| QR linking rate at POS | > 30% |
| Price comparison usage | > 20% of users |
| Insights page engagement | > 15% of users |

---

## Dependencies

- [[marketplace]] — Online order records
- [[pos]] — In-store transaction linking
- [[restaurant-ops]] — Restaurant order records
- [[group-purchase]] — Group purchase contributions
- [[price-comparison]] — Personal price history feature

---

#halava #feature #purchase-history #consumer #expense-tracking
