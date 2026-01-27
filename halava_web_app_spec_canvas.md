# Halava — Web App Spec (v1 → v1.5)

## 1) Product definition

### 1.1 Vision

**Halava** stands for Halal, Available Anywhere. Its vision is to be the default destination for anything halal:

- **Buy** halal groceries/ingredients/products (B2C marketplace)
- **Find** halal restaurants/places while traveling (directory + discovery)
- **Operate** halal businesses through modular merchant capabilities, including online and in-store sales

### 1.2 Target users

- **Consumers (B2C):**

  - Buy halal products (online checkout, pickup, group purchases).
  - Discover halal places and plan visits (search, filters, save, directions).
  - Track a unified purchase history (online orders + linked in-store receipts).

- **Merchants (shops and restaurants):**

  - Create and manage a business listing (hours, photos, tags, halal disclosure).
  - Enable capabilities as needed (POS, online selling, restaurant operations).
  - Manage products/menu, pricing, inventory, and fulfill orders.

- **Admins/Moderators:**

  - Review and resolve reports (misleading claims, spam, inappropriate content).
  - Moderate listings, reviews, and media to maintain platform quality.
  - Administer roles, access, and platform configuration.

### 1.3 Core value propositions

- **Convenience:** a single platform to shop, dine, and discover halal options.
- **Trust:** merchant-declared halal status by default, with optional publication of supporting halal evidence (e.g., certificates or documents).
- **Flexibility:** merchants start simple and enable additional capabilities only when needed.
- **Growth:** exposure and integrated operational tools for merchants, including in-store-to-online workflows.

---

## 2) Merchant capability model (IMPORTANT)

### 2.1 Capability-based approach (recommended)

Merchants **do not choose** whether they are a restaurant or a shop during registration. Instead, Halava uses a **capability-based model** similar to how platforms like Google Cloud enable APIs:

- A merchant account starts with **no assumptions** about business type.
- Merchants progressively **enable capabilities** as their business grows.
- Capabilities unlock UI, data models, workflows, and permissions.

This avoids early friction, supports hybrid businesses, and keeps the platform extensible.

### 2.2 Capability lifecycle (GCP-style enablement)

Each capability has an explicit lifecycle so “enabled” does not automatically mean “ready to use.”

**States**

- **Disabled:** capability not available; UI and endpoints are hidden/blocked.
- **Enabled (Needs setup):** capability enabled but requires configuration (setup wizard).
- **Active:** capability fully configured and usable.
- **Suspended (optional):** temporarily disabled due to policy violations or billing/admin actions.

**Enablement flow (recommended)**

1. Merchant clicks **Enable** on a capability card in the **Merchant Dashboard → Capabilities** section.
2. System creates the capability record and sets state to **Enabled (Needs setup)**.
3. Merchant completes a short setup wizard (requirements are shown upfront).
4. State becomes **Active** and the related UI/menus/routes appear.

**Why this matters**

- Keeps onboarding minimal while still guiding merchants to a working configuration.
- Prevents partially configured features from creating confusion.

### 2.3 Core merchant capabilities

Capabilities are conceptually similar to *installable apps* (e.g., GCP API enablement), but implemented as **first-party modules** that affect UI, data models, and business workflows.

- **Directory Listing (default)**

  - Business profile, location, photos, tags
  - Optional halal evidence publication

- **Shop / Marketplace Selling**

  - Product catalog
  - Inventory tracking
  - Shipping and pickup fulfillment

- **Point of Sale (POS) — MVP**

  - Cashier interface for in-store purchases
  - Register in-store sales at checkout
  - Generate receipts (digital or printable)
  - Sync in-store purchases to unified purchase history

- **Restaurant Operations**

  - Menu items
  - Dine-in / reservation / QR menu (v1.5)

- **Order Management**

  - Order inbox (online + POS)
  - Status updates

- **Promotions**

  - Coupons
  - Featured listings

