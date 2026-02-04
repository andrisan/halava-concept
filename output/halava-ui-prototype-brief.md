# Halava — UI Prototype Brief

> **Purpose:** Comprehensive specification for creating UI prototypes
> **Last updated:** February 2026
> **Tagline:** "Halal, Available Anywhere"

---

## 1. Project Overview

**Halava** is a two-sided halal commerce platform serving consumers and merchants in Japan.

**For Consumers:** Discover halal places, shop online, track expenses, and coordinate group purchases.

**For Merchants:** Manage products, process orders, run POS, and grow online presence with modular capabilities.

### Platform Pillars

- **Consumer Convenience:** One trusted place to discover, shop, and track halal purchases
- **Merchant Empowerment:** Modular tools to manage operations and reach customers
- **Unified Commerce:** Seamless experience across discovery, shopping, dining, and payments
- **Halal Trust:** Transparent merchant-declared halal status

---

## 2. Target Users

| Role | Description | Primary Actions |
|------|-------------|-----------------|
| **Consumer** | End users who browse, discover, and purchase | Search, browse, add to cart, checkout, track orders, manage expenses |
| **Merchant Owner** | Business operators | Configure capabilities, manage products, view analytics, handle orders |
| **Merchant Staff** | Employees (Cashier, Inventory, Part-time) | Process POS sales, manage stock, fulfill orders |
| **Moderator** | Platform team | Review reports, moderate content |
| **Admin** | Platform administrators | Manage users, merchants, platform settings |

---

## 3. Complete Route Map

### 3.1 Public Routes (No Auth Required)

| Route | Page | Purpose |
|-------|------|---------|
| `/` | Home / Explore | Landing page with discovery, trending items, nearby places |
| `/search` | Search Results | Global search across places and products |
| `/places` | Places Directory | Map + list view of halal places |
| `/places/{slug}` | Place Page | Business details, photos, hours, halal status, reviews |
| `/places/{slug}/reviews` | Place Reviews | Review listing for a place |
| `/products` | Products Browse | Browse all marketplace products |
| `/products/{slug}` | Product Details | Product info, photos, reviews, add to cart |
| `/products/{slug}/reviews` | Product Reviews | Review listing for a product |
| `/m/{merchant}` | Merchant Shopfront | Branded storefront landing |
| `/m/{merchant}/shop` | Merchant Products | Product catalog for a merchant |
| `/m/{merchant}/menu` | Restaurant Menu | QR menu for restaurants |
| `/m/{merchant}/menu/{item}` | Menu Item | Item details with modifiers |

### 3.2 Authentication Routes

| Route | Page | Purpose |
|-------|------|---------|
| `/login` | Sign In | Email entry, OAuth options (Google, Apple) |
| `/signup` | Consumer Sign Up | Consumer registration |
| `/merchant/signup` | Merchant Sign Up | Merchant registration |
| `/verify` | Verify Code | OTP/magic link entry |
| `/check-email` | Check Email | Magic link sent confirmation |

### 3.3 Consumer Routes (Auth Required)

#### Shopping & Orders

| Route | Page | Purpose |
|-------|------|---------|
| `/cart` | Shopping Cart | View cart, adjust quantities, apply coupons |
| `/checkout` | Checkout | Address, fulfillment (delivery/pickup), payment |
| `/orders` | My Orders | List of all orders with status |
| `/orders/{id}` | Order Details | Order tracking, items, status timeline |
| `/orders/{id}/pickup` | Pickup Details | QR code and pickup instructions (BOPU) |

#### Saved Items

| Route | Page | Purpose |
|-------|------|---------|
| `/saved` | All Saved | Combined view of saved places and products |
| `/saved/places` | Saved Places | Bookmarked places only |
| `/saved/products` | Saved Products | Bookmarked products only |
| `/saved/collections` | Collections | User-created collections |
| `/saved/collections/{id}` | Collection View | Single collection with items |
| `/shared/{token}` | Shared Collection | Public view of shared collection |

#### Expense Tracking

