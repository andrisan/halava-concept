# Halava — Web App Spec (v1 → v1.5)

> **Last updated:** February 2026
> **Status:** Active specification
>
> **Related documents:**
> - [[monetization]] — Pricing, fees, and investment staging
> - [[pitch-deck]] — Investor presentation
> - [[pages-navigation-ux]] — Detailed pages, URL paths, and UI/UX specification
>
> **Features:**
> - [[directory]] — Halal place discovery
> - [[marketplace]] — Online shopping
> - [[pos]] — Point of Sale
> - [[restaurant-ops]] — Restaurant operations (v1.1)
> - [[group-purchase]] — Group purchasing
> - [[purchase-history]] — Expense tracking & price comparison
> - [[onboarding]] — Registration & setup
> - [[admin-moderation]] — Platform governance
> - [[notifications]] — Alerts & communications
> - [[roles-permissions]] — Access control

---

## Version History

| Version | Date | Changes |
|---------|------|--------|
| v1.5 | Jan 2026 | Restaurant operations, advanced POS, multi-language |
| v1.0 | Dec 2025 | MVP: Discover + Shop + POS, capability-based merchant model |

---

## 1) Product definition

### 1.1 Vision

**Halava** is an abbreviation for "HALal, AVailable Anywhere." It is a **two-sided halal commerce platform** designed to serve both consumers and merchants with purpose-built features.

**For Consumers:**

- **Discover** halal products and places with confidence
- **Track** personal finances (unified expense tracking across groceries and dining)
- **Trust** halal verification and merchant-declared status
- **Coordinate** group purchases in one platform

**For Merchants:**

- **Reach** a customer base actively seeking halal products and services
- **Manage** with powerful business tools (inventory, sales analytics, staff management)
- **Grow** with enhanced online presence and digital storefront
- **Operate** efficiently to drive higher order value and repeat purchases

### 1.2 Target users & roles

- **Consumers:**
  - Role: End users seeking halal products, dining, and discovery.
  - Responsibilities: Browse, purchase, and manage personal spending.

- **Merchants:**
  - **Owner:** Business operator managing overall strategy and configuration.
    - Responsibilities: Create business listing, enable capabilities, manage products/menu and pricing, set inventory levels.
  - **Staff (Cashier):** Day-to-day business operators handling transactions and fulfillment.
    - Responsibilities: Process in-store sales via POS, manage orders, generate receipts, fulfill customer requests.

- **Admins & Moderators:**
  - Role: Platform governance and quality assurance.
  - Responsibilities: Handle user reports, moderate content, manage roles and access, maintain platform policy compliance.

### 1.3 Platform pillars

- **Unified Commerce Model:** Single platform encompassing discovery, shopping, dining, and payments across all halal options. Unified item model (products and menu items) and purchase history enable expense tracking and price comparison.

- **Capability-First Approach:** Merchants activate features on their own timeline; no upfront business type classification. Prevents early friction and supports hybrid businesses (e.g., restaurant + grocery corner).

- **Halal Trust Infrastructure:** Merchant-declared halal status by default with optional evidence publication (e.g., certificates, documents). Transparent disclosure to consumers without artificial gatekeeping.

- **Integrated Merchant Operations:** Unified dashboard, inventory, order management, and analytics across all capabilities (online shopping, POS, restaurant operations).

---

## 2) Platform features

Halava features are organized by user type. **Merchant features** use a capability model (can be enabled/disabled), while **Consumer features** are always available.

### 2.1 Consumer features

Features available to all consumers:

| Feature | Description | Version |
|---------|-------------|---------|
| [[directory]] | Discover halal places via search, map, filters | MVP |
| [[marketplace]] | Browse products, cart, checkout, order tracking | MVP |
| [[group-purchase]] | Coordinate group orders with friends | MVP |
| [[purchase-history]] | Unified expense tracking across all orders | MVP |
| [[price-comparison]] | Personal price history for repurchase decisions | MVP |
| [[reviews-ratings]] | Rate places and products | MVP |
| [[saved-items]] | Bookmark places and products | MVP || [[notifications]] | Order updates and alerts | MVP |
### 2.2 Merchant features (capability model)

Merchants **do not choose** a business type during registration. Instead, they progressively **enable features** as their business grows.

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

#### 2.2.1 Capability lifecycle

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

#### 2.2.2 Why capability model for merchants

- Many halal businesses are **hybrid** (restaurant + grocery corner)
- Early classification increases onboarding drop-off
- Gradual feature adoption reduces friction

---

## 3) Scope & release plan

> **📄 Full roadmap:** [[roadmap]]

| Version | Codename | Key Features | Status |
|---------|----------|--------------|--------|
| v1.0 | Discover + Shop + POS | Directory, Marketplace, POS, Group Purchase | MVP |
| v1.1 | Restaurant Ops | Menu, QR ordering, Kitchen queue, Multi-language | Planned |
| v1.3 | Advanced Order & Accounting | In-city group delivery, Bookkeeping, Invoicing | Future |

---

## 4) Roles & permissions

> **📄 Full specification:** [[roles-permissions]]

| Role | Description |
|------|-------------|
| Consumer | End users who browse, purchase, and track spending |
| Merchant Owner | Business operators managing strategy and configuration |
| Merchant Staff | Day-to-day operators (cashiers) handling transactions |
| Moderator | Platform team handling reports and content quality |
| Admin | Full platform access and governance |

---

## 5) High-level data model (conceptual)

> See [[data-model]] for full schema documentation.

- **MerchantCapability**(merchant\_id, capability\_type, status, enabled\_at, activated\_at)
- **POSTransaction**(id, merchant\_id, items, total, payment\_method, created\_at)
- **Place**, **Product**, **MenuItem** activated based on enabled capabilities
- **User**, **Order**, **Cart**, **GroupPurchase**, **Review**, **Report**, **Staff**, **Notification**

---

## 6) Acceptance criteria (MVP)

- Merchants can register in-store purchases via POS.
- POS transactions appear in consumers' unified purchase history (when linked).
- Inventory updates correctly for both online and in-store sales.
- Consumers can perform bulk/group purchases and choose delivery or pickup.
- A merchant can register without selecting shop or restaurant.
- Capabilities can be enabled incrementally without data migration.

---

#halava #spec #product