- **Accounting (future)**

  - Bookkeeping (ledger, chart of accounts)
  - Invoicing and expense tracking
  - Tax-ready reporting exports

- **Payments / Gateway (future)**

  - Online payments for marketplace orders
  - In-store payment integrations (card/QR terminal integrations)
  - Payouts and settlement to merchants

A merchant may enable **one, multiple, or all** capabilities.

### 2.4 Capability lifecycle & enablement model

Each capability follows a **lifecycle**, inspired by cloud API enablement models (e.g., Google Cloud), but adapted for merchant UX and business setup.

**Capability states:**

- `disabled` — capability not enabled; UI and APIs are hidden
- `enabled_needs_setup` — capability enabled but requires configuration
- `active` — capability fully configured and usable
- `suspended` — temporarily disabled due to policy or merchant action

**Enablement flow:**

1. Merchant clicks **Enable** on a capability card.
2. Capability enters `enabled_needs_setup` state.
3. Halava launches a **guided setup flow**, which may include:
   - required configuration (e.g., receipt header for POS)
   - minimum data requirements (e.g., add at least one product)
   - role assignment (e.g., cashier staff for POS)
4. After successful setup, capability becomes `active`.

This ensures capabilities feel lightweight to enable, while remaining safe and predictable for business operations.

### 2.5 Why not force shop vs restaurant upfront

- Many halal businesses are **hybrid** (restaurant + grocery corner).
- Early classification increases onboarding drop-off.
- Capability-based enablement allows gradual adoption and clearer mental models.

---

## 3) Scope & release plan

### 3.1 MVP (v1) — “Discover + Shop + POS”

**Goal:** launch with a complete consumer-to-merchant transaction flow covering both online and in-store purchases.

#### Consumer MVP

- Authentication (email/OTP with passwordless approach; social optional)
- Location-based **directory** (map + list)
- Place pages: hours, photos, tags, and halal status disclosure (halal is assumed by default; a visible label such as "Certified" is shown only when the merchant publishes supporting evidence, e.g., a halal certificate).
- Search + filters: distance, open now, cuisine, amenities (e.g. prayer space)
- **Marketplace**: product catalog, cart, checkout, order tracking
- **Bulk / group purchases** (multiple users contribute to a shared order)
- **In-city group delivery (future)**
  - **Collaborative Shopping List:** Multiple users add items to a shared cart hosted by an "Initiator" (a regular user).
  - **Single Payer Model:** The Initiator pays the full amount (items + shipping) to the merchant in a single transaction. Reimbursement from friends is handled offline/externally.
  - **Dynamic Shipping:**
    - If the total order value exceeds the configurable minimum (e.g., ¥10,000), delivery is free.
    - Otherwise, the Initiator pays the standard shipping fee.
  - **Simplified Fulfillment:** The merchant receives and fulfills one single order. The Initiator is responsible for local distribution to participants.
  - **Transparency:** The Initiator receives a detailed breakdown (receipt) of "who ordered what" to facilitate offline collection.
- **Unified purchase history** (online purchases + POS-registered in-store purchases)
- **Buy-online–pick-up (BOPU)** options
- Reviews/ratings (places + products)
- Saved items

#### Merchant MVP (capability-driven)

- Merchant onboarding (business profile only)
- Enable **Directory Listing** capability
- Optional enable **Shop / Marketplace Selling** capability
- Enable **POS capability** for in-store sales
- Manage products (shared between online shop and POS)
- Orders dashboard (online orders + POS transactions)
- Inventory basics + low-stock alerts (online + in-store sales)
- Basic promotions (coupon codes)

### 3.2 v1.5 — “Restaurant Ops”

- Enable **Restaurant Operations** capability
- Menu management
- Reservations **or** QR menu (choose one initially)
- Advanced POS flows (tables, split bills, modifiers)
- Multi-language support (EN + JP + ID)

---