| Route | Page | Purpose |
|-------|------|---------|
| `/profile/expenses` | Expense Insight | Purchase history with filters |
| `/profile/expenses/{id}` | Transaction Detail | Receipt, itemized breakdown |
| `/profile/expenses/insights` | Spending Insights | Charts, trends, category breakdown |
| `/profile/expenses/prices` | Price History | Personal price tracking across merchants |
| `/profile/expenses/prices/{id}` | Item Price History | Price history for single item |
| `/profile/expenses/frequent` | Frequent Items | Frequently bought items |
| `/profile/expenses/budgets` | Budgets | Budget goal management |

#### Group Purchase

| Route | Page | Purpose |
|-------|------|---------|
| `/m/{merchant}/group/new` | Create Group | Start new group purchase |
| `/group-purchase/{code}` | Group Lobby | View participants, items, totals |
| `/group-purchase/{code}/invite` | Share Group | Copy invite link |
| `/group-purchase/{code}/checkout` | Group Checkout | Submit combined order (initiator only) |

#### Profile & Settings

| Route | Page | Purpose |
|-------|------|---------|
| `/profile` | User Profile | Name, email, phone |
| `/profile/qr` | My QR Code | QR for in-store expense linking |
| `/profile/reviews` | My Reviews | User's review history |
| `/settings` | Settings | Account settings |
| `/settings/notifications` | Notification Settings | Push, email, in-app preferences |
| `/settings/language` | Language | EN/JP/ID selection |

### 3.4 Merchant Dashboard Routes

#### Overview & Setup

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard` | Dashboard Home | Quick stats, recent orders, alerts |
| `/dashboard/capabilities` | Capabilities | Enable/disable features |

#### Orders

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/orders` | Orders | All orders with filters (status, date, type) |
| `/dashboard/orders/{id}` | Order Details | Order management, status updates |
| `/dashboard/orders/stats` | Order Statistics | Analytics and trends |

#### Products & Catalog

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/products` | Products | Product list with search, filters |
| `/dashboard/products/new` | Add Product | Create new product form |
| `/dashboard/products/{id}` | Edit Product | Edit product details |
| `/dashboard/products/categories` | Categories | Manage product categories |
| `/dashboard/products/import` | Import/Export | Bulk CSV operations |

#### Menu (Restaurant)

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/menu` | Menu | Menu item list |
| `/dashboard/menu/new` | Add Menu Item | Create with modifiers |
| `/dashboard/menu/{id}` | Edit Menu Item | Edit item and modifiers |

#### Kitchen

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/kitchen` | Kitchen Queue | Kanban: New → Preparing → Ready |
| `/dashboard/kitchen/display` | Kitchen Display | Full-screen mode for kitchen monitors |

#### Inventory

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/inventory` | Inventory | Stock levels, low stock alerts |
| `/dashboard/inventory/{id}` | Stock Details | Adjust stock, view history |
| `/dashboard/inventory/adjustments` | Adjustments | Stock adjustment log |
| `/dashboard/inventory/stocktake` | Stocktake | Physical inventory sessions |
| `/dashboard/inventory/alerts` | Alerts | Low stock alert configuration |

#### Promotions

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/promotions` | Promotions | All coupons and discounts |
| `/dashboard/promotions/new` | Create Promotion | New coupon/discount form |
| `/dashboard/promotions/{id}` | Edit Promotion | Edit promotion details |
| `/dashboard/promotions/featured` | Featured Listings | Boost product visibility |

#### Accounting

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/accounting` | Accounting | Financial overview |
| `/dashboard/accounting/sales` | Sales Report | Revenue by period, category |
| `/dashboard/accounting/expenses` | Expenses | Business expense ledger |
| `/dashboard/accounting/invoices` | Invoices | Invoice list |
| `/dashboard/accounting/invoices/new` | Create Invoice | New invoice form |
| `/dashboard/accounting/invoices/{id}` | Invoice Detail | View/edit/send invoice |
| `/dashboard/accounting/tax` | Tax Export | Generate tax reports |

#### Staff & Settings

