# Accounting

> **Capability:** Accounting & Bookkeeping
> **Version:** Future (v1.2+)
> **Status:** Planned
>
> **Related:** [[marketplace]] · [[pos]] · [[order-management]] · [[monetization]]

---

## Definition

**Accounting** is Halava's financial management toolkit for merchants, providing bookkeeping, invoicing, and tax export features. It consolidates sales data from all channels into actionable financial reports.

**Core value proposition:**
- Unified bookkeeping across online and in-store sales
- Generate professional invoices for B2B customers
- Export-ready tax reports for accountants
- Real-time revenue and expense tracking

> **Note:** This is a **future capability** planned for v1.2+. This document outlines the intended scope and design.

---

## How It Works

### Financial Data Sources

| Source | Data Type | Auto-Captured |
|--------|-----------|---------------|
| [[marketplace]] | Online sales revenue | ✅ Yes |
| [[pos]] | In-store sales revenue | ✅ Yes |
| [[group-purchase]] | Group order revenue | ✅ Yes |
| Platform fees | Halava fees paid | ✅ Yes |
| Manual entries | Expenses, adjustments | Manual input |

### Key Features

| Feature | Description | Priority |
|---------|-------------|----------|
| **Sales Reports** | Daily, weekly, monthly revenue summaries | P0 |
| **Expense Tracking** | Manual expense entry and categorization | P1 |
| **Invoicing** | Generate invoices for B2B customers | P1 |
| **Tax Export** | Export data in tax-ready formats | P0 |
| **Profit & Loss** | Basic P&L statement generation | P2 |
| **Accountant Access** | Read-only access for external accountants | P2 |

---

## User Journey

### Merchant: View Sales Summary

```
Dashboard → Accounting → Sales
  → Period: [This Month ▼]
  → Total Revenue: ¥1,245,600
  │
  ├── Online Sales: ¥845,200 (67.8%)
  ├── In-Store (POS): ¥380,400 (30.5%)
  └── Group Orders: ¥20,000 (1.7%)
  │
  → Platform Fees: -¥37,368 (3%)
  → Net Revenue: ¥1,208,232
  │
  → [View Breakdown] [Export CSV]
```

### Merchant: Track Expenses

```
Accounting → Expenses → [Add Expense]
  → Date: Jan 28, 2026
  → Category: [Inventory Purchase ▼]
  → Vendor: Tokyo Halal Wholesale
  → Amount: ¥85,000
  → Receipt: [Upload Photo]
  → Notes: Monthly meat inventory
  → [Save]
  → Expense recorded in ledger
```

### Merchant: Generate Invoice

```
Accounting → Invoices → [New Invoice]
  → Customer: Sakura Hotel (B2B)
  → Items:
    • Halal Beef 5kg × 10 = ¥60,000
    • Halal Chicken 5kg × 5 = ¥30,000
  → Subtotal: ¥90,000
  → Tax (10%): ¥9,000
  → Total: ¥99,000
  → Due Date: Feb 15, 2026
  → Payment Terms: Net 30
  → [Generate PDF] → [Send to Customer]
```

### Merchant: Export Tax Report

```
Accounting → Tax Export
  → Period: 2025 Tax Year
  → Format: [適格請求書形式 (Invoice Format) ▼]
  → Include:
    ☑️ All sales transactions
    ☑️ Platform fees as expenses
    ☑️ Manual expenses
  → [Generate Report]
  → Download: halal_mart_2025_tax.csv
  → Send to accountant
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Accounting Home** | `/merchant/accounting` | Overview dashboard |
| **Sales Reports** | `/merchant/accounting/sales` | Revenue breakdown |
| **Expenses** | `/merchant/accounting/expenses` | Expense ledger |
| **Invoices** | `/merchant/accounting/invoices` | Invoice management |
| **Tax Export** | `/merchant/accounting/tax` | Tax report generation |
| **Settings** | `/merchant/accounting/settings` | Fiscal year, tax rate |

### Accounting Dashboard Layout

```
┌──────────────────────────────────────────┐
│ Accounting                    [Settings] │
├──────────────────────────────────────────┤
│ January 2026                             │
│                                          │
│ ┌────────────┐ ┌────────────┐ ┌────────────┐ │
│ │ Revenue    │ │ Expenses   │ │ Net Profit │ │
│ │ ¥1,245,600 │ │ ¥892,400   │ │ ¥353,200   │ │
│ │ ▲ 12% MoM  │ │ ▲ 8% MoM   │ │ ▲ 24% MoM  │ │
│ └────────────┘ └────────────┘ └────────────┘ │
│                                          │
│ ─────────────────────────────────────── │
│ Revenue by Channel                       │
│ ┌──────────────────────────────────────┐ │
│ │ [Bar Chart]                          │ │
│ │ ████████████████████ Online: 68%     │ │
│ │ ████████████ POS: 31%                │ │
│ │ ██ Group: 2%                         │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ─────────────────────────────────────── │
│ Quick Actions                            │
│ [📊 Sales Report] [💰 Add Expense]       │
│ [📄 New Invoice] [📁 Tax Export]         │
│                                          │
│ ─────────────────────────────────────── │
│ Recent Transactions                      │
│ ┌──────────────────────────────────────┐ │
│ │ Jan 28 · Online Order #HLV-001234    │ │
│ │ +¥4,100 · Ahmad K.                   │ │
│ ├──────────────────────────────────────┤ │
│ │ Jan 28 · POS Sale #POS-5678          │ │
│ │ +¥2,350 · Walk-in customer           │ │
│ ├──────────────────────────────────────┤ │
│ │ Jan 28 · Expense                     │ │
│ │ -¥85,000 · Inventory Purchase        │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Sales Report Layout

