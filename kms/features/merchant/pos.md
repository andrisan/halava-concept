# POS (Point of Sale)

> **Capability:** Point of Sale
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[restaurant-ops]] · [[inventory]] · [[onboarding]]

**v1.1 Enhancement:**
- **Advanced POS** — Tables, split bills, modifiers support

---

## Definition

The **POS (Point of Sale)** is Halava's in-store transaction system. It enables merchants to register sales, generate receipts, manage inventory, and optionally link transactions to customer accounts for unified purchase history.

**Core value proposition:**
- Merchants process in-store sales with a modern, tablet-friendly interface
- Inventory syncs between online and in-store channels
- Consumers get unified expense tracking across all purchases

---

## How It Works

### For Merchants (Cashier)

1. **Open** POS interface on tablet/desktop
2. **Add items** via search, barcode scan, or category grid
3. **Build transaction** (quantities, discounts if applicable)
4. **Link customer** (optional: scan customer's QR code)
5. **Complete payment** (cash, card, or other)
6. **Generate receipt** (digital and/or paper)

### For Consumers (Optional)

1. **Show QR code** from Halava app at checkout
2. **Cashier scans** to link transaction
3. **Receipt appears** in unified purchase history
4. **Track expenses** across all halal spending

### Quota System

> See [[monetization#4.1 POS Transaction Top-ups]]

- Free tier: 300 transactions/month
- Overage: Top-up bundles (100 for ¥300, 300 for ¥750, 500 for ¥1,000)
- Offline transactions sync when online

---

## User Journey

### Cashier: Process In-Store Sale

```
POS Main Screen → Add items (scan/search/tap)
  → Cart builds on right panel
  → [Checkout]
  → Payment Selection:
    ○ Cash   ○ Card   ○ Other
  → "Link to customer?" → [Scan QR] or [Skip]
  → [Complete Sale]
  → Receipt: [Print] [Email] [Done]
  → Transaction recorded → Inventory updated
```

### Customer: Link Purchase to Account

```
At Checkout → Cashier: "Save receipt digitally?"
  → Open Halava App → Profile → [My QR Code]
  → Show QR to cashier
  → Cashier scans
  → Transaction linked
  → Appears in Purchase History
```

### Offline Flow

```
No Internet → POS continues working (local-first)
  → Transactions stored in IndexedDB
  → "Offline mode" indicator shown
  → When online → Auto-sync to server
  → Inventory reconciled
```

---

## UI/UX Specification

> **Template Support:** Desktop only — POS is not available on mobile devices (see [[pages-navigation-ux-spec#1. Dual-Template Architecture]])

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **POS Main** | `/pos` | Transaction interface |
| **Transaction History** | `/pos/transactions` | Today's transactions |
| **Quota Status** | `/pos/quota` | Usage and top-up |
| **Prepared Orders** | `/pos/prepared-orders` | Orders awaiting payment |

---

### Desktop Template

#### POS Main Layout (Tablet/Desktop)

```
┌─────────────────────────────────────────────────────────────────┐
│ 🟢 Online │ Halal Mart POS │ Today: ¥45,200 (23 txn) │ [≡]    │
├─────────────────────────────────────────────────────────────────┤
│                           │                                     │
│  ┌─────────────────────┐  │   Current Transaction               │
│  │ 🔍 Search products  │  │   ─────────────────────────         │
│  └─────────────────────┘  │   Halal Beef 500g      ¥1,200 × 2  │
│                           │   Lamb Chops 300g        ¥980 × 1  │
│  ┌─────┐ ┌─────┐ ┌─────┐  │   Sambal Sauce           ¥350 × 1  │
│  │Meat │ │Grocery│ │Sauce│  │                                   │
│  └─────┘ └─────┘ └─────┘  │   ─────────────────────────         │
│                           │   Subtotal:            ¥3,730      │
│  ┌─────┐ ┌─────┐ ┌─────┐  │   Tax (10%):             ¥373      │
│  │Beef │ │Lamb │ │Chick│  │   ─────────────────────────         │
│  │500g │ │300g │ │Breast│  │   TOTAL:              ¥4,103      │
│  │¥1200│ │¥980 │ │¥650 │  │                                     │
│  └─────┘ └─────┘ └─────┘  │   ┌─────────────────────────────┐  │
│                           │   │      [ Checkout ¥4,103 ]     │  │
│  ┌─────┐ ┌─────┐ ┌─────┐  │   └─────────────────────────────┘  │
│  │...  │ │...  │ │...  │  │                                     │
│  └─────┘ └─────┘ └─────┘  │   [Clear Cart]                      │
│                           │                                     │
└─────────────────────────────────────────────────────────────────┘
```

### Checkout Modal

```
┌───────────────────────────────────┐
│         Complete Sale             │
├───────────────────────────────────┤
│                                   │
│  Total: ¥4,103                    │
│                                   │
│  Payment Method:                  │
│  ┌────────┐ ┌────────┐ ┌───────┐ │
│  │  Cash  │ │  Card  │ │ Other │ │
│  └────────┘ └────────┘ └───────┘ │
│                                   │
│  Link to Customer:                │
│  ┌─────────────────────────────┐ │
│  │   [ 📷 Scan Customer QR ]   │ │
│  └─────────────────────────────┘ │
│  or [Skip - Guest checkout]      │
│                                   │
├───────────────────────────────────┤
│  [Cancel]        [Complete Sale]  │
└───────────────────────────────────┘
```

### Receipt Options

```
┌───────────────────────────────────┐
│        Sale Complete ✓            │
├───────────────────────────────────┤
│  Transaction #: TXN-2026-0142     │
│  Total: ¥4,103                    │
│  Payment: Cash                    │
│  Customer: Linked ✓               │
│                                   │
│  ┌─────────┐  ┌─────────────────┐ │
│  │  Print  │  │  Email Receipt  │ │
│  └─────────┘  └─────────────────┘ │
│                                   │
│  [ Done - Next Customer ]         │
└───────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                      POSTransaction                              │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  transaction_number  VARCHAR(30) NOT NULL                       │
│  staff_id        UUID FK → User (cashier)                       │
│  consumer_id     UUID FK → User (nullable, if QR linked)        │
│  items           JSONB (item snapshots with prices, qty)        │
│  subtotal        DECIMAL(10,2) NOT NULL                         │
│  discount_amount DECIMAL(10,2) DEFAULT 0                        │
│  tax_amount      DECIMAL(10,2) DEFAULT 0                        │
│  total           DECIMAL(10,2) NOT NULL                         │
│  payment_method  ENUM(cash, card, other)                        │
│  payment_details JSONB (change given, card type, etc.)          │
│  synced          BOOLEAN DEFAULT false                          │
│  synced_at       TIMESTAMP                                      │
│  created_at      TIMESTAMP NOT NULL                             │
│  UNIQUE(merchant_id, transaction_number)                        │
└─────────────────────────────────────────────────────────────────┘
```

### Items JSONB Structure

```json
{
  "items": [
    {
      "item_id": "uuid",
      "name": "Halal Beef 500g",
      "quantity": 2,
      "unit_price": 1200,
      "total_price": 2400,
      "barcode": "4901234567890"
    }
  ]
}
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `pos_transaction` | `merchant_id, created_at DESC` | Transaction history |
| `pos_transaction` | `merchant_id, transaction_number` (unique) | Receipt lookup |
| `pos_transaction` | `consumer_id, created_at` | Linked purchases |
| `pos_transaction` | `synced, created_at` | Offline sync queue |

---

## API Endpoints

> Full API index: [[api-spec#7. POS Module]]

### POST /v1/pos/transactions

Create a new POS transaction.

```json
// Request
{
  "items": [
    {
      "item_id": "uuid",
      "quantity": 2,
      "unit_price": 1200
    },
    {
      "item_id": "uuid",
      "quantity": 1,
      "unit_price": 980
    }
  ],
  "payment_method": "cash",
  "payment_details": {
    "amount_tendered": 5000,
    "change_given": 620
  },
  "consumer_id": "uuid"  // Optional, if QR linked
}

// Response
{
  "id": "uuid",
  "transaction_number": "TXN-2026-0142",
  "total": 4380,
  "created_at": "2026-01-28T14:32:00+09:00"
}
```

### GET /v1/pos/transactions

List POS transactions.

```
Query Parameters:
  date          date      Filter by date (YYYY-MM-DD)
  from          datetime  Start datetime
  to            datetime  End datetime
  payment_method string   Filter: cash, card, other
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "transactions": [
    {
      "id": "uuid",
      "transaction_number": "TXN-2026-0142",
      "total": 4380,
      "payment_method": "cash",
      "items_count": 3,
      "consumer_linked": true,
      "created_at": "2026-01-28T14:32:00+09:00"
    }
  ],
  "total": 23,
  "daily_total": 45200
}
```

### GET /v1/pos/transactions/{id}

Get transaction details.

```json
// Response
{
  "id": "uuid",
  "transaction_number": "TXN-2026-0142",
  "items": [
    {
      "item_id": "uuid",
      "name": "Halal Beef 500g",
      "quantity": 2,
      "unit_price": 1200,
      "total_price": 2400
    }
  ],
  "subtotal": 3980,
  "tax_amount": 400,
  "total": 4380,
  "payment_method": "cash",
  "payment_details": {
    "amount_tendered": 5000,
    "change_given": 620
  },
  "consumer": { "id": "uuid", "name": "Ahmad K." },
  "staff": { "id": "uuid", "name": "Aisha" },
  "created_at": "2026-01-28T14:32:00+09:00"
}
```

### GET /v1/pos/quota

Get POS transaction quota status.

```json
// Response
{
  "plan_limit": 300,
  "used": 245,
  "remaining": 55,
  "topup_available": 100,
  "period_ends": "2026-02-01"
}
```

### POST /v1/pos/quota/topup

Purchase additional transaction quota.

```json
// Request
{
  "bundle": "100"  // 100, 300, or 500
}

// Response
{
  "topup_amount": 100,
  "price": 300,
  "new_available": 155
}
```

### POST /v1/pos/sync

Sync offline transactions to server.

```json
// Request
{
  "transactions": [
    {
      "local_id": "local-uuid-1",
      "items": [...],
      "payment_method": "cash",
      "created_at": "2026-01-28T14:32:00+09:00"
    }
  ]
}

// Response
{
  "synced": 5,
  "failed": 0,
  "mappings": [
    { "local_id": "local-uuid-1", "server_id": "uuid" }
  ]
}
```

---

## Offline Architecture

> See [[architecture#POS Offline Architecture]]

### Sync Strategy

1. **Local-first:** All operations work offline via IndexedDB
2. **Optimistic UI:** Transactions complete immediately
3. **Background sync:** ServiceWorker syncs when online
4. **Conflict resolution:**
   - Stock quantities: Merchant review required
   - Transaction data: Append-only, no conflicts
   - Product metadata: Last-write-wins

### Offline Indicators

| State | Indicator | Behavior |
|-------|-----------|----------|
| **Online** | 🟢 Green dot | Real-time sync |
| **Offline** | 🟠 Orange dot | Local storage |
| **Syncing** | 🔄 Spinner | Uploading queued txns |
| **Sync Error** | 🔴 Red dot | Retry with alert |

---

## Prepared Orders Queue

For [[restaurant-ops]] "Pay at Counter" orders:

```
┌─────────────────────────────────────────────────────────────────┐
│ 📋 Prepared Orders                            [3 pending]       │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ #ORD-0087 │ Table 5 │ ¥2,450 │ Dine-in │ [ Take Payment ]  │ │
│ └─────────────────────────────────────────────────────────────┘ │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ #ORD-0088 │ Counter │ ¥1,200 │ Takeaway│ [ Take Payment ]  │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

Clicking "Take Payment" opens checkout with pre-filled items.

---

## Advanced POS

> **Version:** v1.1

Advanced POS extends the basic POS with restaurant-specific features for table service, split payments, and modifier support.

### Table Management

```
┌──────────────────────────────────────────────────────────────┐
│ Tables                                         [Floor Plan]  │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐         │
│  │ Table 1 │  │ Table 2 │  │ Table 3 │  │ Table 4 │         │
│  │ 🟢 Open │  │ 🟡 Active│  │ 🟡 Active│  │ 🟢 Open │         │
│  │         │  │ ¥3,200  │  │ ¥5,400  │  │         │         │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘         │
│                                                              │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐         │
│  │ Table 5 │  │ Table 6 │  │ Table 7 │  │ Table 8 │         │
│  │ 🔴 Rsrvd │  │ 🟢 Open │  │ 🟡 Active│  │ 🟢 Open │         │
│  │ 19:00   │  │         │  │ ¥2,100  │  │         │         │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘         │
│                                                              │
│ Legend: 🟢 Open  🟡 Active (has orders)  🔴 Reserved         │
└──────────────────────────────────────────────────────────────┘
```

### Table Actions

| Action | Description |
|--------|-------------|
| **Open Table** | Start new session, assign server |
| **Add Items** | Add menu items to table's bill |
| **View Bill** | See running total |
| **Transfer** | Move items/table to another |
| **Close Table** | Process payment, clear table |

### Split Bills

Divide a table's bill among multiple payers:

```
┌──────────────────────────────────────────┐
│ Split Bill - Table 5                [×]  │
├──────────────────────────────────────────┤
│ Total: ¥8,400                            │
│                                          │
│ Split Method:                            │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐  │
│ │ Equal    │ │ By Item  │ │ Custom   │  │
│ └──────────┘ └──────────┘ └──────────┘  │
│                                          │
│ Number of ways: [2] [3] [4] [Custom]     │
│                                          │
│ Split Preview (3 ways):                  │
│ ├── Person 1: ¥2,800                    │
│ ├── Person 2: ¥2,800                    │
│ └── Person 3: ¥2,800                    │
│                                          │
│ [Pay Person 1] [Pay All Together]        │
└──────────────────────────────────────────┘
```

### Split Methods

| Method | Description |
|--------|-------------|
| **Equal** | Divide total equally |
| **By Item** | Each person pays for their items |
| **By Amount** | Custom amounts per person |
| **By Percentage** | Custom percentage split |

### Modifiers in POS

When adding items with modifiers:

```
┌──────────────────────────────────────────┐
│ Beef Rendang                       ¥1,500│
├──────────────────────────────────────────┤
│                                          │
│ Spice Level *                            │
│ ○ Mild  ● Medium  ○ Hot (+¥100)         │
│                                          │
│ Add-ons                                  │
│ ☐ Extra rice (+¥200)                    │
│ ☑ Egg (+¥150)                           │
│                                          │
│ Special Instructions                     │
│ ┌──────────────────────────────────────┐│
│ │ No peanuts                           ││
│ └──────────────────────────────────────┘│
│                                          │
│ Quantity: [-] 1 [+]                      │
│                                          │
│ Item Total: ¥1,650                       │
├──────────────────────────────────────────┤
│ [Cancel]                    [Add to Bill]│
└──────────────────────────────────────────┘
```

### Course Firing

Control when items are sent to kitchen:

```
Table 5 Bill:
├── Course 1 (Sent to kitchen)
│   ├── Satay × 2
│   └── Soup × 2
├── Course 2 (Hold)
│   ├── Beef Rendang × 2
│   └── Nasi Goreng × 2
└── Course 3 (Hold)
    └── Dessert × 2

[Fire Course 2] ← Sends to kitchen when ready
```

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Transaction completion | < 30 seconds |
| Offline reliability | 99.9% |
| Sync latency (online) | < 2 seconds |
| Customer link rate | > 30% |

---

## Dependencies

- [[web-app-spec#Capability Lifecycle]] — POS must be enabled
- [[marketplace]] — Shared inventory
- [[monetization#4.1 POS Transaction Top-ups]] — Transaction quotas

---

#halava #feature #pos #merchant