| Route | Page | Purpose |
|-------|------|---------|
| `/dashboard/staff` | Staff | Team member list |
| `/dashboard/staff/invite` | Invite Staff | Send invitation |
| `/dashboard/staff/{id}` | Staff Member | Edit role, permissions |
| `/dashboard/roles` | Roles | Custom role management |
| `/dashboard/settings` | Settings | Business configuration |
| `/dashboard/settings/profile` | Business Profile | Name, address, hours |
| `/dashboard/settings/notifications` | Notifications | Alert preferences |
| `/dashboard/qr-codes` | QR Codes | Generate table/menu QR codes |

### 3.5 POS Routes

| Route | Page | Purpose |
|-------|------|---------|
| `/pos` | POS Main | Split-screen: product grid + current sale |
| `/pos/prepared-orders` | Prepared Orders | Orders awaiting payment (from online) |
| `/pos/transactions` | Transactions | Today's transaction history |
| `/pos/transactions/{id}` | Transaction Detail | Receipt, refund options |
| `/pos/kitchen` | Kitchen Queue | Compact kitchen view |
| `/pos/quota` | Quota Status | Usage meter, top-up button |

### 3.6 Moderator Routes

| Route | Page | Purpose |
|-------|------|---------|
| `/mod` | Mod Dashboard | Overview, pending counts |
| `/mod/reports` | Reports Queue | User-submitted reports |
| `/mod/reports/{id}` | Report Detail | Review, resolve, escalate |
| `/mod/content` | Flagged Content | Auto-flagged items |
| `/mod/content/{id}` | Content Detail | Approve, reject, warn |
| `/mod/audit` | Audit Log | Moderation action history |

### 3.7 Admin Routes

| Route | Page | Purpose |
|-------|------|---------|
| `/admin` | Admin Dashboard | Platform stats, alerts |
| `/admin/users` | Users | Search, filter, manage users |
| `/admin/users/{id}` | User Detail | View, suspend, delete |
| `/admin/merchants` | Merchants | Search, filter, manage merchants |
| `/admin/merchants/{id}` | Merchant Detail | View, suspend, capability status |
| `/admin/escalations` | Escalations | Issues escalated from moderators |
| `/admin/escalations/{id}` | Escalation Detail | Resolve with action |
| `/admin/settings` | Platform Settings | Global configuration |

---

## 4. Key Screens Specification

### 4.1 Home / Explore (`/`)

**Purpose:** Primary entry point for consumers.

```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
│ [Logo] [Search Bar] [Location ▼] [♡] [🛒] [👤]                  │
├─────────────────────────────────────────────────────────────────┤
│ HERO SECTION                                                    │
│ - Seasonal promotion banner                                     │
│ - Quick category shortcuts: [Food] [Groceries] [Restaurants]    │
├─────────────────────────────────────────────────────────────────┤
│ TRENDING NOW                                                    │
│ [Product Card] [Product Card] [Product Card] [Product Card] →   │
├─────────────────────────────────────────────────────────────────┤
│ NEARBY RESTAURANTS                                              │
│ [Merchant Card] [Merchant Card] [Merchant Card] →               │
├─────────────────────────────────────────────────────────────────┤
│ CATEGORIES                                                      │
│ [Grid: Halal Meat, Bakery, Indonesian, Japanese, Middle East]   │
├─────────────────────────────────────────────────────────────────┤
│ DEALS & PROMOTIONS                                              │
│ [Promo Banner] [Coupon Highlight]                               │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 Place Page (`/places/{slug}`)

**Purpose:** Business details for discovery.

```
┌─────────────────────────────────────────────────────────────────┐
│ [← Back]                                    [♡ Save] [Share]    │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │                    COVER PHOTO                              │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ Halal Ramen Tokyo                           ★ 4.5 (128 reviews) │
│ Japanese · Ramen · $$                                           │
│                                                                 │
│ 📍 Shibuya, Tokyo · 1.2 km                                      │
│ 🕐 Open · Closes 22:00                                          │
│ ☪️ Halal Status: Self-declared Muslim-owned                     │
│                                                                 │
│ [Tabs: Overview | Menu | Reviews | Photos]                      │
├─────────────────────────────────────────────────────────────────┤
│ OVERVIEW TAB                                                    │
│ - Description                                                   │
│ - Operating hours table                                         │
│ - Amenities: [WiFi] [Prayer Room] [Parking]                     │
│ - Map embed                                                     │
│ - Contact: Phone, Website                                       │
├─────────────────────────────────────────────────────────────────┤
│ [Order Online]  [Get Directions]  [Call]                        │
└─────────────────────────────────────────────────────────────────┘
```

### 4.3 Product Page (`/products/{slug}`)

**Purpose:** Product details and purchase.

```
┌─────────────────────────────────────────────────────────────────┐
│ [← Back]                                    [♡ Save] [Share]    │
├─────────────────────────────────────────────────────────────────┤
│ ┌───────────────────────┐  Product Name                         │
│ │                       │  ★ 4.8 (42 reviews)                   │
│ │    PRODUCT IMAGE      │                                       │
│ │    [Gallery dots]     │  ¥1,500                               │
│ │                       │  ☪️ Halal Certified                    │
│ └───────────────────────┘                                       │
│                            Sold by: Halal Mart Shibuya          │
│                                                                 │
│ Quantity: [−] 1 [+]                                             │
│                                                                 │
│ [Add to Cart - ¥1,500]                                          │
├─────────────────────────────────────────────────────────────────┤
│ Description                                                     │
│ Premium halal beef imported from Australia...                   │
├─────────────────────────────────────────────────────────────────┤
│ Reviews (42)                                           [See All]│
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ★★★★★  Great quality!                                       │ │
│ │ Ahmad K. · 2 days ago                                       │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### 4.4 Shopping Cart (`/cart`)

