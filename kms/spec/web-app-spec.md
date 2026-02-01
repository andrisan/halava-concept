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

### Consumer Features

| Feature | Description | Version |
|---------|-------------|---------|
| [[directory]] | Discover halal places via search, map, filters | MVP |
| [[marketplace]] | Browse products, cart, checkout, order tracking | MVP |
| [[group-purchase]] | Coordinate group orders with friends | MVP |
| [[purchase-history]] | Unified expense tracking across all orders | MVP |
| [[price-comparison]] | Personal price history for repurchase decisions | MVP |
| [[reviews-ratings]] | Rate places and products | MVP |
| [[saved-items]] | Bookmark places and products | MVP |
| [[notifications]] | Order updates and alerts | MVP |

### Merchant Features (Capability Model)

Merchants **do not choose** a business type during registration. Instead, they progressively **enable capabilities** as their business grows.

| Feature | Description | Version |
|---------|-------------|---------|
| [[directory]] | Business profile, location, halal status | MVP |
| [[marketplace]] | Product catalog, inventory, online orders | MVP |
| [[pos]] | Cashier interface, receipts, offline mode | MVP |
| [[restaurant-ops]] | Menu items, QR menu, kitchen queue | v1.1 |
| [[order-management]] | Order inbox, status updates | MVP |
| [[promotions]] | Coupons, featured listings | MVP |
| [[notifications]] | Order alerts, low stock warnings | MVP |
| [[accounting]] | Bookkeeping, invoicing, tax exports | Future |

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
| v1.3    | Advanced Order & Accounting | In-city group delivery, Bookkeeping, Invoicing   | Future  |

---

## Data Model (Conceptual)

> **Full schema:** [[data-model]]

- **MerchantCapability** — merchant_id, capability_type, status, enabled_at, activated_at
- **POSTransaction** — id, merchant_id, items, total, payment_method, created_at
- **Place**, **Product**, **MenuItem** — activated based on enabled capabilities
- **User**, **Order**, **Cart**, **GroupPurchase**, **Review**, **Notification**

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
