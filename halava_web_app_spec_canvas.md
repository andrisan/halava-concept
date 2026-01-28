# Halava — Web App Spec (v1 → v1.5)

> **Last updated:** January 2026  
> **Status:** Active specification

---

## Version History

| Version | Date | Changes |
|---------|------|--------|
| v1.5 | Jan 2026 | Restaurant operations, advanced POS, multi-language |
| v1.0 | Dec 2025 | MVP: Discover + Shop + POS, capability-based merchant model |

---

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

- **Payments / Gateway (future — Phase 2)**

  - Integration with a licensed payment provider (e.g., Stripe Connect, PAY.JP) using a connected-accounts model
  - Online payments for marketplace orders (card, konbini, bank transfer via provider)
  - In-store payment integrations (card/QR terminal integrations)
  - Automated transaction fee deduction at source
  - Payouts and settlement to merchants on provider settlement cycles
  - Refund and dispute handling through the provider

A merchant may enable **one, multiple, or all** capabilities.

### 2.4 Why not force shop vs restaurant upfront

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
### 3.3 Future Scope (Post-v1.5)

- **In-city group delivery**
  - **Collaborative Shopping List:** Multiple users add items to a shared cart hosted by an "Initiator" (a regular user).
  - **Single Payer Model:** The Initiator pays the full amount (items + shipping) to the merchant in a single transaction. Reimbursement from friends is handled offline/externally.
  - **Dynamic Shipping:**
    - If the total order value exceeds the configurable minimum (e.g., ¥10,000), delivery is free.
    - Otherwise, the Initiator pays the standard shipping fee.
  - **Simplified Fulfillment:** The merchant receives and fulfills one single order. The Initiator is responsible for local distribution to participants.
  - **Transparency:** The Initiator receives a detailed breakdown (receipt) of "who ordered what" to facilitate offline collection.
- **Accounting capability** (bookkeeping, invoicing, tax exports)
- **Payments / Gateway capability — Phase 2** (licensed provider integration, automated fee deduction, in-store terminals, payouts)
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
5. Review optional halal evidence publication for basic validity:
   - Check for: presence of document, readability, obvious inconsistencies (e.g., expired date, different business name).
   - Moderators do **not** verify halal authenticity or contact certifying bodies.
   - If evidence appears fraudulent: flag for admin escalation, hide evidence pending review, notify merchant.
   - Consumer-facing disclaimer: *"Halal status is declared by the merchant. Halava does not certify or guarantee halal compliance."*
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
- **Search & discovery architecture:**
  - Location-based search using geo-indexing (e.g., PostGIS or equivalent)
  - Full-text search for products, merchants, and menu items
  - "Trending" is based on recent order volume and view count (simple heuristic, not ML)
  - "Recommendations" uses nearby + category-based matching for MVP; personalization deferred to post-MVP
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

#### 6.3.1 Payment Strategy (Phased)

Halava's payment approach evolves across two phases to balance speed-to-market against revenue enforcement and consumer trust.

**Phase 1 — MVP: Off-platform settlement (direct bank transfer)**

Halava does **not** process payments in MVP. The platform facilitates ordering; payment is settled directly between consumer and merchant.

- **Payment model:** Off-platform settlement (bank transfer or merchant-specified method).
- **Checkout flow:**
  1. Consumer places an order through the marketplace.
  2. Consumer receives merchant payment details (bank account, transfer instructions).
  3. Consumer completes the transfer outside Halava.
  4. Merchant confirms receipt of payment in the order dashboard.
  5. Order status moves to "confirmed" and fulfillment begins.