**Purpose:** Review items before checkout.

```
┌─────────────────────────────────────────────────────────────────┐
│ Shopping Cart (3 items)                                         │
├─────────────────────────────────────────────────────────────────┤
│ From: Halal Mart Shibuya                                        │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [IMG] Halal Beef 500g              [−] 2 [+]        ¥2,400  │ │
│ │       ¥1,200 each                              [Remove]     │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ [IMG] Lamb Chops 300g              [−] 1 [+]          ¥980  │ │
│ │       ¥980 each                                [Remove]     │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ Coupon Code: [____________] [Apply]                             │
│                                                                 │
│ ───────────────────────────────────────────────────────────── │
│ Subtotal:                                              ¥3,380  │
│ Delivery:                                                ¥500  │
│ ───────────────────────────────────────────────────────────── │
│ Total:                                                 ¥3,880  │
│                                                                 │
│ [Proceed to Checkout]                                           │
└─────────────────────────────────────────────────────────────────┘
```

### 4.5 Checkout (`/checkout`)

**Purpose:** Complete purchase with fulfillment and payment.

```
┌─────────────────────────────────────────────────────────────────┐
│ Checkout                              Progress: ●───○───○───○   │
│                                       Address  Fulfillment  Pay │
├─────────────────────────────────────────────────────────────────┤
│ STEP 1: Delivery Address                                        │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ● Home                                                      │ │
│ │   〒150-0001 Tokyo, Shibuya-ku, Jingumae 1-2-3              │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ ○ Work                                                      │ │
│ │   〒100-0001 Tokyo, Chiyoda-ku, Marunouchi 1-1-1            │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ [+ Add New Address]                                         │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ STEP 2: Fulfillment                                             │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ○ Delivery                                            ¥500  │ │
│ │   Estimated: 2-3 days                                       │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ ● Pick Up                                             Free  │ │
│ │   Ready in 2-4 hours                                        │ │
│ │   Location: Halal Mart Shibuya                              │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [Continue to Payment]                                           │
└─────────────────────────────────────────────────────────────────┘
```

### 4.6 Order Tracking (`/orders/{id}`)

**Purpose:** Track order status.