```
┌──────────────────────────────────────────┐
│ [←] Sales Report                         │
├──────────────────────────────────────────┤
│ Period: [Jan 1 - Jan 31, 2026 ▼]         │
│                                          │
│ Summary                                  │
│ ┌──────────────────────────────────────┐ │
│ │ Gross Sales:           ¥1,245,600    │ │
│ │ Discounts Given:       -¥45,200      │ │
│ │ Refunds:               -¥12,000      │ │
│ │ ─────────────────────────────────── │ │
│ │ Net Sales:             ¥1,188,400    │ │
│ │ Platform Fees (3%):    -¥35,652      │ │
│ │ ─────────────────────────────────── │ │
│ │ Revenue After Fees:    ¥1,152,748    │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ By Channel                               │
│ ┌──────────────────────────────────────┐ │
│ │ Online (Marketplace)   ¥845,200      │ │
│ │ In-Store (POS)         ¥380,400      │ │
│ │ Group Purchases        ¥20,000       │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ By Category                              │
│ ┌──────────────────────────────────────┐ │
│ │ Meat & Poultry         ¥680,400      │ │
│ │ Groceries              ¥312,200      │ │
│ │ Prepared Foods         ¥198,800      │ │
│ │ Other                  ¥54,200       │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [Export CSV] [Export PDF]                │
└──────────────────────────────────────────┘
```

### Invoice Template

```
┌──────────────────────────────────────────┐
│               INVOICE                    │
│                              #INV-2026-042│
├──────────────────────────────────────────┤
│ From:                                    │
│ Halal Mart Shibuya                       │
│ 〒150-0001 Tokyo, Shibuya-ku...          │
│ Registration: T1234567890123             │
│                                          │
│ To:                                      │
│ Sakura Hotel                             │
│ 〒100-0001 Tokyo, Chiyoda-ku...          │
│                                          │
│ Invoice Date: January 28, 2026           │
│ Due Date: February 15, 2026              │
│ Payment Terms: Net 30                    │
├──────────────────────────────────────────┤
│ Item              Qty    Price    Amount │
│ ─────────────────────────────────────── │
│ Halal Beef 5kg    10   ¥6,000   ¥60,000 │
│ Halal Chicken 5kg  5   ¥6,000   ¥30,000 │
│ ─────────────────────────────────────── │
│                     Subtotal:   ¥90,000 │
│                     Tax (10%):   ¥9,000 │
│ ─────────────────────────────────────── │
│                     TOTAL:      ¥99,000 │
├──────────────────────────────────────────┤
│ Bank: Mizuho Bank, Shibuya Branch        │
│ Account: 1234567                         │
│ Name: Halal Mart KK                      │
└──────────────────────────────────────────┘
```

---

## Tax Compliance (Japan)

### Supported Formats

| Format | Use Case | Standard |
|--------|----------|----------|
| 適格請求書 (Qualified Invoice) | B2B with tax deduction | Invoice System (2023+) |
| 領収書 (Receipt) | B2C transactions | Standard receipt format |
| CSV Export | Accountant import | Generic format |
| 会計ソフト連携 | Accounting software | Freee, MFクラウド API (future) |

### Required Data Points