- Halava tracks order status but does not track payment status beyond merchant confirmation.
- **Transaction fee collection:** Honor-based. Halava invoices merchants monthly based on recorded order GMV. Merchants self-report; enforcement is limited.
- **Known trade-offs:** Lower consumer trust (paying a stranger's bank account), no automated refund path, manual confirmation is error-prone.

**Phase 2 — Post-traction: Licensed payment provider integration**

Once product-market fit is validated, Halava integrates a licensed payment provider (e.g., Stripe Connect, PAY.JP, Komoju, or GMO Payment Gateway) to intermediate payments.

- **Payment model:** Consumer pays through Halava's checkout. The payment provider splits the payment automatically — merchant receives their share, Halava's transaction fee is deducted at source.
- **Checkout flow:**
  1. Consumer places an order and completes payment in Halava's checkout (card, konbini payment, bank transfer via provider).
  2. Payment is confirmed automatically; order status moves to "confirmed."
  3. Merchant receives payout on a settlement cycle (e.g., T+3 to T+14 depending on provider and method).
- **Benefits:** Automated fee collection, consumer purchase protection, refund/dispute handling, higher trust.
- **Regulatory note:** Halava avoids the need for its own funds transfer license (資金移動業) by using a licensed provider's connected-accounts model. The provider holds the license; Halava operates as a platform.

**Design principle — Checkout abstraction:**

The checkout UI must be designed with a clear "payment step" placeholder from day one. The MVP shows merchant bank details in this step; Phase 2 replaces it with a payment form. This should be a UI-level swap, not an architecture change. The order model, cart, and fulfillment flow remain the same across both phases.

#### 6.3.2 Group Purchase Flow

Group purchases allow multiple consumers to contribute to a shared order for a single merchant.

- **Initiation:** A consumer (the "Initiator") creates a group purchase and receives a shareable invite link.
- **Participation:** Invited users open the link, join the group, and add items to the shared cart within a deadline set by the Initiator.
- **Finalization:** The Initiator reviews the combined order and submits it to the merchant as a single order.
- **Payment:** Single payer model — the Initiator pays the merchant. In MVP (Phase 1), this is a direct bank transfer; in Phase 2, the Initiator pays through Halava's checkout via the integrated payment provider. Participants reimburse the Initiator externally (outside Halava) in both phases.
- **Breakdown:** Halava provides a per-participant breakdown so the Initiator can facilitate collection from participants.
- **Thresholds (optional):** Merchants can set minimum order values for group purchases (e.g., free shipping above ¥10,000).

### 6.4 POS (MVP)

- Web-based cashier UI (tablet-friendly)
- Product search / barcode scan (optional)
- In-store sale registration (offline-capable: queue locally and sync when network is unavailable)
- Receipt generation
- Inventory deduction
- Sync with unified purchase history

#### 6.4.1 Consumer-to-POS Linking

POS transactions can be linked to consumer accounts so they appear in unified purchase history.

- **Primary method — QR code scan:** Consumer opens the Halava app and displays their personal QR code. The cashier scans it via the POS interface, linking the transaction to the consumer's account. The purchase then appears in the consumer's unified purchase history.
- **Fallback — Receipt claim code:** The POS generates a short alphanumeric code printed on the receipt. The consumer enters this code in-app later to claim the transaction and add it to their history.
- **Anonymous transactions:** If no linking occurs, the POS transaction is recorded for the merchant only (inventory tracking, sales reporting) but does not appear in any consumer's purchase history.

#### 6.4.2 Offline Sync & Conflict Resolution

The POS operates local-first to ensure usability under unstable network conditions.

- Transactions are queued locally when the device is offline.
- On reconnection, queued transactions sync to the server and inventory is adjusted accordingly.
- **Conflict handling:** If an item was sold online while the POS was offline, and stock drops below zero after sync:
  - The system flags the item as a **stock discrepancy**.
  - The merchant receives an alert with details of the conflicting transactions.
  - The merchant resolves the conflict manually (adjust stock count or cancel the conflicting order).
- **Resolution strategy:** Last-write-wins for non-critical fields (e.g., product descriptions). Stock conflicts always require merchant review.

#### 6.4.3 POS Transaction Quota & Top-ups

POS transactions are quota-based per membership tier (Free: 300/month, Growth: 3,000/month, Pro: unlimited). Merchants can purchase top-up packs when approaching or exceeding their quota.

**Quota enforcement:**
- **Hard cap with grace buffer:** When quota is exhausted, a 5-transaction grace buffer allows the merchant to complete immediate sales. Grace transactions are auto-billed (¥200 for 5).
- **No silent overages:** Transactions beyond quota + grace are blocked until the merchant tops up or upgrades.

**UX for quota management:**

- **No visible counter during normal operation.** Merchants should focus on serving customers, not watching a number.
- **Warning at 80%:** In-POS banner and dashboard notification: "You've used 80% of your POS quota this month. [Top up] [Upgrade plan]"
- **Warning at 100%:** Full-screen prompt before grace buffer is consumed, with clear options to top up or upgrade.
- **Quick top-up from POS:** One-tap purchase without leaving the cashier screen. Merchant confirms via PIN or biometric.
- **Auto top-up (opt-in):** Merchant can enable automatic top-up when quota reaches 80%. Configurable pack size (Small/Medium/Large).

**Top-up packs:**
- Small: 100 transactions / ¥300
- Medium: 300 transactions / ¥750
- Large: 500 transactions / ¥1,000

Top-ups expire at month end (no rollover). See monetization doc section 4.1 for full pricing rationale.

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

### 6.7 Notification System

#### MVP notification channels

- **In-app notifications:**
  - Order status changes (placed, confirmed, ready for pickup, fulfilled)
  - Group purchase invitations and updates (new participant joined, deadline approaching, order submitted)
  - Low-stock alerts (merchant-facing)
- **Email notifications:**
  - Order confirmation (consumer and merchant)
  - Group purchase summary (Initiator receives per-participant breakdown)
  - Merchant action required (e.g., pending order confirmation, stock discrepancy alert)

Push notifications (PWA push or native) are deferred to post-MVP.

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
- **Quota Warning Banner** (shown at 80% and 100% with top-up/upgrade CTA)
- **Quick Top-up Modal** (one-tap purchase, pack selection, PIN/biometric confirm)
- **Auto Top-up Settings** (opt-in toggle, pack size selection)

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

- **Availability target: 99.5% uptime for core services**

  - Directory, marketplace, and POS should remain available with minimal planned downtime.
  - POS offline mode provides resilience during network outages.

- **Data backup & recovery**

  - Daily automated backups with 30-day retention.
  - Point-in-time recovery capability for transaction data.
  - RTO (Recovery Time Objective): < 4 hours; RPO (Recovery Point Objective): < 1 hour.

- **Privacy & compliance**

  - User data handling follows Japan's APPI (Act on Protection of Personal Information).
  - Clear consent flows for data collection.
  - Right to data export and deletion upon user request.

- **Mobile strategy: Progressive Web App (PWA) first**

  - Responsive web app optimized for mobile browsers.
  - Installable as PWA on iOS/Android for app-like experience.
  - Native apps considered post-MVP based on user feedback and platform requirements.

---

## 9) High-level data model (conceptual)

- **MerchantCapability**(merchant\_id, capability\_type, status, enabled\_at, activated\_at)

  - `status`: disabled | enabled\_needs\_setup | active | suspended

- **POSTransaction**(id, merchant\_id, items, total, payment\_method, created\_at)

- **Place**, **Product**, **MenuItem** activated based on enabled capabilities

### Additional core entities (MVP)

- **User** (id, email, name, role, created\_at)
- **Order** (id, consumer\_id, merchant\_id, items, status, total, type \[online | group\], payment\_method, created\_at)
- **Cart** (id, consumer\_id, merchant\_id, items)
- **GroupPurchase** (id, initiator\_id, merchant\_id, invite\_link, deadline, status, order\_id)
- **Review** (id, consumer\_id, target\_type, target\_id, rating, text, created\_at)
- **Report** (id, reporter\_id, target\_type, target\_id, reason, status, moderator\_id)
- **Staff** (id, user\_id, merchant\_id, role)
- **Notification** (id, user\_id, type, payload, read, created\_at)
- **ConsumerPOSLink** (id, pos\_transaction\_id, consumer\_id, method \[qr | claim\_code\])

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

---

## Appendix A: API Strategy (Overview)

- **API style:** RESTful JSON APIs for MVP; GraphQL considered for v2 based on client needs.
- **Versioning:** URL-based versioning (e.g., `/api/v1/...`) for breaking changes.
- **Authentication:** OAuth 2.0 / JWT tokens for merchant and consumer APIs.
- **Rate limiting:** Applied to public endpoints to prevent abuse.
- **Documentation:** OpenAPI/Swagger specification maintained alongside implementation.