## 4) Core user journeys

### 4.1 Consumer — buy at a shop (online or in-store)

1. Discover a halal shop via search, map, or recommendations.
2. Browse products or scan items at the cashier (POS-assisted).
3. Complete purchase either:
   - **Online** (checkout with delivery or pickup), or
   - **In-store** (in-store purchase registered by the cashier via POS).
4. Receive a digital receipt and see the transaction recorded in purchase history.

### 4.2 Consumer — dine at a restaurant

1. Discover a halal restaurant via the directory.
2. Review menu, photos, tags, and halal status disclosure.
3. Visit the restaurant and place an order (in-store) or order ahead for pickup (if enabled).
4. Offline dining transactions may be recorded by the merchant via POS and linked to the consumer’s history (optional).

### 4.3 Consumer — compare prices using shopping history

1. Open **Purchase History**.
2. View past purchases across multiple shops (online + POS-registered in-store).
3. Compare prices for the same or similar products across different merchants.
4. Use historical pricing insights to decide where to buy next.

### 4.4 Merchant — initial registration

1. Sign up as a merchant.
2. Complete **basic business profile only** (no business type selection).
3. Land on merchant dashboard with suggested capabilities (Directory, POS, Shop).

### 4.5 Merchant — operate a shop with POS (MVP)

1. Enable **POS capability** from the dashboard.
2. Add or import products with prices and stock.
3. Use the cashier interface to register in-store purchases.
4. Generate receipts and complete payments in-store.
5. POS transactions sync to inventory and unified purchase history.

### 4.6 Merchant — enable online shop selling

1. Enable **Shop / Marketplace Selling** capability.
2. Reuse existing products from POS.
3. Configure fulfillment (shipping or pickup).
4. Receive and manage online orders.

### 4.7 Merchant — enable restaurant operations (later)

1. Enable **Restaurant Operations** capability.
2. Add menu items and pricing.
3. Configure reservations or QR menu.
4. Accept dine-in or pickup orders.

### 4.8 Moderator — maintain platform quality

1. Open the **Moderator Dashboard**.
2. Review incoming reports from consumers (misleading claims, spam, inappropriate content).
3. Inspect the reported entity (place, product, review, or media).
4. Take action as needed:
   - request clarification from the merchant,
   - hide or remove misleading content,
   - resolve or dismiss the report.
5. Review optional halal evidence publication for basic validity (presence, readability), **without certifying halal status**.
6. Record actions in the audit log and close the case.

### 4.9 Admin — operate and govern the platform

1. Open the **Admin Dashboard**.
2. Monitor overall platform health (active users, merchants, transactions, reports backlog).
3. Manage users and roles:
   - promote or demote moderators,
   - suspend or reinstate merchant or consumer accounts.
4. Oversee merchant lifecycle:
   - review newly registered merchants (basic checks only),
   - suspend capabilities or accounts in case of repeated policy violations.
5. Configure platform-wide settings:
   - categories, tags, cuisines, amenities,
   - capability availability and defaults.
6. Review audit logs for sensitive actions (moderation decisions, suspensions, capability changes).
7. Handle escalations that exceed moderator authority.
8. Maintain system integrity and compliance without acting as a halal certifying authority.

---

## 5) Roles & permissions

### 5.1 Roles

- Consumer
- Merchant Owner
- Merchant Staff (Cashier)
- Moderator
- Admin

### 5.2 Permission highlights

- **Owner:** enable capabilities, manage listings, products, POS settings, orders, staff, and optional halal evidence.
- **Staff (Cashier):** access POS, register in-store sales, view daily summaries.
- **Moderator:** handle user reports and content issues.
- **Admin:** full access and platform configuration.

---

## 6) Functional modules

### 6.1 Accounts & authentication

- Passwordless authentication (email OTP or magic link)
- User profile: name, phone (optional), preferences
- Merchant profile: business name and contact

### 6.2 Directory

