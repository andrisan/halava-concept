# Halava — Web App Spec

> **Last updated:** February 2026
> **Status:** Active specification
>
> **Related documents:**
> - [halava_monetization_pricing_strategy_summary.md](halava_monetization_pricing_strategy_summary.md) — Pricing, fees, and investment staging
> - [halava_pitch_deck_outline_10_12_slides.md](halava_pitch_deck_outline_10_12_slides.md) — Investor presentation
> - [halava_pages_navigation_ux.md](halava_pages_navigation_ux.md) — Detailed pages, URL paths, and UI/UX specification

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

- **Consumer-First Growth:** Discovery, expense tracking, and group coordination drive organic adoption
- **Unified Commerce:** One platform for discovery, shopping, dining, and payments
- **Capability-Based Merchants:** Enable features incrementally; no business type lock-in
- **Halal Trust:** Merchant-declared status with optional evidence; transparent, no gatekeeping

---

## 2) Merchant capability model

### 2.1 Capability-based approach (recommended)

Merchants **do not choose** whether they are a restaurant or a shop during registration. Instead, Halava uses a **capability-based model**:

- A merchant account starts with **no assumptions** about business type.
- Merchants progressively **enable capabilities** as their business grows.
- Capabilities unlock UI, data models, workflows, and permissions.

This avoids early friction, supports hybrid businesses, and keeps the platform extensible.

### 2.2 Capability lifecycle

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

Capabilities are conceptually similar to *installable apps* (e.g., feature enablement), but implemented as **first-party modules** that affect UI, data models, and business workflows.

- **Directory Listing**

  - Business profile, location, photos, tags
  - Operating hours and contact information
  - Merchant-owned public pages (shareable storefronts)
  - Optional halal evidence publication

- **Shop / Marketplace Selling**

  - Product catalog
  - Cart & checkout with online order management
  - Inventory tracking with low-stock alerts
  - Shipping and pickup fulfillment (BOPU)

- **Point of Sale (POS)**

  - Cashier interface for in-store purchases
  - Register in-store sales at checkout
  - Generate receipts (digital or printable)
  - Sync in-store purchases to unified purchase history

- **Restaurant Operations**

  - Menu items
  - Dine-in / reservation / QR menu
  - **Food ordering** (unified flow, payment determines order type)
    - Pay online (bank transfer) → Online order → Order Inbox
    - Pay at counter (cash/card) → On-site order → POS queue
    - Real-time preparation status tracking
    - Push/in-app notifications when food is ready

- **Order Management**

  - Order inbox (online + POS)
  - Status updates
  - Kitchen order queue with preparation workflow
  - Payment processing (evolves through implementation phases — see section 6.3.1)

- **Promotions**

  - Coupons
  - Featured listings

- **Accounting (future)**

  - Bookkeeping (ledger, chart of accounts)
  - Invoicing and expense tracking
  - Tax-ready reporting exports

A merchant may enable **one, multiple, or all** capabilities.

**Note on payments:** Payment processing is not a separate capability but an integral part of Order Management. The payment infrastructure evolves through implementation phases (see 6.3.1 Payment Strategy) without requiring merchants to "enable" payments as a distinct feature.

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
- **Unified purchase history** (all orders: groceries, restaurant, dine-in, takeaway, pay online, pay at counter)
  - Enables personal expense tracking across all halal spending
  - Historical price comparison across merchants
- **Buy-online–pick-up (BOPU)** options
- Reviews/ratings (places + products)
- Saved items

#### Merchant MVP (capability-driven)

- Merchant onboarding (business profile only)
- Enable **Directory Listing** capability
- Merchant can enable **Shop / Marketplace Selling** capability
- Merchant can enable **POS capability** for in-store sales
- Manage products
- Orders dashboard (online orders + POS transactions)
- Inventory basics + low-stock alerts (online + in-store sales)
- Merchant can enable **Basic promotions (coupon codes) capability**

### 3.2 v1.1 — “Restaurant Ops”

- Enable **Restaurant Operations** capability
- Restaurant Menu management
- Reservations **or** QR menu (choose one initially)
- Advanced POS flows (tables, split bills, modifiers)
- Multi-language support (EN + JP + ID)

