# Marketplace (Online Shopping)

> **Feature Type:** Shared (Consumer & Merchant)
> **Capability:** Shop / Marketplace Selling
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[directory]] · [[pos]] · [[group-purchase]] · [[onboarding]]

---

## Definition

The **Marketplace** is Halava's online commerce system enabling consumers to browse, purchase, and receive halal products from merchants. It supports both delivery and Buy-Online-Pick-Up (BOPU).

**Core value proposition:**
- Consumers buy halal products with confidence
- Merchants sell online without building their own store
- Unified catalog across online and in-store (POS)

---

## How It Works

### For Consumers

1. **Browse** products via search, categories, or merchant storefronts
2. **Add to cart** (single-merchant cart in MVP)
3. **Checkout** with delivery or pickup option
4. **Pay** via bank transfer (Phase 1) or in-app (Phase 2)
5. **Track** order status until fulfillment
6. **Receive** products and digital receipt

### For Merchants

1. **Enable** Shop / Marketplace Selling capability
2. **Add products** with prices, photos, inventory
3. **Configure** fulfillment (shipping zones, pickup locations)
4. **Receive** orders in dashboard
5. **Process** and fulfill orders
6. **Manage** inventory (synced with POS)

### Payment Phases

| Phase | Payment Model | Fee Collection |
|-------|---------------|----------------|
| **Phase 1 (MVP)** | Off-platform (bank transfer) | Honor-based monthly invoice |
| **Phase 2** | In-app via Stripe/PAY.JP | Auto-deducted at payout |
| **Phase 3 (3-5+ years)** | Direct payment intermediation | Halava obtains 資金移動業 license |