- Business listing with geo, hours, photos, tags
- Halal status disclosure with optional evidence
- **Merchant-owned public pages** (e.g. `/m/{merchant-name}`):
  - Merchant branding (logo, colors, cover image)
  - **Reduced Halava branding with a lightweight global topbar**:
    - Breadcrumb-style identity: **Halava / {merchant-name}** (logo + merchant username)
    - Search bar with scope selector:
      - **This shop** (default when on merchant-owned pages)
      - **All of Halava** (global search across items, shops, and restaurants)
    - Quick navigation to explore other merchants or return to the marketplace
  - **Merchant-owned product experience (shopfront behavior)**:
    - Shopfront pages: `/m/{merchant-name}/shop` and `/m/{merchant-name}/products/{product-slug}`
    - Product detail emphasizes merchant context first (merchant name, pickup options, shop policies)
    - "Add to cart" keeps the user in the merchant shopfront by default
    - **Cart default (recommended for MVP): single-merchant cart**
      - If a user tries to add an item from a different merchant, prompt:
        - **Start a new cart** (recommended), or
        - **Switch merchant** (clears current cart)
      - This avoids complex cross-merchant fulfillment in MVP
    - Global discovery is still available via the topbar search (scope = All of Halava)
  - "Powered by Halava" footer
  - Shareable link suitable for social media and QR codes
  - Same trust, reporting, and moderation rules as directory pages

### 6.3 Marketplace

- Product catalog
- Cart & checkout
- Order lifecycle management
- Pickup and delivery flows

### 6.4 POS (MVP)

- Web-based cashier UI (tablet-friendly)
- Product search / barcode scan (optional)
- In-store sale registration (offline-capable: queue locally and sync when network is unavailable)
- Receipt generation
- Inventory deduction
- Sync with unified purchase history

### 6.5 Merchant console

### Merchant Dashboard — Information Architecture (IA)

The Merchant Dashboard is the **primary workspace** for merchants. All capabilities are accessed and enabled here.

**Top-level navigation (tabs or sidebar):**

1. **Overview**

   - Business summary (today’s sales, orders, inventory alerts)
   - Capability status summary (what is active / needs setup)
   - Quick actions (Open POS, Add product, Finish setup)

2. **Capabilities**

   - Capability cards (Directory, POS, Shop Selling, Restaurant Ops, Promotions)
   - Each card shows state: Disabled / Needs setup / Active / Suspended
   - Primary actions: Enable, Finish setup, Open, Settings

3. **Listings**

   - Business profile (hours, photos, tags, halal disclosure)
   - Location & contact info
   - Optional halal evidence publication

4. **Products & Menu**

   - Product list (shared across POS and online shop)
   - Menu items (visible only if Restaurant Ops enabled)
   - Pricing, stock, availability

5. **Orders & Transactions**

   - Online orders
   - POS transactions
   - Order / receipt details
   - Status filters and daily summaries

6. **Inventory**

   - Stock levels
   - Low-stock alerts
   - Inventory adjustments (manual / POS-driven)

7. **Promotions**

   - Coupons
   - Featured listings

8. **Staff & Roles**

   - Invite staff
   - Assign roles (Owner, Cashier)
   - Access control

9. **Settings**

   - Business settings
   - POS configuration (receipt header, tax rules)
   - Pickup / fulfillment settings

**IA principles:**

- Capabilities control **visibility** of sections (e.g., POS tab appears only when enabled).
- One product catalog shared across online shop and POS.
- Setup-required states always surface a clear call-to-action.

## 6.6 Admin & moderation

- Report handling
- User and merchant management

---

## 7) Web app pages & navigation map

This section enumerates the **actual pages that exist in the Halava web app**, organized by user role, and maps them to the **core user journeys** to ensure completeness. Pages are described by **purpose**, not fixed URLs, to avoid over‑constraining implementation.

### 7.1 Consumer-facing pages

