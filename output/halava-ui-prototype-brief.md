# Halava — UI Prototype Brief

> **Purpose:** Comprehensive specification for creating UI prototypes
> **Last updated:** February 2026
> **Tagline:** "Halal, Available Anywhere"

---

## 1. Project Overview

**Halava** is a two-sided halal commerce platform serving consumers and merchants in Japan, with initial focus on the Indonesian diaspora (230,689+ people, growing 37.2% YoY).

**For Consumers:** Discover halal places, shop online, track expenses, and coordinate group purchases.

**For Merchants:** Manage products, process orders, run POS, and grow online presence with modular capabilities.

### Growth Strategy

**Consumer-first approach:** Build value for consumers first through discovery, group purchase, and expense tracking features. Consumer demand then pulls merchants into the platform organically.

**Formalizing existing behavior:** Indonesians already coordinate group purchases via WhatsApp/LINE groups with scattered chats, manual calculations, and trust-based reimbursement. Halava formalizes this into a proper platform with automatic splitting, tracking, and receipts.

### Platform Pillars

- **Halal Hub:** One place to find groceries, restaurants, and halal services
- **Halal Companion:** Personal tools to help consumers simplify their halal lifestyle (Expense Insight)
- **Merchant Empowerment:** Modular capability-based tools to manage operations and grow online presence
- **Unified Commerce:** Seamless experience across discovery, shopping, dining, and payments

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
| `/m/{merchant}/cart` | Restaurant Cart | Current restaurant order |
| `/m/{merchant}/checkout` | Restaurant Checkout | Complete restaurant order |

### 3.2 Authentication Routes

| Route | Page | Purpose |
|-------|------|---------|
| `/login` | Sign In | Email entry, OAuth options (Google, Apple) |
| `/signup` | Consumer Sign Up | Consumer registration |
| `/merchant/signup` | Merchant Sign Up | Merchant registration |
| `/verify` | Verify Code | OTP/magic link entry |
| `/check-email` | Check Email | Magic link sent confirmation |
| `/logout` | Logout | Sign out (redirect to home) |

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
| `/group/{code}` | Group Lobby | View participants, items, totals |
| `/group/{code}/invite` | Share Group | Copy invite link |
| `/group/{code}/checkout` | Group Checkout | Submit combined order (initiator only) |

#### Reviews

| Route | Page | Purpose |
|-------|------|---------|
| `/review/new` | Write Review | New review form |

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

## 4. Key Screens Reference

This document focuses on specifications, routes, and guidelines. For detailed screen wireframes, see the dedicated wireframes folder:

→ **[Wireframes Index](./halava-ui-wireframes-index.md)**

### Screen Coverage Summary

| Feature | Wireframe File | Screens |
|---------|----------------|---------|
| Home / Explore | [01-home.md](./wireframes/01-home.md) | Home page with Discover feed |
| Directory & Search | [02-directory-search.md](./wireframes/02-directory-search.md) | Search, Results, Map, Place Page |
| Expense Insight | [03-expense-insight.md](./wireframes/03-expense-insight.md) | History, Insights, Prices, QR |
| Group Purchase | [04-group-purchase.md](./wireframes/04-group-purchase.md) | Create, Lobby, Invite, Breakdown |
| POS | [05-pos.md](./wireframes/05-pos.md) | POS Main, Checkout, Queue |
| Order Management | [06-order-management.md](./wireframes/06-order-management.md) | Dashboard, Details |
| Inventory | [07-inventory.md](./wireframes/07-inventory.md) | Overview, Stock, Alerts |
| Restaurant Ops | [08-restaurant-ops.md](./wireframes/08-restaurant-ops.md) | Kitchen, QR Menu, Ordering |

Each wireframe file includes:
- Mobile and desktop templates (side-by-side comparison)
- Component specifications
- API dependencies
- Implementation notes

---

## 5. Feature Summary

### 5.1 Consumer Features (MVP)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| **Directory** | Discover halal places with map view | Home, Places, Place Page |
| **Marketplace** | Browse and purchase products | Products, Product Page, Cart, Checkout |
| **Group Purchase** | Coordinate orders with friends to reach free shipping | Group Lobby, Invite, Checkout |
| **Expense Insight** | Track spending, personal price history, budgeting | Purchases, Insights, My Prices, Frequent, Budgets |
| **BOPU** | Buy online, pick up in-store | Checkout (pickup option), Order Pickup |
| **Reviews & Ratings** | Rate places and products | Place Reviews, Product Reviews, Write Review |
| **Saved Items** | Bookmark favorites | Saved, Collections |