> See [[monetization#Transaction Fee Model]] for fee rates and collection methods.

### Unified Item Model

Halava uses a **unified item model** to support hybrid businesses. Products and menu items share a common base (`Item`), enabling:

- Shared inventory across online shop and POS
- Consistent pricing and stock management
- Hybrid businesses (e.g., restaurant with grocery corner)

> See [[products#Data Model]] for the unified Item model schema.

---

## User Journey

### Consumer: Buy Products Online

```
Home → Browse/Search "halal beef"
  → Product Card → Product Page
  → [Add to Cart]
  → Cart Drawer: Review items, quantity
  → [Checkout]
  → Select Fulfillment: Delivery / Pickup
  → Payment Step:
    (Phase 1) View merchant bank details, transfer
    (Phase 2) Enter card, pay in-app
  → Order Confirmation
  → Track Order: Confirmed → Preparing → Shipped/Ready → Delivered
  → Receipt in Purchase History
```

### Merchant: Process an Order

```
Order Notification → Orders Dashboard
  → View Order Details
  → [Confirm Payment Received] (Phase 1)
  → [Mark Preparing]
  → Pack items, print label
  → [Mark Shipped] or [Mark Ready for Pickup]
  → Customer receives → [Mark Fulfilled]
```

---

## UI/UX Specification

### Consumer Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Product Listing** | `/products` | Browse all products |
| **Product Page** | `/products/{slug}` | Product details |
| **Merchant Shopfront** | `/m/{merchant}/shop` | Merchant's product catalog |
| **Cart** | Drawer / `/cart` | Current cart items |
| **Checkout** | `/checkout` | Fulfillment + payment |
| **Order Tracking** | `/orders/{id}` | Real-time status |
| **Purchase History** | `/purchases` | All past orders |

### Product Page Layout

```
┌──────────────────────────────────────────┐
│ [←] Product Name               [♡] [↗]  │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │         Product Image Gallery        │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ¥1,200                                   │
│ ★ 4.8 (45 reviews)                       │
│ 🥩 Halal Certified                       │
│ 📦 In Stock (12 available)               │
│                                          │
│ Sold by: Halal Mart Shibuya [→]          │
│                                          │
├──────────────────────────────────────────┤
│ Quantity: [−] 1 [+]                      │
│                                          │
│ [ 🛒 Add to Cart ]                       │
├──────────────────────────────────────────┤
│ Description                              │
│ Specifications | Reviews | Shipping      │
└──────────────────────────────────────────┘
```

### Cart Behavior (MVP)

- **Single-merchant cart** — Adding from a different merchant prompts:
  - "Start new cart" (clears current)
  - "View current cart" (stay with current merchant)
- Prevents complex cross-merchant fulfillment

### Checkout Flow

```
┌─────────────────────────────────────────┐
│ Checkout                                │
├─────────────────────────────────────────┤
│ 1. Review Items                    [✓]  │
│    └── Product × Qty = Subtotal         │
│                                         │
│ 2. Fulfillment                     [●]  │
│    ○ Delivery: Enter address            │
│    ○ Pickup: Select location            │
│                                         │
│ 3. Payment                         [ ]  │
│    (Phase 1) Bank transfer details      │
│    (Phase 2) Card form                  │
│                                         │
│ ─────────────────────────────────────── │
│ Subtotal:         ¥3,600                │
│ Shipping:         ¥500                  │
│ Total:            ¥4,100                │
│                                         │
│ [ Place Order ]                         │
└─────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         Item                                     │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  name            VARCHAR(255) NOT NULL                          │
│  description     TEXT                                           │
│  base_price      DECIMAL(10,2) NOT NULL                         │
│  item_type       ENUM(product, menu_item, hybrid)               │
│  enabled_channels TEXT[] (shop, restaurant, pos)                │
│  is_available    BOOLEAN DEFAULT true                           │
│  halal_status    ENUM(declared, certified)                      │
│  photos          TEXT[]                                         │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       Category                                   │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  name            VARCHAR(100) NOT NULL                          │
│  slug            VARCHAR(100) UNIQUE NOT NULL                   │
│  parent_id       UUID FK → Category (self-reference)            │
│  sort_order      INT DEFAULT 0                                  │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         Cart                                     │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  consumer_id     UUID FK → User                                 │
│  merchant_id     UUID FK → Merchant                             │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
│  UNIQUE(consumer_id, merchant_id)                               │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       CartItem                                   │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  cart_id         UUID FK → Cart                                 │
│  item_id         UUID FK → Item                                 │
│  quantity        INT NOT NULL                                   │
│  unit_price      DECIMAL(10,2) NOT NULL                         │
│  modifiers       JSONB                                          │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         Order                                    │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  consumer_id     UUID FK → User                                 │
│  merchant_id     UUID FK → Merchant                             │
│  order_number    VARCHAR(20) UNIQUE NOT NULL                    │
│  status          ENUM(placed, pending_payment, confirmed,       │
│                       preparing, ready, shipped, fulfilled,     │
│                       cancelled)                                │
│  order_type      ENUM(online, group, pos)                       │
│  subtotal        DECIMAL(10,2) NOT NULL                         │
│  discount_amount DECIMAL(10,2) DEFAULT 0                        │
│  shipping_fee    DECIMAL(10,2) DEFAULT 0                        │
│  tax_amount      DECIMAL(10,2) DEFAULT 0                        │
│  total           DECIMAL(10,2) NOT NULL                         │
│  payment_method  VARCHAR(50)                                    │
│  payment_status  ENUM(pending, paid, refunded, failed)          │
│  fulfillment_type ENUM(delivery, pickup)                        │
│  shipping_address JSONB                                         │
│  notes           TEXT                                           │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       OrderItem                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  order_id        UUID FK → Order                                │
│  item_id         UUID FK → Item                                 │
│  quantity        INT NOT NULL                                   │
│  unit_price      DECIMAL(10,2) NOT NULL                         │
│  total_price     DECIMAL(10,2) NOT NULL                         │
│  modifiers       JSONB                                          │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    OrderStatusHistory                            │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  order_id        UUID FK → Order                                │
│  from_status     VARCHAR(50)                                    │
│  to_status       VARCHAR(50) NOT NULL                           │
│  changed_by      UUID FK → User                                 │
│  note            TEXT                                           │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `item` | `merchant_id, item_type` | Catalog queries |
| `item` | `merchant_id, enabled_channels, is_available` | Channel-specific |
| `item` | `name, description` (GIN tsvector) | Full-text search |
| `cart` | `consumer_id, merchant_id` (unique) | Cart lookup |
| `order` | `consumer_id, created_at DESC` | Purchase history |
| `order` | `merchant_id, status, created_at` | Merchant dashboard |
| `order` | `order_number` (unique) | Order lookup |

---

## API Endpoints

> Full API index: [[api-spec#4. Marketplace Module]]

### GET /v1/marketplace/products

Search and list products.

```
Query Parameters:
  q             string    Search query
  merchant_id   uuid      Filter by merchant
  category      string    Filter by category
  halal_status  string    Filter: certified, declared
  in_stock      boolean   Filter to in-stock only
  sort          string    Sort: price_asc, price_desc, rating, newest
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "results": [...],
  "total": 156
}
```

### GET /v1/marketplace/products/{id}

Get product details.

```json
// Response
{
  "id": "uuid",
  "name": "Halal Beef 500g",
  "description": "Premium Australian halal beef...",
  "base_price": 1200,
  "halal_status": "certified",
  "photos": [...],
  "merchant": { "id": "uuid", "name": "Halal Mart" },
  "stock_count": 45,
  "is_available": true
}
```

### GET /v1/marketplace/cart

Get current user's cart.

```json
// Response
{
  "id": "uuid",
  "merchant": { "id": "uuid", "name": "Halal Mart" },
  "items": [
    {
      "id": "uuid",
      "product": { "id": "uuid", "name": "Halal Beef 500g" },
      "quantity": 2,
      "unit_price": 1200,
      "total_price": 2400
    }
  ],
  "subtotal": 2400
}
```

### POST /v1/marketplace/cart/items

Add item to cart. Note: Single-merchant cart in MVP.

```json
// Request
{
  "product_id": "uuid",
  "quantity": 2
}

// Response
{
  "cart_id": "uuid",
  "item": { ... },
  "subtotal": 2400
}
```

### PATCH /v1/marketplace/cart/items/{id}

Update cart item quantity.

```json
// Request
{
  "quantity": 3
}

// Response
{
  "item": { ... },
  "subtotal": 3600
}
```

### DELETE /v1/marketplace/cart/items/{id}

Remove item from cart.

```json
// Response
{
  "message": "Item removed",
  "subtotal": 1200
}
```

### POST /v1/marketplace/orders

Create order (checkout).

```json
// Request
{
  "cart_id": "uuid",
  "fulfillment_type": "pickup",  // or "delivery"
  "shipping_address": { ... },   // if delivery
  "payment_method": "bank_transfer",
  "notes": "Please include extra napkins"
}

// Response
{
  "id": "uuid",
  "order_number": "HLV-001234",
  "status": "placed",
  "total": 4100
}
```

### GET /v1/marketplace/orders/{id}

Get order details.

```json
// Response
{
  "id": "uuid",
  "order_number": "HLV-001234",
  "status": "preparing",
  "items": [...],
  "subtotal": 3600,
  "shipping_fee": 500,
  "total": 4100,
  "fulfillment_type": "delivery",
  "created_at": "2026-01-28T10:00:00Z"
}
```

### GET /v1/marketplace/orders

List user's orders.

```
Query Parameters:
  status      string    Filter by status
  limit       int       Results per page (default: 20)
  offset      int       Pagination offset
```

```json
// Response
{
  "orders": [...],
  "total": 24
}
```

---

## Order Status Flow

```
placed → pending_payment → confirmed → preparing → shipped/ready → fulfilled
                ↓                          ↓
            cancelled                  cancelled
```

| Status | Consumer Sees | Merchant Action |
|--------|---------------|-----------------|
| `placed` | "Order Placed" | Review order |
| `pending_payment` | "Awaiting Payment" | Wait for transfer |
| `confirmed` | "Payment Confirmed" | Confirm, start prep |
| `preparing` | "Preparing" | Pack items |
| `shipped` | "Shipped" | Provide tracking |
| `ready` | "Ready for Pickup" | Wait for customer |
| `fulfilled` | "Completed" | Done |

---

## Inventory Sync

Marketplace shares inventory with [[pos]]:

- **Online order placed:** `stock_count -= quantity`
- **POS sale:** `stock_count -= quantity`
- **Low stock alert:** When `stock_count <= low_stock_threshold`
- **Out of stock:** Hide from marketplace when `stock_count == 0`

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Cart-to-checkout conversion | > 40% |
| Order completion rate | > 80% |
| Avg. order value | > ¥3,000 |
| Fulfillment time (pickup) | < 24h |

---

## Dependencies

- [[web-app-spec#Capability lifecycle]] — Shop/Marketplace must be enabled
- [[pos]] — Shared inventory
- [[group-purchase]] — Extended flow for group orders
- [[monetization#Transaction Fee Model]] — Fee structure

---

#halava #feature #marketplace #shared