### 3.3 v1.3 - “Advanced Order & Accounting”

- **In-city group delivery**
  - **Collaborative Shopping List:** Multiple users add items to a shared cart hosted by an "Initiator" (a regular user).
  - **Single Payer Model:** The Initiator pays the full amount (items + shipping) to the merchant in a single transaction. Reimbursement from friends is handled offline/externally.
  - **Dynamic Shipping:**
    - If the total order value exceeds the configurable minimum (e.g., ¥10,000), delivery is free.
    - Otherwise, the Initiator pays the standard shipping fee.
  - **Simplified Fulfillment:** The merchant receives and fulfills one single order. The Initiator is responsible for local distribution to participants.
  - **Transparency:** The Initiator receives a detailed breakdown (receipt) of "who ordered what" to facilitate offline collection.
- **Advanced accounting capability** (bookkeeping, invoicing, tax exports)

---

## 4) Core user journeys

### 4.1 Consumer — buy at a shop online

1. Discover a halal shop via search, map, or recommendations.
2. Browse product catalog online.
3. Add items to cart and proceed to checkout.
4. Choose fulfillment method: delivery or pickup (BOPU).
5. Complete payment (Phase 1: bank transfer, Phase 2: in-app payment).
6. Receive order confirmation and tracking information.
7. Track order status until ready for delivery/pickup.
8. Receive products and digital receipt.
9. Transaction recorded in purchase history for expense tracking.

### 4.1.1 Consumer — buy at a shop in-store

1. Visit a halal shop physically.
2. Browse and select products in-store.
3. Bring items to cashier for checkout.
4. Cashier scans items via POS.
5. **Digital receipt option:** Cashier asks if customer wants to save receipt digitally.
   - **If yes:** Customer opens Halava app and displays personal QR code → cashier scans it → transaction linked to customer's account.
   - **If no:** Transaction recorded for merchant only (not linked to customer account).
6. **Receipt printing preference:** Customer chooses whether to print paper receipt or digital only.
7. Complete payment (cash, card, or other accepted methods).
8. **If digitally linked:** Transaction appears in customer's unified purchase history for expense tracking.

### 4.2 Consumer — order food at a restaurant

This journey covers consumers ordering food at restaurants. The ordering flow is **unified** for all order types: dine-in/takeaway, online/on-site — customers browse the menu, add items to cart, and choose their payment method at checkout, which determines how the order is processed.

**Overview:**