- **Home / Explore (multi-merchant catalog)**

  - Primary marketplace view showing many items across shops and restaurants (trending items, categories, deals, nearby recommendations).
  - Global search and filters across merchants; users can discover items first, then choose a merchant.
  - Supports journeys: *4.1 Buy at a shop*, *4.2 Dine at a restaurant*.

- **Place page (shop or restaurant)**

  - Displays business details, photos, tags, halal status disclosure.
  - Entry to shopfront or menu.
  - Supports journeys: *4.1*, *4.2*.

- **Merchant-owned shopfront**

  - Merchant-branded public page (products, pickup options, policies).
  - Default search scope = this shop.
  - Supports journeys: *4.1 Buy at a shop*.

- **Product detail page**

  - Product information, price, merchant context, add-to-cart.
  - Supports journeys: *4.1 Buy at a shop*.

- **Cart & Checkout**

  - Single-merchant cart, delivery or pickup selection.
  - Supports journeys: *4.1 Buy at a shop*.

- **Purchase History**

  - Unified view of online orders and linked in-store receipts.
  - Enables historical price comparison.
  - Supports journeys: *4.3 Compare prices*.

- **Profile & Saved items**

  - Saved shops/products, preferences, receipts.
  - Supports journeys: *4.1*, *4.2*, *4.3*.

### 7.2 Merchant-facing pages

- **Merchant Dashboard (Overview)**

  - Business summary, alerts, quick actions.
  - Supports journeys: *4.4 Initial registration*.

- **Capabilities page**

  - Enable/disable merchant capabilities (POS, Shop, Restaurant Ops).
  - Supports journeys: *4.4*, *4.5*, *4.6*, *4.7*.

- **POS screen**

  - Cashier interface for in-store sales and receipt generation.
  - Supports journeys: *4.5 Operate shop with POS*.

- **Products & Menu management**

  - Manage product catalog and menus (capability-dependent).
  - Supports journeys: *4.5*, *4.6*, *4.7*.

- **Orders & Transactions**

  - Online orders and POS transactions.
  - Supports journeys: *4.5*, *4.6*.

- **Inventory management**

  - Stock levels, adjustments, alerts.
  - Supports journeys: *4.5*, *4.6*.

- **Merchant settings & staff**

  - Business configuration, staff roles.
  - Supports journeys: *4.4*, *4.5*.

### 7.3 Moderator pages

- **Moderator Dashboard**

  - Reports queue and case overview.
  - Supports journeys: *4.8 Moderator*.

- **Content review page**

  - Review reported places, products, reviews, or media.
  - Supports journeys: *4.8 Moderator*.

### 7.4 Admin pages

- **Admin Dashboard**

  - Platform health, metrics, backlog monitoring.
  - Supports journeys: *4.9 Admin*.

- **User & Merchant management**

  - Account lifecycle actions and role assignment.
  - Supports journeys: *4.9 Admin*.

- **Platform configuration**

  - Categories, tags, capability defaults.
  - Supports journeys: *4.9 Admin*.

- **Audit log viewer**

  - Trace sensitive actions and escalations.
  - Supports journeys: *4.9 Admin*.

### 7.5 UI components inventory (for UI generation)

This subsection serves as a **supporting reference** to Section 7 (Web app pages & navigation map). It enumerates the **reusable UI building blocks** required to implement the pages and user journeys defined earlier. The intent is not to introduce new scope, but to standardize components so UI generation tools (e.g., Manus AI) can compose consistent interfaces across consumer, merchant, moderator, and admin experiences. Components are grouped by functional role rather than by page.

### 7.5.1 Navigation & layout components

- **Global Topbar**
  - Variants: default marketplace, merchant-owned (breadcrumb: *Halava / {merchant}*).
  - Includes search bar with scope selector.
- **Sidebar / Tab Navigation** (merchant, moderator, admin dashboards)
- **Breadcrumbs** (contextual navigation)
- **Footer** (standard + "Powered by Halava" variant)