### 5.2 Merchant Features (MVP)

**Capability-Based Model:** Merchants enable capabilities (Directory Listing, Shop/Marketplace, Restaurant Operations, POS, Analytics) rather than being locked into business types. This allows hybrid businesses (e.g., grocery store with restaurant) to use all relevant features.

**Capability States:** Disabled → Enabled (Needs setup) → Active → Suspended

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

### 5.4 Consumer Features (v1.2)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| **In-city Group Delivery** | Enhanced group purchase with distribution tracking | Group Lobby (addresses), Distribution Tracking |

### 5.5 Merchant Features (v1.2)

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

### 7.1 Dual-Template Architecture

> **Critical:** Halava uses two entirely independent templates based on device type. The mobile template is **NOT** a responsive version of the desktop template. It is a **completely separate codebase** designed like a native mobile app — with its own component tree, layouts, and navigation patterns. No desktop UI elements (hamburger menus, sidebars, hover states) exist in the mobile template. Only the desktop template uses responsive design (scaling from tablet to desktop).

| Template | Target | Breakpoint | Architecture |
|----------|--------|------------|--------------|
| **Mobile Template** | Phones | < 640px | Separate component tree, dedicated mobile UI |
| **Desktop Template** | Tablets, laptops, desktops | ≥ 640px | Single codebase with responsive CSS (tablet ↔ desktop) |

#### Why Separate Templates (Not Responsive)

The mobile template is a distinct implementation designed like a **native mobile app**, not CSS media queries on the desktop template:

- **Native app paradigm:** No desktop elements (no hamburger menus, no sidebars, no hover states)
- **Different component trees:** Mobile and desktop render entirely different UI components
- **Different navigation structure:** Bottom tabs only (mobile) vs topbar + sidebar (desktop)
- **Different page layouts:** Not just resized — fundamentally different information architecture
- **Different interaction patterns:** Swipe gestures, bottom sheets, pull-to-refresh (no click/hover)
- **Different bundle:** Mobile loads only mobile components (smaller JS payload)
- **Different feature set:** POS, Admin, and full Merchant dashboard are desktop-only

#### Directory Structure for Development

```
Mobile Template (< 640px)
├── /components/mobile/       ← Separate component directory
├── /layouts/mobile-layout    ← Different shell
├── /pages/mobile/            ← Mobile-specific pages
└── No responsive breakpoints within template

Desktop Template (≥ 640px)
├── /components/desktop/      ← Separate component directory
├── /layouts/desktop-layout
├── /pages/desktop/
└── Responsive: tablet (640-1024px) ↔ desktop (>1024px)
```

#### Template Detection

| Method | Purpose |
|--------|---------|
| **Server-side (User-Agent)** | Initial SSR render with correct template |
| **Client-side (viewport width)** | Hydration and resize handling |
| **Template switch** | Triggers full re-render (not CSS toggle) |

#### Shared Across Templates

Both templates share:
- Design tokens (colors, typography, spacing)
- Reusable logic and state management
- API layer and data fetching
- Authentication state
- Business logic and validation

#### Desktop Template Breakpoints

| Breakpoint | Width | Target |
|------------|-------|--------|
| Tablet | 640px - 1024px | Tablets, small laptops |
| Desktop | > 1024px | Laptops, desktops |

### 7.2 Template-Specific Features

| Feature | Mobile Template | Desktop Template |
|---------|-----------------|------------------|
| **Consumer browsing** | Full support | Full support |
| **Consumer checkout** | Full support | Full support |
| **Merchant dashboard** | Limited (view-only) | Full support |
| **POS** | Not supported | Full support |
| **Admin/Moderator** | Not supported | Full support |

### 7.3 Color Palette (Suggested)

| Role | Usage |
|------|-------|
| **Primary** | CTAs, links, active states |
| **Secondary** | Supporting actions |
| **Success** | Confirmations, completed states |
| **Warning** | Alerts, low stock |
| **Error** | Errors, validation |
| **Neutral** | Text, borders, backgrounds |

### 7.4 Typography

| Element | Usage |
|---------|-------|
| **Headings** | Page titles, section headers |
| **Body** | Content text |
| **Caption** | Labels, timestamps |
| **Monospace** | Codes, order numbers |

### 7.5 Touch Targets

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
Merchant Shopfront → Start Group Order → Set Deadline → Share Invite Link (WhatsApp/LINE)
  → Friends Join & Add Items → Reach Free Shipping Threshold
  → Initiator Reviews & Submits → Pay Full Amount
  → Receive Order → Distribute to Participants → Share Breakdown for Reimbursement
