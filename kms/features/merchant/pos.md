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

> See [[monetization#POS Transaction Quota & Top-ups]]

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

### POS Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **POS Main** | `/merchant/pos` | Transaction interface |
| **Transaction History** | `/merchant/pos/history` | Today's transactions |
| **Quota Status** | `/merchant/pos/quota` | Usage and top-up |

### POS Main Layout (Tablet)

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

```
POSTransaction
├── id: UUID
├── transaction_number: string (TXN-YYYY-XXXX)
├── merchant_id: FK → Merchant
├── staff_id: FK → Staff (cashier)
├── consumer_id: FK → User (nullable, if linked)
│
├── items: JSONB
│   └── [{ item_id, name, quantity, unit_price, subtotal }]
├── subtotal: decimal
├── tax_amount: decimal
├── discount_amount: decimal
├── total: decimal
│
├── payment_method: enum (cash, card, other)
├── payment_status: enum (completed)
│
├── receipt_printed: boolean
├── receipt_emailed: boolean
│
├── synced: boolean (for offline)
├── created_at: timestamp
├── synced_at: timestamp (nullable)
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/v1/merchant/pos/transactions` | Create transaction |
| `GET` | `/api/v1/merchant/pos/transactions` | List transactions |
| `GET` | `/api/v1/merchant/pos/transactions/{id}` | Get transaction |
| `GET` | `/api/v1/merchant/pos/quota` | Get quota status |
| `POST` | `/api/v1/merchant/pos/quota/topup` | Purchase top-up |
| `POST` | `/api/v1/merchant/pos/sync` | Sync offline transactions |

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

- [[web-app-spec#Capability lifecycle]] — POS must be enabled
- [[marketplace]] — Shared inventory
- [[monetization#POS Transaction Top-ups]] — Transaction quotas

---

#halava #feature #pos #merchant
