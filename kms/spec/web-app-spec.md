# Halava — Web App Spec

> **Last updated:** February 2026
> **Status:** Active specification
>
> **Related:** [[index]] · [[roadmap]] · [[pages-navigation-ux]] · [[api-spec]]

---

## Target Users & Roles

| Role | Description |
|------|-------------|
| Consumer | End users who browse, discover, purchase, and track spending |
| Merchant Owner | Business operators managing strategy, products, and configuration |
| Merchant Staff | Employees with role-based permissions (default types: Cashier, Inventory, Part-time) |
| Moderator | Platform team handling reports and content quality |
| Admin | Full platform access and governance |

> **Full spec:** [[roles-permissions]]

---

## Platform Features

### Shared Features

| Feature | Description | Version |
|---------|-------------|---------|
| [[authentication\|Authentication]] | Email/OTP passwordless login (consumers & merchants) | MVP |
| [[onboarding\|Onboarding (Registration & Setup)]] | Profile setup for consumers and merchants | MVP |
| [[roles-permissions\|Roles & Permissions]] | Role-based access (Owner, Staff: Cashier/Inventory/Part-time) | MVP |
| [[notifications\|Notifications]] | Order updates, alerts, low-stock warnings | MVP |
| [[directory\|Directory (Halal Place Discovery)]] | Consumers discover places; merchants manage listings | MVP |
| [[marketplace\|Marketplace (Online Shopping)]] | Consumers shop; merchants sell products | MVP |
| [[multi-language\|Multi-language Support]] | EN + JP + ID support across platform | v1.1 |

### Consumer Features

| Feature | Description | Version |
|---------|-------------|---------|
| [[directory#Place Pages\|Directory: Place Pages]] | Hours, photos, tags, halal status disclosure | MVP |
| [[directory#Search & Filters\|Directory: Search & Filters]] | Distance, open now, cuisine, amenities | MVP |
| [[group-purchase\|Group Purchase]] | Multiple users contribute to shared order | MVP |
| [[purchase-history\|Purchase History (Expense Tracking)]] | Unified expense tracking across all orders | MVP |
| [[price-comparison\|Personal Price History]] | Historical price tracking across merchants | MVP |
| [[bopu\|BOPU (Buy Online, Pick Up)]] | Buy-online-pick-up options | MVP |
| [[reviews-ratings\|Reviews & Ratings]] | Rate places and products | MVP |
| [[saved-items\|Saved Items (Bookmarks)]] | Bookmark places and products | MVP |
| [[group-purchase#In-city Group Delivery\|Group Purchase: In-city Group Delivery]] | Collaborative cart, dynamic shipping, distribution tracking | v1.2 |

### Merchant Features

Merchants **do not choose** a business type during registration. Instead, they progressively **enable capabilities** as their business grows.

| Feature | Description | Version |
|---------|-------------|---------|
| [[pos\|POS (Point of Sale)]] | POS capability for in-store sales | MVP |
| [[products\|Products (Catalog Management)]] | Manage products with prices and stock | MVP |
| [[order-management\|Order Management]] | Online orders + POS transactions | MVP |
| [[inventory\|Inventory (Stock Management)]] | Low-stock alerts (online + in-store) | MVP |
| [[promotions\|Promotions]] | Basic coupon codes | MVP |
| [[restaurant-ops\|Restaurant Operations]] | Restaurant Operations capability | v1.1 |
| [[restaurant-ops#Menu Management\|Restaurant Operations: Menu Management]] | Menu items with modifiers | v1.1 |
| [[restaurant-ops#QR Menu\|Restaurant Operations: QR Menu]] | Contactless ordering | v1.1 |
| [[restaurant-ops#Kitchen Queue\|Restaurant Operations: Kitchen Queue]] | Order preparation workflow | v1.1 |
| [[restaurant-ops#Reservations\|Restaurant Operations: Reservations]] | Table booking system | v1.1 |
| [[pos#Advanced POS\|POS: Advanced POS]] | Tables, split bills, modifiers | v1.1 |
| [[accounting\|Accounting]] | Bookkeeping, invoicing, tax exports | v1.2 |

---

## Capability Model

### Capability Lifecycle

Each merchant feature has an explicit lifecycle:

**States**

- **Disabled:** feature not available; UI and endpoints hidden
- **Enabled (Needs setup):** enabled but requires configuration
- **Active:** fully configured and usable
- **Suspended:** temporarily disabled (policy/billing)

**Enablement flow**

1. Merchant clicks **Enable** on a feature card
2. System sets state to **Enabled (Needs setup)**
3. Merchant completes setup wizard
4. State becomes **Active**, feature UI appears

### Why Capability Model

- Many halal businesses are **hybrid** (restaurant + grocery corner)
- Early classification increases onboarding drop-off
- Gradual feature adoption reduces friction

---

## Release Plan

> **Full roadmap:** [[roadmap]]

| Version | Codename                    | Key Features                                     | Status  |
| ------- | --------------------------- | ------------------------------------------------ | ------- |
| v1.0    | Discover + Shop + POS       | Directory, Marketplace, POS, Group Purchase      | MVP     |
| v1.1    | Restaurant Ops              | Menu, QR ordering, Kitchen queue, Multi-language | Planned |
| v1.2    | Advanced Order & Accounting | In-city group delivery, Bookkeeping, Invoicing   | Future  |

---

## Data Model (Conceptual)

> **Full schema:** [[data-model]]

| Domain | Key Entities | Purpose |
|--------|--------------|---------|
| Users | User, Staff | Authentication, roles, merchant staff |
| Merchants | Merchant, MerchantCapability | Business profiles, capability lifecycle |
| Directory | Place | Halal place listings with location/hours |
| Catalog | Item, Category | Unified product/menu items with extensions |
| Commerce | Cart, Order, GroupPurchase | Shopping, checkout, group coordination |
| POS | POSTransaction | In-store sales, claim codes |
| Engagement | Review, SavedItem, Notification | Ratings, bookmarks, alerts |
| Moderation | Report, AuditLog | Content reports, audit trail |

---

## Acceptance Criteria (MVP)

- Merchants can register in-store purchases via POS.
- POS transactions appear in consumers' unified purchase history (when linked).
- Inventory updates correctly for both online and in-store sales.
- Consumers can perform bulk/group purchases and choose delivery or pickup.
- A merchant can register without selecting shop or restaurant.
- Capabilities can be enabled incrementally without data migration.

---

#halava #spec #product
