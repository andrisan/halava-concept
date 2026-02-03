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

> See [[data-model#Unified Item Model]] for full schema.

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

```
Item (unified - see [[data-model]])
├── item_type: 'product' | 'menu_item' | 'hybrid'
├── enabled_channels: ['shop', 'pos', ...]

Cart
├── id: UUID
├── consumer_id: FK → User
├── merchant_id: FK → Merchant
├── items: CartItem[]
├── created_at, updated_at

CartItem
├── item_id: FK → Item
├── quantity: int
├── unit_price: decimal (snapshot)

Order
├── id: UUID
├── order_number: string (HLV-XXXXXX)
├── consumer_id: FK → User
├── merchant_id: FK → Merchant
├── status: enum (placed, pending_payment, confirmed, 
│                 preparing, shipped, ready, fulfilled, cancelled)
├── type: enum (online, group, pos)
├── items: OrderItem[]
├── subtotal, discount_amount, shipping_fee, total: decimal
├── fulfillment_type: enum (delivery, pickup)
├── shipping_address: JSONB (nullable)
├── pickup_location_id: FK (nullable)
├── payment_method: enum (bank_transfer, card, cash)
├── payment_status: enum (pending, confirmed, failed, refunded)
├── created_at, updated_at
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/products` | Search/list products |
| `GET` | `/api/v1/products/{slug}` | Get product details |
| `GET` | `/api/v1/cart` | Get current cart |
| `POST` | `/api/v1/cart/items` | Add item to cart |
| `PUT` | `/api/v1/cart/items/{id}` | Update quantity |
| `DELETE` | `/api/v1/cart/items/{id}` | Remove item |
| `POST` | `/api/v1/orders` | Place order |
| `GET` | `/api/v1/orders/{id}` | Get order details |
| `GET` | `/api/v1/orders` | List user's orders |
| `PUT` | `/api/v1/merchant/orders/{id}/status` | Update order status |

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