1. **Access menu:** Via QR code, storefront webpage, or Halava app.
2. **Browse and add to cart:** Select menu items, customizations, quantities.
3. **Select fulfillment:** Choose **Dine-in** or **Takeaway**.
4. **Checkout — choose payment method:**
   - **"Pay online"** → Bank transfer → Online order (goes to merchant's Order Inbox)
   - **"Pay at counter"** → Cash/card → On-site order (goes to POS queue as Prepared Order)
5. **Track preparation:** See real-time status updates (Confirmed → Preparing → Ready).
6. **Receive notification:** When food is ready for pickup or serving.
7. **Collect or receive food:** Pick up at counter (takeaway) or served at table (dine-in).
8. **Transaction recorded:** Appears in unified purchase history.

**Key features:**
- **Unified flow:** One ordering experience regardless of payment method or location.
- **Flexible payment:** Customer decides at checkout whether to pay online or at counter.
- **Real-time tracking:** Visual progress indicator and notifications.
- **Time selection (online dine-in only):** When paying online for dine-in, customers select when they want food ready, ensuring hot meals on arrival.

> **See Section 6.3.4 for detailed flows, order lifecycle, kitchen workflow, and merchant configuration.**

### 4.3 Consumer — track expenses and compare prices

All customer orders (groceries, restaurant meals, dine-in, takeaway, etc.) are stored in their account, enabling personal expense tracking and price comparison.

1. Open **Purchase History**.
2. View all past purchases across categories:
   - Shop/grocery orders (online and in-store)
   - Restaurant orders (pay online and pay at counter)
   - Dine-in and takeaway
3. **Track expenses:** Filter by date range, merchant, or category to see spending totals.
4. **Compare prices:** View historical prices for same or similar products across merchants.
5. Use insights to budget halal spending and decide where to buy next.

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

### 4.7.1 Merchant — manage online food orders (kitchen workflow)

1. **Receive order:** New online order appears in the Kitchen Order Queue with a notification sound/alert.
2. **Review order:** Staff views order details (items, modifiers, order type: takeaway/dine-in).
3. **Accept or adjust:** Staff accepts the order (optionally adjusts estimated prep time if needed).
4. **Mark as preparing:** Staff starts preparation; consumer sees status change to "Preparing".
5. **Mark as ready:** Staff marks order as ready when food is complete; consumer receives notification.
6. **Hand off:** 
   - Takeaway: Consumer shows order number/QR; staff hands over food and marks as fulfilled.
   - Dine-in: Staff calls order number or delivers to table; marks as fulfilled.
7. **Order complete:** Transaction finalized and recorded.

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

#### 6.3.3 Unified Item Model (Products & Menu Items)

Halava uses a **unified item model** to support hybrid businesses (e.g., a bakery that sells bread both for dine-in and retail). Products and menu items share a common base, with type-specific extensions.

**Why unified:**

- Many halal businesses are hybrid (restaurant + grocery corner).
- The capability-based model avoids forcing business types — items shouldn't be locked to one capability either.
- POS should scan/select any item seamlessly, whether it's a grocery product or a menu item.
- Same transaction fee structure applies to all online orders.
- Enables full-text search across "products, merchants, and menu items" from a single index.

**Data model:**

```
Item (unified base)
├── id, name, description, base_price, photos, halal_status
├── merchant_id
├── item_type: 'product' | 'menu_item' | 'hybrid'
├── enabled_channels: ['shop', 'restaurant', 'pos']
├── is_available: boolean (default: true)
│
├── ProductExtension (when item_type = 'product' or 'hybrid')
│   ├── stock_count
│   ├── low_stock_threshold
│   ├── sku, barcode, weight, dimensions, shipping_class
│
└── MenuItemExtension (when item_type = 'menu_item')
    └── modifiers[], prep_time_minutes, course_type, dietary_tags[]
    └── (no inventory tracking — availability controlled by is_available toggle)
```

**Inventory behavior by item type:**

| Item Type | Stock Behavior |
|-----------|----------------|
| **Product** (shop) | Counted inventory (`stock_count`), deducted on sale |
| **Menu item** (restaurant) | Always available unless toggled off (`is_available`) |
| **Hybrid** | Counted inventory (follows product behavior) |

**Design rationale:**

- **Products** require precise stock counts — customers expect to know if an item is in stock before ordering.
- **Menu items** are typically made-to-order; tracking ingredient inventory adds complexity without proportional value for MVP. Restaurants simply toggle `is_available = false` when an item is unavailable (e.g., sold out for the day, seasonal).
- **Hybrid items** (e.g., fresh bread sold at counter + retail) use counted inventory since stock is shared across channels.

**How visibility works:**

| Scenario | Customer View |
|----------|---------------|
| Menu item with `is_available: true` | Shown, orderable |
| Menu item with `is_available: false` | Hidden or marked "Unavailable" |
| Product with `stock_count > 0` | Shown, orderable |
| Product with `stock_count = 0` | Shown as "Out of stock" or hidden (merchant config) |

#### 6.3.4 Restaurant Food Ordering

Restaurants with the **Restaurant Operations** capability can accept food orders. The customer experience is **unified** — the only difference is **how they choose to pay** at checkout.

**Payment method determines order type:**

| Payment Choice | Order Type | Merchant Queue |
|----------------|------------|----------------|
| **Pay online** (bank transfer) | Online order | Order Inbox |
| **Pay at counter** (cash/card) | On-site order | POS (Prepared Orders) |

**Why this approach:**
- **One ordering flow** — no "on-site mode" vs "online mode" confusion
- **Customer decides at checkout** — payment choice is intuitive
- **Location-agnostic** — customer at restaurant can still pay online if they prefer
- **Simpler implementation** — no location detection needed

**Cart as central ordering mechanism:**

The **Cart** is the unified container for all order types — shop products, restaurant items, dine-in, takeaway. This provides:
- **Browsing freedom** — Customers take their time adding items
- **Review before commitment** — Modify cart contents before checkout
- **Consistent experience** — Same cart behavior across all scenarios
- **Cross-capability support** — Works for Shop and Restaurant Operations

---

**THE UNIFIED ORDERING FLOW**

1. **Access menu:** Via QR code, storefront webpage, or Halava app
2. **Browse and add to cart:** Select items, customizations, quantities
3. **Review cart:** Modify as needed
4. **Select fulfillment:** Dine-in or Takeaway
5. **Checkout — choose payment:**
   - **"Pay online"** → Bank transfer (Phase 1) / in-app (Phase 2) → **Online order**
   - **"Pay at counter"** → Creates **Prepared Order** → **On-site order**

---

**PATH A: PAY ONLINE (Bank Transfer)**

Goes to merchant's **Order Inbox** as an online order.

**Online → Takeaway:**
1. Customer submits order with "Pay online"
2. Customer completes bank transfer
3. Merchant verifies payment → kitchen starts cooking
4. Customer tracks status: Preparing → Ready
5. Customer arrives, shows order number/QR, picks up packed food

**Online → Dine-in (customer selects desired ready time):**
1. Customer submits order with "Pay online"
2. **Selects desired ready time:** Picks when food should be ready (e.g., "Ready at 6:15 PM")
3. Customer completes bank transfer
4. **Payment verified:** Status → "Confirmed (Paid, Ready at 6:15 PM)"
5. **Kitchen sees order with time target:** Prepares food to be ready exactly at selected time
6. Customer travels to restaurant and arrives by desired time
7. **Notification reminder:** *"Your order will be ready at 6:15 PM!"* (5 min before)
8. **Order becomes ready:** Kitchen marks order ready at target time; customer notified
9. **Food served fresh:** Staff delivers hot food to table immediately

**Why time-selection for online dine-in:**

| Advantage | Benefit |
|-----------|----------|
| Kitchen visibility | Knows exact time customer will arrive |
| Fresh food | Prep timed to prevent cold meals |
| Payment verified first | No food waste from unpaid orders |
| Simple UX | No manual arrival confirmation needed |

---

**PATH B: PAY AT COUNTER (Cash/Card)**

Goes to merchant's **POS queue** as a Prepared Order. **Restaurant-specific** — shops cannot do this because cashiers must scan physical items.

**At Counter → Dine-in:**
1. Customer selects "Pay at counter" → creates Prepared Order
2. Customer goes to cashier (or cashier comes to table)
3. Cashier pulls up order, reviews, can modify if needed
4. Customer pays (cash, card, or any accepted method)
5. Receipt preference: digital only or digital + paper
6. Kitchen receives order immediately
7. Food prepared and served at table

**At Counter → Takeaway:**
1. Customer selects "Pay at counter" → creates Prepared Order
2. Customer goes to cashier
3. Cashier reviews order, can modify if needed
4. Customer pays
5. Kitchen prepares for packing
6. Customer picks up packed food

**Why "Pay at counter" is useful:**
- **Supports cash** — common in halal restaurants
- **Instant confirmation** — no waiting for bank transfer
- **Flexible modifications** — cashier can adjust order
- **Kitchen starts immediately** — no cold food risk

---

**Comparison with shop ordering:**

| Capability | Pay Online | Pay at Counter |
|------------|------------|----------------|
| **Restaurant** | ✅ Online order (Order Inbox) | ✅ On-site order (POS queue) |
| **Shop/Grocery** | ✅ Online order (Order Inbox) | ❌ Not applicable (cashier must scan items) |

```
ONLINE DINE-IN FLOW (time-selected):

┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Placed    │───▶│  Confirmed  │───▶│  Preparing  │───▶│    Ready    │───▶│  Fulfilled  │
│  (Payment   │    │   (Paid,    │    │             │    │   (Ready    │    │             │
│   + Time)   │    │  Ready@6:15)│    │             │    │   @6:15)    │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
     │                   │                  │                  │                  │
     ▼                   ▼                  ▼                  ▼                  ▼
  Consumer           Kitchen has        Kitchen            Food ready         Food served
  selects ready      timing target      starts cooking     on schedule        fresh at table
  time               and preps          to hit target
```

**Time selection at checkout:**

At checkout step, customer sees time picker with suggested options:
- Current time + 15 min (default, "ready soon")
- Current time + 30 min
- Current time + 45 min
- Current time + 60 min
- Custom time selection

Restaurant uses selected time to plan kitchen workflow backwards.

**Edge cases:**

| Situation | Handling |
|-----------|----------|
| Customer arrives before ready time | Food is held in kitchen; served when customer arrives |
| Customer runs late and misses ready time | Kitchen holds food warm for 10 min, then notifies merchant. Order can be remade if requested. |
| Customer wants to change ready time | Before checkout: change time picker. After order placed: contact merchant or reschedule. |
| High-traffic period: kitchen can't meet target time | Merchant adjusts prep time estimates before accepting order (system prevents over-booking). |
| Customer no-show | Order marked unfulfilled after 30 min grace period. Merchant notes for refund/cancellation handling. |

**Order lifecycle & statuses:**

The order lifecycle differs based on order type and payment phase:

**Online orders (Takeaway & Dine-in) — Phase 1 (bank transfer):**

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Placed    │───▶│   Pending   │───▶│  Confirmed  │───▶│  Preparing  │───▶│    Ready    │───▶│  Fulfilled  │
│             │    │   Payment   │    │   (Paid)    │    │             │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
     │                   │                  │                  │                  │                  │
     ▼                   ▼                  ▼                  ▼                  ▼                  ▼
  Consumer           Consumer           Merchant            Kitchen            Consumer           Order
  submits            transfers          verifies            starts             notified           complete
  order              money              payment             cooking
```

**Online orders — Phase 2 (in-app payment):**

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Placed    │───▶│  Confirmed  │───▶│  Preparing  │───▶│    Ready    │───▶│  Fulfilled  │
│  + Paid     │    │             │    │             │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
     │                   │                  │                  │                  │
     ▼                   ▼                  ▼                  ▼                  ▼
  Consumer           Payment             Kitchen            Consumer           Order
  pays at            auto-confirmed      starts             notified           complete
  checkout                               cooking
```

**Pay at counter (Prepared Order → POS):**

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Prepared   │───▶│  Confirmed  │───▶│  Preparing  │───▶│    Ready    │───▶│  Fulfilled  │
│   Order     │    │ (Paid@POS)  │    │             │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
     │                   │                  │                  │                  │
     ▼                   ▼                  ▼                  ▼                  ▼
  Consumer           Consumer            Kitchen            Consumer           Food
  selects            pays at             starts             notified           served
  "Pay at counter"   cashier (POS)       cooking
```

| Status | Who triggers | Consumer sees | Merchant action |
|--------|--------------|---------------|-----------------|
| **Placed** | Consumer | "Order submitted" | — |
| **Pending Payment** | System (Phase 1 only) | "Awaiting payment confirmation" | Verify bank transfer received |
| **Prepared Order** | Consumer (at-table only) | "Take this to the cashier to pay" | — |
| **Confirmed** | Merchant or auto | "Payment confirmed!" | Accept order, set prep time |
| **Preparing** | Merchant | "Your food is being prepared" + ETA | Mark when cooking starts |
| **Ready** | Merchant | 🔔 "Your order is ready!" | Mark when food is complete |
| **Fulfilled** | Merchant | "Order complete" | Hand off food to consumer |
| **Cancelled** | Either party | "Order cancelled" | Cancel with reason |

**Critical rule: Kitchen starts cooking ONLY after payment is confirmed.**

This prevents:
- Food waste from unpaid orders (Phase 1 bank transfer risk)
- Kitchen capacity being blocked by pending orders
- Customer disputes about "I paid but no food"

**Consumer waiting experience:**

- **Order tracking page:** Dedicated page showing real-time order status with visual progress indicator.
- **Estimated time:** Display estimated preparation time (merchant-set default or adjusted per order).
- **Countdown/timer:** Optional countdown showing "Ready in ~X minutes" when status is "Preparing."
- **Refresh-free updates:** WebSocket or polling for real-time status changes without page refresh.
- **Order details:** Show ordered items, order number, and pickup instructions.

**Notification strategy:**

| Event | In-app | Push (post-MVP) | Email |
|-------|--------|-----------------|-------|
| Order placed/confirmed | ✓ | — | ✓ (confirmation) |
| Pending payment reminder (Phase 1) | ✓ | ✓ | ✓ |
| Payment verified | ✓ | — | — |
| Ready time reminder (5 min before) | ✓ | ✓ | — |
| Preparing | ✓ | — | — |
| **Ready for pickup/serving** | ✓ | ✓ | ✓ (with order #) |
| Fulfilled | ✓ | — | — |
| Cancelled | ✓ | ✓ | ✓ (with reason) |

**Pickup/serving flow by payment type:**

**PAY AT COUNTER (On-site order → POS):**

- **At Counter → Dine-in:**
  1. Consumer browses → adds to cart → selects "Pay at counter" → creates Prepared Order.
  2. Consumer pays at cashier (cash/card/any method).
  3. Payment confirmed → order sent to kitchen immediately.
  4. Consumer returns to table; kitchen cooks.
  5. Staff delivers food to table or consumer collects from counter.
  6. Staff marks order as "Fulfilled."

- **At Counter → Takeaway:**
  1. Consumer browses → adds to cart → selects "Pay at counter" → creates Prepared Order.
  2. Consumer pays at cashier.
  3. Payment confirmed → order sent to kitchen for packing.
  4. Consumer waits nearby.
  5. Staff hands over packed food.
  6. Staff marks order as "Fulfilled."

**PAY ONLINE (Online order → Order Inbox):**

- **Online → Takeaway:**
  1. Consumer browses → adds to cart → selects "Pay online" → completes bank transfer.
  2. Payment confirmed → kitchen starts cooking.
  3. Consumer arrives when notified "Ready."
  4. Shows order number/QR; staff hands over packed food.
  5. Staff marks order as "Fulfilled."

- **Online → Dine-in (time-selected):**
  1. Consumer browses → adds to cart → selects "Pay online" → selects desired ready time.
  2. Consumer completes bank transfer.
  3. Payment confirmed → kitchen sees target ready time and preps accordingly.
  4. Consumer travels to restaurant and arrives by desired time.
  5. Order becomes ready at scheduled time; consumer is notified.
  6. Staff delivers hot food to table immediately.
  7. Staff marks order as "Fulfilled."

**Merchant kitchen interface:**

- **Kitchen Order Queue (KOQ):** Dedicated view for kitchen staff showing incoming orders.
- **Order cards:** Each order displayed as a card with items, modifiers, order type, and elapsed time.
- **Quick actions:** One-tap buttons for "Accept," "Start Preparing," "Mark Ready."
- **Sound/visual alerts:** Audio notification for new orders; orders turn red when exceeding expected prep time.
- **Order prioritization:** Configurable display order (FIFO by default, or by promised pickup time).

**Configuration options (merchant settings):**

- **Enable food ordering:** Toggle to accept food orders.
- **Payment methods accepted:**
  - Pay online (bank transfer) — goes to Order Inbox
  - Pay at counter (cash/card) — goes to POS queue (Prepared Orders) — **restaurant-specific**
- **Fulfillment types:** Dine-in, Takeaway, or both.
- **Default prep time:** Estimated minutes for order preparation (e.g., 15 min).
- **Auto-accept orders:** Automatically set status to "Confirmed" or require manual acceptance.
- **Pickup instructions:** Custom text shown to consumers (e.g., "Pick up at counter B").
- **Operating hours for online orders:** May differ from walk-in hours.
- **Order capacity:** Optional limit on concurrent orders to prevent kitchen overload.
- **Online dine-in settings:**
  - **Prep time buffer:** Time added to customer's selected ready time for kitchen prep (default: 0 min, can be negative if kitchen prepares early).
  - **Default suggested time:** Recommended time-from-now for new orders (default: 15 min).
  - **Max advance booking:** How far ahead customers can select ready time (default: 2 hours).
  - **Hold time:** How long kitchen will keep food warm after ready time before notifying merchant (default: 10 min).

### 6.4 POS (MVP)

- Web-based cashier UI (tablet-friendly)
- Product search / barcode scan (optional)
- In-store sale registration (offline-capable: queue locally and sync when network is unavailable)
- Receipt generation (digital and/or paper)
- Inventory deduction
- Sync with unified purchase history
- **Prepared Order queue** (for "Pay at counter" orders)

#### 6.4.1 Prepared Orders (Pay at Counter → POS)

When customers select "Pay at counter" at checkout, they create a **Prepared Order** that appears in the merchant's POS queue. The cashier completes the payment.

**How customers create Prepared Orders:**
- Browse menu (via QR, storefront, or app)
- Add items to cart
- Select fulfillment (dine-in or takeaway)
- Choose **"Pay at counter"** at checkout

**Flow:**

1. **Customer browses and adds to cart** → via QR scan, storefront, or app.
2. **Customer reviews cart** → modifies quantities, removes items as needed.
3. **Customer selects fulfillment** → Dine-in or Takeaway.
4. **Customer selects "Pay at counter"** → creates a **Prepared Order** with:
   - Unique order code (e.g., "A-23")
   - Table number (if QR is table-specific)
   - Selected items and modifiers
   - Fulfillment type (dine-in/takeaway)
   - Status: "Awaiting Payment"
6. **Prepared Order appears in POS queue** → cashier sees new pending order.
7. **Customer approaches cashier** (or cashier goes to table with mobile POS).
8. **Cashier selects the Prepared Order** → reviews items with customer.
9. **Order modification at checkout (if needed):**
   - Cashier can **remove items** — shown as ~~crossed out~~ on customer's order
   - Cashier can **modify quantities** — adjustment reflected on customer's order
   - Cashier can **add new items** — customer wants to add more at checkout
   - All changes sync to customer's device in real-time
10. **Receipt preference** → Customer chooses: digital only or digital + paper.
11. **Customer pays** → cash, card, QR payment, or any method the restaurant accepts.
12. **Cashier confirms payment in POS** → order status = "Confirmed" → sent to Kitchen Order Queue.
13. **Transaction counted** → Counts against merchant's POS quota (see 6.4.4).
14. **Kitchen cooks** → normal preparation flow.
15. **Food served** → order marked "Fulfilled."
16. **Transaction recorded** → Appears in customer's purchase history for expense tracking.

**Order modification display (customer view):**

When cashier modifies an order at checkout, customer sees changes reflected:
- **Removed items:** ~~Nasi Goreng x1~~ (crossed out, shows as removed)
- **Quantity changes:** Teh Tarik x~~2~~1 (original crossed, new shown)
- **Added items:** Roti Canai x1 *(added at checkout)* (marked as addition)

**POS Prepared Order Queue UI:**

- **Pending orders list:** Shows all Prepared Orders awaiting payment.
- **Order card:** Displays order code, table number, items, fulfillment type, and time since created.
- **Quick actions:** "Open order" → review and complete payment.
- **Edit mode:** Modify items, quantities, or add new items before payment.
- **Auto-expire:** Prepared Orders expire after configurable timeout (default: 30 min) if not paid.

**Unclaimed Prepared Orders:**

At end of day (or anytime), merchants can clear unclaimed Prepared Orders:
- **Clear action:** Merchant selects "Clear unclaimed orders" in POS.
- **No quota impact:** Cleared (unpaid) orders do **not** count against POS transaction quota.
- **Reason:** These are abandoned carts, not completed sales — no value exchanged.
- **Audit trail:** Cleared orders are logged for reference but not billed.

**Benefits:**

- Customers browse at their own pace — no pressure to decide quickly
- Cashier can accommodate last-minute changes — flexible checkout
- Kitchen receives accurate, typed orders — no handwriting issues
- Works with any payment method the restaurant already accepts
- Fair quota counting — only successful transactions are billed

#### 6.4.2 Consumer-to-POS Linking

POS transactions can be linked to consumer accounts so they appear in unified purchase history.

- **Primary method — QR code scan:** Consumer opens the Halava app and displays their personal QR code. The cashier scans it via the POS interface, linking the transaction to the consumer's account. The purchase then appears in the consumer's unified purchase history.
- **Fallback — Receipt claim code:** The POS generates a short alphanumeric code printed on the receipt. The consumer enters this code in-app later to claim the transaction and add it to their history.
- **Anonymous transactions:** If no linking occurs, the POS transaction is recorded for the merchant only (inventory tracking, sales reporting) but does not appear in any consumer's purchase history.

#### 6.4.3 Offline Sync & Conflict Resolution

The POS operates local-first to ensure usability under unstable network conditions.

- Transactions are queued locally when the device is offline.
- On reconnection, queued transactions sync to the server and inventory is adjusted accordingly.
- **Conflict handling:** If an item was sold online while the POS was offline, and stock drops below zero after sync:
  - The system flags the item as a **stock discrepancy**.
  - The merchant receives an alert with details of the conflicting transactions.
  - The merchant resolves the conflict manually (adjust stock count or cancel the conflicting order).
- **Resolution strategy:** Last-write-wins for non-critical fields (e.g., product descriptions). Stock conflicts always require merchant review.

#### 6.4.4 POS Transaction Quota & Top-ups

POS transactions are quota-based per membership tier (Free: 300/month, Growth: 3,000/month, Pro: unlimited). Merchants can purchase top-up packs when approaching or exceeding their quota.

**What counts as a transaction:**

| Action | Counts Against Quota? | Reason |
|--------|----------------------|--------|
| **Completed sale (payment confirmed)** | ✓ Yes | Value exchanged — this is the billable event |
| **Prepared Order created by customer** | ✗ No | Not a sale yet — just a cart submitted |
| **Prepared Order cleared/expired (unpaid)** | ✗ No | Abandoned cart — no value exchanged |
| **Prepared Order cancelled before payment** | ✗ No | No sale occurred |
| **Order modified at checkout** | ✗ No | Modifications are part of the sale, not separate transactions |

**Key principle:** Only **successful, paid transactions** count against the quota. Creating, editing, or clearing unpaid Prepared Orders has no quota impact.

**Quota enforcement:**
- **Hard cap with grace buffer:** When quota is exhausted, a 5-transaction grace buffer allows the merchant to complete immediate sales. Grace transactions are auto-billed at ¥75 (¥15/transaction) — 6–8x more expensive than planned top-ups to discourage reliance.
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
  - **Food order preparation updates** (received, preparing, ready — with visual progress)
  - **"Your order is ready!" alert** (prominent notification when food is ready for pickup)
  - Group purchase invitations and updates (new participant joined, deadline approaching, order submitted)
  - Low-stock alerts (merchant-facing)
  - New kitchen order alerts (merchant-facing, with sound option)
- **Email notifications:**
  - Order confirmation (consumer and merchant)
  - **Food order ready for pickup** (with order number and pickup instructions)
  - Group purchase summary (Initiator receives per-participant breakdown)
  - Merchant action required (e.g., pending order confirmation, stock discrepancy alert)

Push notifications (PWA push or native) are deferred to post-MVP.

---

## 7) Web app pages & navigation map

> **📄 This section has been moved to a dedicated document for detailed UI/UX implementation.**
>
> See: **`halava_pages_navigation_ux.md`**

The dedicated document provides:

- **Complete URL routing map** with explicit paths for all pages
- **Detailed page layouts** with ASCII wireframes for every screen
- **Component specifications** for UI implementation
- **User flow mappings** connecting pages to user journeys
- **Responsive design guidelines** for mobile, tablet, and desktop
- **Authentication flows** and state management

This separation allows the pages specification to serve as a standalone reference for AI agents and frontend developers implementing the Halava web application.

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

- **Mobile strategy: Progressive Web App (PWA)**

  - Responsive web app optimized for mobile browsers.
  - Installable as PWA on iOS/Android for app-like experience.

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