```
┌─────────────────────────────────────────────────────────────────┐
│ [← Orders] Order #HLV-001234                                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│    ●──────────●──────────●──────────○──────────○                │
│ Placed    Confirmed   Preparing    Ready    Fulfilled           │
│                          ↑                                      │
│                      Current                                    │
│                                                                 │
│ Estimated ready: Today, 14:00                                   │
├─────────────────────────────────────────────────────────────────┤
│ Pickup at: Halal Mart Shibuya                                   │
│ 〒150-0001 Shibuya-ku, Jingumae 1-2-3                           │
│                                                                 │
│ Pickup Code: 7842                                               │
│ [Show QR Code]  [Get Directions]                                │
├─────────────────────────────────────────────────────────────────┤
│ Order Details                                                   │
│ • Halal Beef 500g × 2                                  ¥2,400   │
│ • Lamb Chops 300g × 1                                    ¥980   │
│ ─────────────────────────────────────────────────────────────  │
│ Total:                                                 ¥3,380   │
└─────────────────────────────────────────────────────────────────┘
```

### 4.7 Expense Insight (`/profile/expenses`)

**Purpose:** View and analyze purchase history.

```
┌─────────────────────────────────────────────────────────────────┐
│ Expense Insight                                      [Insights] │
├─────────────────────────────────────────────────────────────────┤
│ This Month: ¥45,230                         vs last: ▲ ¥3,200  │
│                                                                 │
│ [All] [Online] [In-Store]     [Jan 2026 ▼]    [Export]          │
├─────────────────────────────────────────────────────────────────┤
│ Today                                                           │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🛒 Halal Mart Shibuya                              ¥3,380   │ │
│ │    Online · Pickup · 3 items                                │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ Yesterday                                                       │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🏪 Salam Grocery                                   ¥1,850   │ │
│ │    In-store · POS · 5 items                                 │ │
│ └─────────────────────────────────────────────────────────────┘ │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🍽️ Halal Ramen Tokyo                              ¥2,400   │ │
│ │    Restaurant · Dine-in · 2 items                           │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### 4.8 Group Purchase Lobby (`/group-purchase/{code}`)

**Purpose:** Coordinate group order.

```
┌─────────────────────────────────────────────────────────────────┐
│ Group Purchase                                        [Invite]  │
│ From: Halal Mart Shibuya                                        │
├─────────────────────────────────────────────────────────────────┤
│ Participants (3)                                                │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 👤 Ahmad (You) - Initiator                         ¥2,400   │ │
│ │    • Halal Beef 500g × 2                                    │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ 👤 Fatima                                          ¥1,200   │ │
│ │    • Chicken Breast 1kg × 1                                 │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ 👤 Yusuf                                             ¥980   │ │
│ │    • Lamb Chops 300g × 1                                    │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [+ Add Items]                                                   │
├─────────────────────────────────────────────────────────────────┤
│ Group Total:                                           ¥4,580   │
│ Delivery (split 3 ways):                      ¥167 each         │
│ Your share:                                            ¥2,567   │
│                                                                 │
│ [Submit Group Order]  (Only initiator can submit)               │
└─────────────────────────────────────────────────────────────────┘
```

### 4.9 POS Main Screen (`/pos`)

**Purpose:** Process in-store sales.

```
┌─────────────────────────────────────────────────────────────────┐
│ {Merchant Name} · POS            [Prepared Orders (3)] [≡]     │
├──────────────────────────────────┬──────────────────────────────┤
│ PRODUCT GRID                     │ CURRENT SALE                 │
│                                  │                              │
│ [Search products...] [Scan 📷]   │ ┌──────────────────────────┐ │
│                                  │ │ Halal Chicken    x2 ¥900 │ │
│ [All] [Meat] [Dairy] [Frozen]    │ │ [−] [+]         [Remove] │ │
│                                  │ ├──────────────────────────┤ │
│ ┌─────┐ ┌─────┐ ┌─────┐         │ │ Basmati Rice     x1 ¥450 │ │
│ │ 🍗  │ │ 🥩  │ │ 🧀  │         │ │ [−] [+]         [Remove] │ │
│ │¥450 │ │¥800 │ │¥350 │         │ └──────────────────────────┘ │
│ │Chick│ │Beef │ │Chees│         │                              │
│ └─────┘ └─────┘ └─────┘         │ ─────────────────────────── │
│ ┌─────┐ ┌─────┐ ┌─────┐         │ Subtotal:            ¥1,350 │
│ │ 🍚  │ │ 🥛  │ │ 🫓  │         │ Tax (10%):             ¥135 │
│ │¥300 │ │¥250 │ │¥400 │         │ ─────────────────────────── │
│ │Rice │ │Milk │ │Naan │         │ TOTAL:               ¥1,485 │
│ └─────┘ └─────┘ └─────┘         │                              │
│                                  │ [Link Customer QR]          │
│                                  │                              │
│                                  │ [Complete Sale - ¥1,485]    │
├──────────────────────────────────┴──────────────────────────────┤
│ ● Online  │  Quota: 245/300 this month  │  [Top-up]            │
└─────────────────────────────────────────────────────────────────┘
```

### 4.10 Merchant Dashboard (`/dashboard`)

**Purpose:** Business overview and quick actions.

```
┌─────────────────────────────────────────────────────────────────┐
│ ┌─────────┐                                                     │
│ │ SIDEBAR │  Dashboard                          [Notifications] │
│ │         │                                                     │
│ │ Overview│  Welcome back, Halal Mart!                          │
│ │ Orders  │                                                     │
│ │ Products│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐ │
│ │ Inventory│ │ Today    │ │ Pending  │ │ Low Stock│ │ Revenue│ │
│ │ Kitchen │  │ ¥45,230  │ │ 5 orders │ │ 3 items  │ │ ¥1.2M  │ │
│ │ Promos  │  │ ▲ 12%    │ │          │ │ ⚠️       │ │ MTD    │ │
│ │ Account │  └──────────┘ └──────────┘ └──────────┘ └────────┘ │
│ │ Staff   │                                                     │
│ │ Settings│  Recent Orders                              [View All]│
│ │         │  ┌───────────────────────────────────────────────┐ │
│ └─────────┘  │ #1234 · Ahmad K. · ¥3,380 · Preparing        │ │
│              │ #1233 · Fatima S. · ¥1,200 · Ready           │ │
│              │ #1232 · Yusuf M. · ¥2,400 · Fulfilled        │ │
│              └───────────────────────────────────────────────┘ │
│                                                                 │
│              Low Stock Alerts                          [View All]│
│              • Halal Beef 500g — 5 units remaining              │
│              • Chicken Breast — 8 units remaining               │
└─────────────────────────────────────────────────────────────────┘
```

### 4.11 Kitchen Queue (`/dashboard/kitchen`)

**Purpose:** Manage food preparation workflow.

```
┌─────────────────────────────────────────────────────────────────┐
│ Kitchen Queue                      [🔔 Sound: On] [Full Screen] │
├─────────────────────────────────────────────────────────────────┤
│ New (2)            │ Preparing (3)        │ Ready (1)           │
│ ────────────────── │ ────────────────────│ ─────────────────── │
│ ┌────────────────┐ │ ┌──────────────────┐ │ ┌─────────────────┐ │
│ │ #0089          │ │ │ #0087            │ │ │ #0085           │ │
│ │ Table 7        │ │ │ Table 5          │ │ │ Takeaway        │ │
│ │ Dine-in        │ │ │ Dine-in          │ │ │                 │ │
│ │ ────────────── │ │ │ ──────────────── │ │ │ Waiting for     │ │
│ │ • Satay × 2    │ │ │ • Rendang × 1    │ │ │ pickup          │ │
│ │ • Mango Lassi  │ │ │ • Nasi Goreng ×2 │ │ │                 │ │
│ │                │ │ │                  │ │ │ [Fulfilled]     │ │
│ │ [Accept]       │ │ │ [Ready]          │ │ └─────────────────┘ │
│ └────────────────┘ │ └──────────────────┘ │                     │
│ ┌────────────────┐ │ ┌──────────────────┐ │                     │
│ │ #0090          │ │ │ #0086            │ │                     │
│ │ Takeaway       │ │ │ Table 3          │ │                     │
│ │ [Accept]       │ │ │ [Ready]          │ │                     │
│ └────────────────┘ │ └──────────────────┘ │                     │
└─────────────────────────────────────────────────────────────────┘
```

### 4.12 Restaurant QR Menu (`/m/{merchant}/menu`)

**Purpose:** Contactless ordering for dine-in.

```
┌──────────────────────────────────────────┐
│ Halal Bistro                    [🛒 3]   │
│ Table 5                                  │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │ 🔍 Search menu                       │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [All] [Mains] [Sides] [Drinks] [Dessert] │
│                                          │
│ ┌─────────────┐ ┌─────────────┐          │
│ │ 📷          │ │ 📷          │          │
│ │ Beef Rendang│ │ Nasi Goreng │          │
│ │ ¥1,500      │ │ ¥1,200      │          │
│ │ [+ Add]     │ │ [+ Add]     │          │
│ └─────────────┘ └─────────────┘          │
│                                          │
│ ┌─────────────┐ ┌─────────────┐          │
│ │ 📷          │ │ 📷          │          │
│ │ Chicken     │ │ Mango Lassi │          │
│ │ Satay       │ │ ¥500        │          │
│ │ ¥800        │ │ [+ Add]     │          │
│ │ [+ Add]     │ │             │          │
│ └─────────────┘ └─────────────┘          │
├──────────────────────────────────────────┤
│ [View Cart - 3 items - ¥3,200]           │
└──────────────────────────────────────────┘
```

---

## 5. Feature Summary

### 5.1 Consumer Features (MVP)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| **Directory** | Discover halal places with map view | Home, Places, Place Page |
| **Marketplace** | Browse and purchase products | Products, Product Page, Cart, Checkout |
| **Group Purchase** | Coordinate orders with friends | Group Lobby, Invite, Checkout |
| **Expense Insight** | Track all halal spending | Expenses, Insights, Price History |
| **BOPU** | Buy online, pick up in-store | Checkout (pickup option), Order Pickup |
| **Reviews & Ratings** | Rate places and products | Place Reviews, Product Reviews, Write Review |
| **Saved Items** | Bookmark favorites | Saved, Collections |

### 5.2 Merchant Features (MVP)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| **POS** | In-store sales processing | POS Main, Transactions, Quota |
| **Products** | Catalog management | Products, Add/Edit Product, Categories |
| **Order Management** | Process online orders | Orders, Order Details |
| **Inventory** | Stock tracking and alerts | Inventory, Stock Details, Alerts |
| **Promotions** | Coupons and discounts | Promotions, Create Promotion |

### 5.3 Merchant Features (v1.1)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| **Restaurant Ops** | Full restaurant workflow | Menu, Kitchen Queue, QR Codes |
| **Menu Management** | Menu items with modifiers | Menu, Add/Edit Item |
| **QR Ordering** | Contactless table ordering | QR Menu, Menu Item, Restaurant Cart |
| **Kitchen Queue** | Order preparation workflow | Kitchen Queue, Kitchen Display |

### 5.4 Merchant Features (v1.2)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| **Accounting** | Financial management | Accounting, Sales, Expenses, Invoices, Tax |

---

## 6. UI Components Reference

### 6.1 Navigation Components

| Component | Description | Used In |
|-----------|-------------|---------|
| **Global Topbar** | Logo, search, location, profile | All consumer pages |
| **Merchant Topbar** | Breadcrumb, scoped search | Merchant storefronts |
| **Dashboard Sidebar** | Vertical navigation | Merchant, Mod, Admin dashboards |
| **Bottom Tab Bar** | Mobile navigation | Consumer mobile |
| **Breadcrumb** | Path navigation | Dashboard pages |

### 6.2 Content Components

| Component | Description | Used In |
|-----------|-------------|---------|
| **Product Card** | Image, name, price, rating | Home, Search, Products |
| **Merchant Card** | Cover, name, category, distance | Home, Places |
| **Order Card** | Order number, status, items | Orders, Dashboard Orders |
| **Review Card** | User, rating, text, date | Reviews |
| **Cart Item Row** | Image, name, quantity, price | Cart, Checkout |

### 6.3 Commerce Components

| Component | Description | Used In |
|-----------|-------------|---------|
| **Add to Cart Button** | Quantity selector, price | Product pages |
| **Cart Drawer** | Slide-out cart summary | Global overlay |
| **Checkout Stepper** | Progress indicator | Checkout |
| **Order Status Timeline** | Visual status progression | Order Details |
| **Fulfillment Selector** | Delivery vs Pickup choice | Checkout |

### 6.4 POS Components

| Component | Description | Used In |
|-----------|-------------|---------|
| **POS Product Grid** | Touch-optimized product tiles | POS Main |
| **POS Cart Panel** | Current sale items | POS Main |
| **Payment Selector** | Cash/Card buttons | POS Checkout |
| **QR Scanner** | Camera-based scanning | POS (customer linking) |
| **Quota Banner** | Usage meter with top-up CTA | POS Status Bar |

### 6.5 Form Components

| Component | Description | Used In |
|-----------|-------------|---------|
| **Search Input** | With autocomplete | All search areas |
| **Filter Chips** | Toggle filters | Search, Lists |
| **Date Range Picker** | From/to date selection | Reports, Exports |
| **Image Upload** | Drag/drop with preview | Product forms |
| **Modifier Group** | Checkbox/radio options | Menu items |

---

## 7. Design Guidelines

### 7.1 Responsive Breakpoints

| Breakpoint | Width | Target |
|------------|-------|--------|
| Mobile | < 640px | Phones |
| Tablet | 640px - 1024px | Tablets, small laptops |
| Desktop | > 1024px | Laptops, desktops |

### 7.2 Color Palette (Suggested)

| Role | Usage |
|------|-------|
| **Primary** | CTAs, links, active states |
| **Secondary** | Supporting actions |
| **Success** | Confirmations, completed states |
| **Warning** | Alerts, low stock |
| **Error** | Errors, validation |
| **Neutral** | Text, borders, backgrounds |

### 7.3 Typography

| Element | Usage |
|---------|-------|
| **Headings** | Page titles, section headers |
| **Body** | Content text |
| **Caption** | Labels, timestamps |
| **Monospace** | Codes, order numbers |

### 7.4 Touch Targets

- Minimum: 44×44 px
- Adequate spacing between interactive elements
- Swipe gestures for carousels and drawers

---

## 8. Key User Flows

### 8.1 Consumer: Browse and Purchase

```
Home → Search/Browse → Product Page → Add to Cart → Cart → Checkout → Order Confirmation → Track Order
```

### 8.2 Consumer: Group Purchase

```
Product Page → Start Group → Share Invite → Friends Join & Add Items → Initiator Submits → Track Order
```

### 8.3 Consumer: Expense Tracking

```
Profile → Expenses → View History → Filter by Date/Merchant → View Details → Export
```

### 8.4 Merchant: Process Online Order

```
Dashboard → Orders → New Order → View Details → Confirm → Prepare → Mark Ready → Customer Picks Up → Fulfilled
```

### 8.5 Merchant: POS Sale

```
POS → Search/Tap Products → Build Cart → (Optional: Scan Customer QR) → Complete Sale → Print Receipt
```

### 8.6 Restaurant: Kitchen Workflow

```
Kitchen Queue → New Order Arrives → Accept → Preparing → Mark Ready → Customer Notified → Served → Fulfilled
```

---

## Appendix: Route Count Summary

| Section | Count |
|---------|-------|
| Public Routes | 12 |
| Authentication Routes | 6 |
| Consumer Routes | 28 |
| Merchant Dashboard Routes | 42 |
| POS Routes | 7 |
| Restaurant Routes | 6 |
| Moderator Routes | 6 |
| Admin Routes | 9 |
| **Total** | **116** |

---

## Appendix: Halal Status Display

Halava uses a transparent, merchant-declared halal status system:

| Status | Badge | Description |
|--------|-------|-------------|
| **Certified** | ☪️ Halal Certified | Has certification from recognized body |
| **Muslim-owned** | ☪️ Muslim-owned | Self-declared Muslim ownership |
| **Halal-friendly** | ☪️ Halal-friendly | Offers halal options |
| **Not specified** | — | No halal information provided |

---

*End of UI Prototype Brief*