For tax-compliant exports:
- Transaction date and ID
- Seller registration number (適格請求書発行事業者番号)
- Item descriptions and quantities
- Tax rates (10% standard, 8% reduced)
- Tax amounts per rate
- Totals before and after tax

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                   FinancialTransaction                           │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  type            ENUM(sale, refund, expense, fee, payout)       │
│  source          ENUM(order, pos, manual, platform)             │
│  source_id       UUID (FK → Order, POSTransaction, etc.)        │
│  amount          DECIMAL(12,2) NOT NULL                         │
│  tax_amount      DECIMAL(12,2) DEFAULT 0                        │
│  tax_rate        DECIMAL(4,2)                                   │
│  category        VARCHAR(100)                                   │
│  description     TEXT                                           │
│  counterparty    VARCHAR(255) (customer/vendor name)            │
│  recorded_at     TIMESTAMP NOT NULL                             │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                        Expense                                   │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  category        ENUM(inventory, rent, utilities, supplies,     │
│                       marketing, wages, other)                  │
│  vendor          VARCHAR(255)                                   │
│  amount          DECIMAL(12,2) NOT NULL                         │
│  tax_amount      DECIMAL(12,2) DEFAULT 0                        │
│  receipt_url     VARCHAR(500)                                   │
│  notes           TEXT                                           │
│  expense_date    DATE NOT NULL                                  │
│  created_by      UUID FK → User                                 │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                        Invoice                                   │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  invoice_number  VARCHAR(50) NOT NULL                           │
│  customer_name   VARCHAR(255) NOT NULL                          │
│  customer_address TEXT                                          │
│  customer_registration VARCHAR(50) (tax registration)           │
│  items           JSONB (line items with qty, price, tax)        │
│  subtotal        DECIMAL(12,2) NOT NULL                         │
│  tax_amount      DECIMAL(12,2) DEFAULT 0                        │
│  total           DECIMAL(12,2) NOT NULL                         │
│  status          ENUM(draft, issued, paid, overdue, cancelled)  │
│  issued_at       TIMESTAMP                                      │
│  due_at          TIMESTAMP                                      │
│  paid_at         TIMESTAMP                                      │
│  notes           TEXT                                           │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
│  UNIQUE(merchant_id, invoice_number)                            │
└─────────────────────────────────────────────────────────────────┘
```

### Invoice Items JSONB Structure

```json
{
  "items": [
    {
      "description": "Halal Beef 5kg",
      "quantity": 10,
      "unit_price": 6000,
      "tax_rate": 10,
      "tax_amount": 6000,
      "total": 66000
    }
  ]
}
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `financial_transaction` | `merchant_id, recorded_at DESC` | Transaction history |
| `financial_transaction` | `merchant_id, type, recorded_at` | Type filtering |
| `financial_transaction` | `source, source_id` | Source lookup |
| `expense` | `merchant_id, expense_date DESC` | Expense history |
| `expense` | `merchant_id, category` | Category reports |
| `invoice` | `merchant_id, invoice_number` (unique) | Invoice lookup |
| `invoice` | `merchant_id, status, due_at` | Overdue tracking |

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/merchant/accounting/summary` | Dashboard overview |
| `GET` | `/api/v1/merchant/accounting/sales` | Sales report |
| `GET` | `/api/v1/merchant/accounting/transactions` | All transactions |
| `GET` | `/api/v1/merchant/accounting/expenses` | List expenses |
| `POST` | `/api/v1/merchant/accounting/expenses` | Add expense |
| `PUT` | `/api/v1/merchant/accounting/expenses/{id}` | Update expense |
| `DELETE` | `/api/v1/merchant/accounting/expenses/{id}` | Delete expense |
| `GET` | `/api/v1/merchant/invoices` | List invoices |
| `POST` | `/api/v1/merchant/invoices` | Create invoice |
| `GET` | `/api/v1/merchant/invoices/{id}` | Get invoice |
| `PUT` | `/api/v1/merchant/invoices/{id}` | Update invoice |
| `POST` | `/api/v1/merchant/invoices/{id}/send` | Send invoice |
| `GET` | `/api/v1/merchant/invoices/{id}/pdf` | Download PDF |
| `POST` | `/api/v1/merchant/accounting/export` | Generate tax export |

### Export Request

```json
// POST /api/v1/merchant/accounting/export
{
  "period": {
    "from": "2025-01-01",
    "to": "2025-12-31"
  },
  "format": "qualified_invoice_csv",
  "include": ["sales", "fees", "expenses"]
}

// Response
{
  "export_id": "uuid",
  "status": "processing",
  "download_url": null // populated when ready
}
```

---

## Integration Roadmap (Future)

| Integration | Description | Priority |
|-------------|-------------|----------|
| Freee | Auto-sync with Freee accounting | P1 |
| MFクラウド | Auto-sync with Money Forward | P1 |
| 弥生 | Yayoi accounting integration | P2 |
| Bank feeds | Auto-import bank transactions | P3 |

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Merchants using accounting | > 40% of active merchants |
| Monthly report exports | > 60% of accounting users |
| Invoice generation rate | > 20 invoices/month (B2B merchants) |
| Accountant access enabled | > 15% of accounting users |

---

## Dependencies

- [[marketplace]] — Online sales data
- [[pos]] — In-store sales data
- [[order-management]] — Order and refund records
- [[monetization]] — Platform fee calculations

---

#halava #feature #accounting #merchant #future