### 7.5.2 Discovery & catalog components

- **Search Bar** (with scope selector: This shop / All of Halava)
- **Filter Panel** (distance, category, cuisine, amenities)
- **Sort Selector** (trending, newest, nearby, price)
- **Product Card** (image, name, price, merchant, quick add)
- **Merchant Card / Place Card** (logo, tags, distance, status)
- **Category Grid / Carousel**

### 7.5.3 Commerce components

- **Add-to-Cart Button** (single-merchant enforcement logic)
- **Cart Drawer / Cart Page**
- **Checkout Stepper** (address → pickup/delivery → confirmation)
- **Order Summary Panel**
- **Receipt View** (online order or in-store POS receipt)

### 7.5.4 Merchant management components

- **Capability Card** (Disabled / Needs setup / Active / Suspended)
- **Setup Wizard** (multi-step, requirement-driven)
- **Product Editor Form**
- **Menu Editor Form**
- **Inventory Table** (stock, alerts, adjustments)
- **Order / Transaction Table**

### 7.5.5 POS components (MVP)

- **POS Item Grid / Search**
- **POS Cart Panel**
- **Payment Method Selector** (cash / card / QR / other)
- **Receipt Generator**
- **Sync Status Indicator** (e.g., Pending sync)

### 7.5.6 Social & trust components

- **Halal Disclosure Panel** (merchant-declared text)
- **Evidence Attachment Viewer** (read-only, optional)
- **Review Card**
- **Rating Input**
- **Report Content Modal**

### 7.5.7 Feedback & state components

- **Empty State** (no products, no orders, no history)
- **Loading Skeletons**
- **Toast / Snackbar Notifications**
- **Confirmation & Warning Modals** (e.g., switch merchant cart)
- **Error State Panels**

---


---

## 8) Non-functional requirements

This section defines **system-wide quality attributes** that are not tied to specific user features, but are critical to ensuring Halava is reliable, secure, and scalable as a platform. These requirements guide architectural decisions and help maintain consistent behavior across all modules (directory, marketplace, POS, and future capabilities).

- **Search p95 < 500 ms**

  - Ensures fast discovery and browsing, especially for location-based searches and merchant-owned pages.

- **POS actions p95 < 300 ms (local-first where possible)**

  - Guarantees responsive cashier workflows during in-store operations.
  - POS must remain usable under unstable network conditions by queuing actions locally and syncing later.

- **Secure uploads for optional evidence documents**

  - Protects sensitive merchant-uploaded files (e.g., certificates) through validation, storage isolation, and access control.

- **Audit logging for admin actions**

  - Provides traceability for sensitive operations such as moderation decisions, suspensions, and capability changes.

- **Future payments: PCI/security requirements will apply once Halava operates as a payment gateway**

  - Explicitly separates MVP scope from regulated financial operations.
  - Signals the need for stricter compliance, security audits, and infrastructure hardening in later phases.

---

## 9) High-level data model (conceptual)

- **MerchantCapability**(merchant\_id, capability\_type, status, enabled\_at, activated\_at)

  - `status`: disabled | enabled\_needs\_setup | active | suspended

- **POSTransaction**(id, merchant\_id, items, total, payment\_method, created\_at)

- **Place**, **Product**, **MenuItem** activated based on enabled capabilities

---

## 10) UX principle (key)

> **Merchants should never feel locked into a business type.**
>
> Halava grows with the merchant, not the other way around.

---

## 11) Acceptance criteria (MVP)

- Merchants can register in-store purchases via POS.
- POS transactions appear in consumers’ unified purchase history (when linked).
- Inventory updates correctly for both online and in-store sales.
- Consumers can perform bulk/group purchases and choose delivery or pickup.
- A merchant can register without selecting shop or restaurant.
- Capabilities can be enabled incrementally without data migration.