```

### 8.3 Consumer: Expense Tracking

```
Profile → Expense Insight → View Purchase History
  → Filter: Date range, Category (Groceries/Dining/Shopping), Merchant
  → Tap Transaction → Full Receipt Details
  → [Export] for personal records

Profile → Expense Insight → Insights
  → Monthly spending breakdown (chart)
  → Category distribution (pie chart)
  → Top merchants by spend
  → [Set Budget Goal]

Profile → Expense Insight → My Prices
  → View personal price history for items
  → "Your best price" highlight
  → [Shop Here] to buy again from best-price merchant
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

### 8.7 Consumer: Link In-Store Purchase to Account

```
At Checkout → Cashier: "Save receipt digitally?"
  → Open Halava App → Profile → [My QR Code]
  → Show QR to cashier → Cashier scans
  → Transaction linked to account
  → Appears in Expense Insight instantly
```

---

## Appendix: Route Count Summary

| Section | Count |
|---------|-------|
| Public Routes | 14 |
| Authentication Routes | 6 |
| Consumer Routes | 29 |
| Merchant Dashboard Routes | 42 |
| POS Routes | 7 |
| Restaurant Routes | 6 |
| Moderator Routes | 6 |
| Admin Routes | 9 |
| **Total** | **119** |

> **Note:** See routes-spec.md for the authoritative complete listing.

---

## Appendix: Halal Status Display

Halava uses a transparent, merchant-declared halal status system:

| Status | Badge | Description | Evidence |
|--------|-------|-------------|----------|
| **Certified** | ☪️ Certified Halal [View Certificate] | Has certification from recognized body | Certificate uploaded |
| **Muslim-owned** | ☪️ Muslim-owned | Self-declared Muslim ownership | Optional declaration |
| **Declared** | ☪️ Halal | Self-declared halal | None required |
| **Not specified** | — | No halal information provided | — |

> **Note:** Halava does not certify halal status. Merchants self-declare; moderators check for obvious fraud only.

---

## Appendix: Multi-Language Support

Halava supports three languages to serve the Indonesian diaspora and broader market:

| Language | Code | Primary Audience |
|----------|------|------------------|
| **English** | EN | Universal default |
| **Japanese** | JP | Local merchants, Japanese users |
| **Indonesian** | ID | Primary target: Indonesian diaspora |

Users can change language via `/settings/language`.

---

## 9. Implementation Plan

### Wireframes Reference

For detailed ASCII wireframes organized by feature area, see the [Wireframes Index](./halava-ui-wireframes-index.md).

Wireframe files are located in `output/wireframes/` and are organized for incremental implementation:

| Priority | File | Feature | Target | MVP |
|----------|------|---------|--------|-----|
| 1 | [01-home.md](./wireframes/01-home.md) | Home / Explore | Consumer | Yes |
| 2 | [02-directory-search.md](./wireframes/02-directory-search.md) | Directory & Search | Consumer | Yes |
| 3 | [03-expense-insight.md](./wireframes/03-expense-insight.md) | Expense Insight | Consumer | Yes |
| 4 | [04-group-purchase.md](./wireframes/04-group-purchase.md) | Group Purchase | Consumer | Yes |
| 5 | [05-pos.md](./wireframes/05-pos.md) | Point of Sale | Merchant | Yes |
| 6 | [06-order-management.md](./wireframes/06-order-management.md) | Order Management | Merchant | Yes |
| 7 | [07-inventory.md](./wireframes/07-inventory.md) | Inventory | Merchant | Yes |
| 8 | [08-restaurant-ops.md](./wireframes/08-restaurant-ops.md) | Restaurant Ops + Kitchen | Merchant | v1.1 |

### Implementation Order

Implementation follows a **consumer-first strategy**:

1. **Consumer MVP Features (Priority 1-4):** Home, Directory & Search, Expense Insight, Group Purchase
2. **Merchant MVP Features (Priority 5-7):** POS, Order Management, Inventory
3. **v1.1 Features (Priority 8):** Restaurant Operations + Kitchen Queue

### Getting Started

Begin implementation with the [Home wireframe](./wireframes/01-home.md) which serves as the entry point for all consumers. Each wireframe file includes:

- Screen specifications with mobile and desktop templates
- Key components needed
- API dependencies
- Design tokens required
- Implementation notes

---

*End of UI Prototype Brief*
