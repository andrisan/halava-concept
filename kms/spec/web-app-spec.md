# Halava — Web App Spec

> **Last updated:** March 2026
> **Status:** Active specification
>
> **Related:** [[index]] · [[roadmap]] · [[pages-navigation-ux-spec]] · [[api-spec]]

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

## Halava Features

### Consumer Features

Consumer features focus on **discovery, purchasing, and financial empowerment**. Halava empowers consumers to find halal options easily, shop individually or collectively, and take control of their halal spending through comprehensive expense tracking tools. These features are designed to reduce the friction Muslim consumers face when seeking halal products and services while providing personal finance insights that help them shop smarter.

| Feature                                                                           | Description                                                 |
| --------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| [[directory#Place Pages\|Directory: Place Pages]]                                 | Hours, photos, tags, halal status disclosure                |
| [[directory#Search & Filters\|Directory: Search & Filters]]                       | Distance, open now, cuisine, amenities                      |
| [[group-purchase\|Group Order]]                                                   | Multiple users contribute to shared order                   |
| [[bopu\|BOPU (Buy Online, Pick Up)]]                                              | Buy-online-pick-up options                                  |
| [[reviews-ratings\|Reviews & Ratings]]                                            | Rate places and products                                    |
| [[saved-items\|Saved Items (Bookmarks)]]                                          | Bookmark places and products                                |

### Merchant Features

Merchant features provide **operational tools for running halal businesses**. From point-of-sale to inventory management, these capabilities help merchants digitize their operations and reach consumers through the Halava platform. The modular design recognizes that halal businesses are often hybrid (e.g., a restaurant with a grocery corner), so merchants can mix and match features as needed.

Merchants **do not choose** a business type during registration. Instead, they progressively **enable capabilities** as their business grows.

| Feature                                                                    | Description                           |
| -------------------------------------------------------------------------- | ------------------------------------- |
| [[pos\|POS (Point of Sale)]]                                               | POS capability for in-store sales     |
| [[products\|Products (Catalog Management)]]                                | Manage products with prices and stock |
| [[order-management\|Order Management]]                                     | Online orders + POS transactions      |
| [[inventory\|Inventory (Stock Management)]]                                | Low-stock alerts (online + in-store)  |
| [[promotions\|Promotions]]                                                 | Basic coupon codes                    |
| [[restaurant-ops\|Restaurant Operations]]                                  | Restaurant Operations capability      |
| [[restaurant-ops#Menu Management\|Restaurant Operations: Menu Management]] | Menu items with modifiers             |
| [[restaurant-ops#QR Menu\|Restaurant Operations: QR Menu]]                 | Contactless ordering                  |
| [[restaurant-ops#Kitchen Queue\|Restaurant Operations: Kitchen Queue]]     | Order preparation workflow            |
| [[restaurant-ops#Reservations\|Restaurant Operations: Reservations]]       | Table booking system                  |
| [[pos#Advanced POS\|POS: Advanced POS]]                                    | Tables, split bills, modifiers        |
| [[accounting\|Accounting]]                                                 | Bookkeeping, invoicing, tax exports   |

### Shared Features

Shared features are **platform infrastructure used by both consumers and merchants**. These provide the foundational experience — secure authentication, seamless onboarding, permission management, and real-time notifications. The Directory and Marketplace appear here because they serve both sides: consumers discover and shop, while merchants manage their presence and listings.

| Feature | Description |
|---------|-------------|
| [[authentication\|Authentication]] | Email/OTP passwordless login (consumers & merchants) |
| [[onboarding\|Onboarding (Registration & Setup)]] | Profile setup for consumers and merchants |
| [[roles-permissions\|Roles & Permissions]] | Role-based access (Owner, Staff: Cashier/Inventory/Part-time) |
| [[notifications\|Notifications]] | Order updates, alerts, low-stock warnings |
| [[directory\|Directory (Halal Place Discovery)]] | Consumers discover places; merchants manage listings |
| [[marketplace\|Marketplace (Online Shopping)]] | Consumers shop; merchants sell products |
| [[multi-language\|Multi-language Support]] | EN + JP + ID support across platform |
| Messaging | Consumer ↔ Merchant conversation threads |

### Platform Features

Platform features are **internal tools for platform governance**. These are used by Halava staff (moderators and administrators) to manage content quality, handle reports, and oversee platform operations.

| Feature | Description |
|---------|-------------|
| [[admin-moderation\|Admin & Moderation]] | Content moderation, report handling, user management |
| App Platform | Installable first-party and third-party apps (`halava-platform`) |

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

| Version | Codename                    | Key Features                                     |
| ------- | --------------------------- | ------------------------------------------------ |
| v1.0    | Full Platform               | All features — no version gating                 |

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
| Promotions | Promotion, PromotionUsage, FeaturedListing | Coupons, discounts, boosted visibility |
| Engagement | Review, SavedItem, Notification | Ratings, bookmarks, alerts |
| Consumer Finance | PurchaseRecord, FrequentItem, PersonalPriceHistory, SpendingInsight, BudgetGoal | Expense tracking tools |
| Moderation | Report, AuditLog | Content reports, audit trail |

---

#halava #spec #product
