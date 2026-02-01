# Halava — Web App Pages & Navigation UX Specification

> **Last updated:** February 2026
> **Status:** Active specification
> **Parent document:** [halava_web_app_spec_canvas.md](halava_web_app_spec_canvas.md)
>
> This document provides the comprehensive UI/UX specification for all pages and navigation flows in the Halava web application. It is designed as a standalone reference for AI agents and developers to implement every page with precise URL paths, layouts, components, and user interactions.

---

## Table of Contents

1. [URL Structure & Routing Architecture](#1-url-structure--routing-architecture)
2. [Consumer-Facing Pages](#2-consumer-facing-pages)
3. [Merchant-Facing Pages](#3-merchant-facing-pages)
4. [Moderator Pages](#4-moderator-pages)
5. [Admin Pages](#5-admin-pages)
6. [Authentication Pages](#6-authentication-pages)
7. [UI Components Inventory](#7-ui-components-inventory)
8. [Navigation Patterns](#8-navigation-patterns)
9. [Responsive Design Guidelines](#9-responsive-design-guidelines)

---

## 1. URL Structure & Routing Architecture

### 1.1 URL Naming Conventions

Halava uses a consistent, RESTful URL structure designed for clarity and SEO optimization.

**Core principles:**
- Lowercase, hyphen-separated slugs (e.g., `/purchase-history`, not `/purchaseHistory`)
- Resource-based paths (e.g., `/products/{slug}`, `/orders/{id}`)
- Merchant-namespaced paths for merchant-owned pages (`/m/{merchant-slug}/...`)
- Dashboard paths grouped by role (`/dashboard/...`, `/admin/...`, `/mod/...`)
- Query parameters for filtering and search (e.g., `?category=food&sort=trending`)

### 1.2 Complete URL Map

#### Public (Consumer) Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/` | Home / Explore | Primary marketplace landing page |
| `/search` | Search Results | Global search results across all merchants |
| `/search?q={query}&scope=all` | Global Search | Search across all of Halava |
| `/categories` | Category Browse | All product/menu categories |
| `/categories/{category-slug}` | Category Page | Items within a specific category |
| `/places` | Places Directory | Map + list view of all merchants |
| `/places/{merchant-slug}` | Place Page | Business details, photos, halal status |
| `/m/{merchant-slug}` | Merchant Shopfront | Merchant-owned branded storefront |
| `/m/{merchant-slug}/shop` | Merchant Shop | Product catalog for a specific merchant |
| `/m/{merchant-slug}/menu` | Merchant Menu | Restaurant menu for a specific merchant |
| `/m/{merchant-slug}/products/{product-slug}` | Product Detail | Single product page within merchant context |
| `/m/{merchant-slug}/menu/{item-slug}` | Menu Item Detail | Single menu item page within merchant context |
| `/cart` | Shopping Cart | Current cart contents and actions |
| `/checkout` | Checkout | Multi-step checkout flow |
| `/checkout/payment` | Payment Step | Payment method selection and completion |
| `/checkout/confirmation` | Order Confirmation | Post-checkout confirmation page |
| `/orders` | My Orders | List of all consumer orders |
| `/orders/{order-id}` | Order Detail | Single order details and tracking |
| `/orders/{order-id}/track` | Order Tracking | Real-time order status tracking |
| `/purchase-history` | Purchase History | Unified expense tracking view |
| `/group-purchase/{invite-code}` | Group Purchase Join | Join a group purchase via invite link |
| `/group-purchase/{id}/manage` | Group Purchase Manage | Initiator's view to manage group order |
| `/saved` | Saved Items | Saved products, places, and searches |
| `/profile` | User Profile | Personal settings and preferences |
| `/profile/receipts` | My Receipts | Digital receipt archive |
| `/profile/settings` | Account Settings | Account configuration |
| `/notifications` | Notifications | In-app notification center |

#### Merchant Dashboard Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/dashboard` | Merchant Dashboard | Overview and quick actions |
| `/dashboard/capabilities` | Capabilities | Enable/configure business capabilities |
| `/dashboard/capabilities/{capability}/setup` | Capability Setup | Setup wizard for a specific capability |
| `/dashboard/listings` | Business Listing | Manage business profile and location |
| `/dashboard/listings/halal-evidence` | Halal Evidence | Upload/manage halal certificates |
| `/dashboard/products` | Products & Menu | Product and menu item management |
| `/dashboard/products/new` | Add Product | Create new product/menu item |
| `/dashboard/products/{id}/edit` | Edit Product | Modify existing product |
| `/dashboard/orders` | Orders & Transactions | All orders and POS transactions |
| `/dashboard/orders/{id}` | Order Detail | Single order management |
| `/dashboard/kitchen` | Kitchen Order Queue | Real-time kitchen order management |
| `/dashboard/inventory` | Inventory | Stock levels and alerts |
| `/dashboard/promotions` | Promotions | Coupons and featured listings |
| `/dashboard/promotions/coupons/new` | Create Coupon | New coupon creation |
| `/dashboard/staff` | Staff & Roles | Team member management |
| `/dashboard/staff/invite` | Invite Staff | Invite new team member |
| `/dashboard/settings` | Settings | Business and POS configuration |
| `/dashboard/settings/pos` | POS Settings | POS-specific configuration |
| `/dashboard/settings/fulfillment` | Fulfillment Settings | Pickup and delivery options |
| `/dashboard/analytics` | Analytics | Sales and performance metrics |

#### POS Routes (Merchant Staff)

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/pos` | POS Main Screen | Primary cashier interface |
| `/pos/prepared-orders` | Prepared Orders Queue | Orders awaiting payment |
| `/pos/transactions` | Today's Transactions | Daily transaction history |
| `/pos/transactions/{id}` | Transaction Detail | Single POS transaction |
| `/pos/transactions/{id}/receipt` | Receipt View | Printable/digital receipt |

#### Moderator Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/mod` | Moderator Dashboard | Reports queue and overview |
| `/mod/reports` | Reports Queue | All pending reports |
| `/mod/reports/{id}` | Report Detail | Single report review |
| `/mod/content/{type}/{id}` | Content Review | Review specific content item |
| `/mod/history` | Action History | Moderator's past actions |

#### Admin Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/admin` | Admin Dashboard | Platform health and metrics |
| `/admin/users` | User Management | All platform users |
| `/admin/users/{id}` | User Detail | Single user management |
| `/admin/merchants` | Merchant Management | All merchants |
| `/admin/merchants/{id}` | Merchant Detail | Single merchant management |
| `/admin/config` | Platform Configuration | Categories, tags, defaults |
| `/admin/config/categories` | Category Management | Manage product categories |
| `/admin/config/tags` | Tag Management | Manage merchant tags |
| `/admin/config/capabilities` | Capability Defaults | Default capability settings |
| `/admin/audit-log` | Audit Log | System-wide audit trail |
| `/admin/escalations` | Escalations | Escalated moderation cases |

#### Authentication Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/auth/login` | Login | Passwordless login entry |
| `/auth/verify` | Verify OTP | OTP/magic link verification |
| `/auth/register` | Register | New user registration |
| `/auth/merchant/register` | Merchant Registration | New merchant onboarding |
| `/auth/logout` | Logout | Session termination |

---

## 2. Consumer-Facing Pages

### 2.1 Home / Explore Page

**URL:** `/`

**Purpose:** Primary marketplace landing page where consumers discover halal products, restaurants, and shops across all merchants.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
│ [Logo] [Search Bar (scope: All of Halava)] [Location] [Profile] │
├─────────────────────────────────────────────────────────────────┤
│ HERO SECTION                                                    │
│ - Welcome message / seasonal promotion                          │
│ - Quick category shortcuts (Food, Groceries, Restaurants)       │
├─────────────────────────────────────────────────────────────────┤
│ TRENDING NOW                                                    │
│ [Product Card] [Product Card] [Product Card] [Product Card] →   │
├─────────────────────────────────────────────────────────────────┤
│ NEARBY RESTAURANTS                                              │
│ [Merchant Card] [Merchant Card] [Merchant Card] →               │
├─────────────────────────────────────────────────────────────────┤
│ CATEGORIES                                                      │
│ [Category Grid: Halal Meat, Bakery, Indonesian, Japanese, ...]  │
├─────────────────────────────────────────────────────────────────┤
│ DEALS & PROMOTIONS                                              │
│ [Promotion Banner] [Coupon Highlight]                           │
├─────────────────────────────────────────────────────────────────┤
│ FOOTER                                                          │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Global Topbar:** Logo, search bar with "All of Halava" scope, location selector, user profile menu
- **Hero Section:** Dynamic banner with seasonal promotions or onboarding prompt for new users
- **Trending Now:** Horizontal scrollable carousel of products based on recent order volume and views
- **Nearby Restaurants:** Location-based merchant cards showing distance, cuisine type, and halal status
- **Category Grid:** Visual grid of product/cuisine categories for quick navigation
- **Deals Section:** Active promotions and featured listings

**User Interactions:**
- Clicking search bar navigates to `/search` with focus on input
- Clicking a product card navigates to `/m/{merchant-slug}/products/{product-slug}`
- Clicking a merchant card navigates to `/places/{merchant-slug}`
- Category clicks navigate to `/categories/{category-slug}`
- Location selector opens modal to set/update user location

**State Variations:**
- **First-time visitor:** Shows onboarding prompt and location permission request
- **Returning user:** Personalized "Continue where you left off" section
- **Empty location:** Prompts user to set location for relevant results

---

### 2.2 Search Results Page

**URL:** `/search?q={query}&scope={all|merchant-slug}&category={category}&sort={trending|price|distance}`

**Purpose:** Display search results across products, menu items, and merchants with filtering capabilities.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR with active search query                          │
├─────────────────────────────────────────────────────────────────┤
│ SEARCH CONTROLS                                                 │
│ [Search Bar] [Scope: All of Halava ▼] [Filters] [Sort: ▼]       │
├──────────────────────────┬──────────────────────────────────────┤
│ FILTER SIDEBAR           │ RESULTS GRID                         │
│ ☐ Category               │ Showing 127 results for "nasi goreng"│
│   ☐ Food                 │                                      │
│   ☐ Groceries            │ [Product Card] [Product Card]        │
│ ☐ Distance               │ [Product Card] [Product Card]        │
│   ○ < 1 km               │ [Merchant Card - Restaurant]         │
│   ○ < 5 km               │ [Product Card] [Product Card]        │
│   ○ < 10 km              │                                      │
│ ☐ Price Range            │ [Load More Button]                   │
│ ☐ Open Now               │                                      │
│ ☐ Halal Certified        │                                      │
└──────────────────────────┴──────────────────────────────────────┘
```

**Key Components:**
- **Search Bar:** Pre-filled with query, scope selector dropdown
- **Filter Sidebar:** Collapsible on mobile, includes category, distance, price, open status, halal certification
- **Sort Selector:** Trending, Price (low to high), Price (high to low), Distance, Newest
- **Results Grid:** Mixed content showing products, menu items, and merchants with clear type indicators
- **Pagination:** "Load more" infinite scroll or pagination controls

**Search Scope Behavior:**
- `scope=all`: Searches across all merchants, products, and menu items
- `scope={merchant-slug}`: Restricts search to specific merchant's catalog

**User Interactions:**
- Filter changes update URL query parameters and refresh results
- Clicking product navigates to product detail page
- Clicking merchant navigates to place page
- "Clear all filters" resets to default view

---

### 2.3 Place Page (Shop or Restaurant)

**URL:** `/places/{merchant-slug}`

**Purpose:** Display comprehensive business information for a merchant including location, hours, halal status, and entry points to shop/order.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
├─────────────────────────────────────────────────────────────────┤
│ HERO IMAGE / GALLERY                                            │
│ [Cover Photo] [Photo 1] [Photo 2] [+12 more]                    │
├─────────────────────────────────────────────────────────────────┤
│ BUSINESS HEADER                                                 │
│ [Logo] Merchant Name                                            │
│ ★ 4.5 (128 reviews) · Indonesian, Halal Certified              │
│ 📍 1.2 km away · Open until 9 PM                                │
│ [View Shop] [View Menu] [Get Directions] [Save]                 │
├─────────────────────────────────────────────────────────────────┤
│ TABS: [About] [Products] [Menu] [Reviews]                       │
├─────────────────────────────────────────────────────────────────┤
│ TAB CONTENT                                                     │
│                                                                 │
│ ABOUT TAB:                                                      │
│ - Business description                                          │
│ - Operating hours (table format)                                │
│ - Contact information                                           │
│ - Halal Disclosure Panel                                        │
│ - Location map embed                                            │
│ - Amenities (Prayer space, Parking, etc.)                       │
│                                                                 │
│ PRODUCTS TAB: (if Shop capability active)                       │
│ - Product grid from merchant catalog                            │
│                                                                 │
│ MENU TAB: (if Restaurant capability active)                     │
│ - Menu items grouped by category                                │
│                                                                 │
│ REVIEWS TAB:                                                    │
│ - Review list with ratings and responses                        │
├─────────────────────────────────────────────────────────────────┤
│ FOOTER                                                          │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Photo Gallery:** Hero image with expandable gallery modal
- **Business Header:** Logo, name, rating summary, tags, distance, open status
- **Action Buttons:** Capability-dependent CTAs (View Shop, View Menu, Order Now)
- **Halal Disclosure Panel:** Merchant-declared halal status with optional certificate viewer
- **Tab Navigation:** About, Products (if Shop enabled), Menu (if Restaurant enabled), Reviews
- **Map Embed:** Interactive map showing business location with directions link
- **Amenities Icons:** Visual indicators for prayer space, parking, family-friendly, etc.

**Halal Status Display Logic:**
- **Default:** "Halal" badge shown (merchant-declared, assumed halal)
- **With certificate:** "Halal Certified ✓" badge with "View Certificate" link
- **Certificate viewer:** Modal showing uploaded certificate image with disclaimer text

**User Interactions:**
- Photo clicks open gallery modal
- "View Shop" navigates to `/m/{merchant-slug}/shop`
- "View Menu" navigates to `/m/{merchant-slug}/menu`
- "Get Directions" opens external maps app
- Tab clicks update displayed content (no page reload)
- "Write a Review" opens review modal (logged-in users only)

---

### 2.4 Merchant-Owned Shopfront

**URL:** `/m/{merchant-slug}` (landing), `/m/{merchant-slug}/shop` (products), `/m/{merchant-slug}/menu` (restaurant menu)

**Purpose:** Merchant-branded storefront page with reduced Halava branding, optimized for sharing on social media and QR codes.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ MERCHANT TOPBAR (reduced Halava branding)                       │
│ [Halava Logo] / [Merchant Name]  [Search: This shop ▼] [Cart]   │
├─────────────────────────────────────────────────────────────────┤
│ MERCHANT HERO                                                   │
│ [Cover Image with merchant branding]                            │
│ [Merchant Logo] Merchant Name                                   │
│ Brief tagline or description                                    │
│ 📍 Location · ⏰ Open until 9 PM · 📞 Contact                   │
├─────────────────────────────────────────────────────────────────┤
│ NAVIGATION: [Products] [Menu] [About] [Reviews]                 │
├─────────────────────────────────────────────────────────────────┤
│ CATEGORY FILTER BAR                                             │
│ [All] [Meat] [Spices] [Frozen] [Beverages] ...                  │
├─────────────────────────────────────────────────────────────────┤
│ PRODUCT/MENU GRID                                               │
│ [Product Card] [Product Card] [Product Card]                    │
│ [Product Card] [Product Card] [Product Card]                    │
│ [Product Card] [Product Card] [Product Card]                    │
├─────────────────────────────────────────────────────────────────┤
│ "Powered by Halava" FOOTER                                      │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Merchant Topbar:** Breadcrumb-style identity (Halava / {merchant-name}), scoped search bar, cart icon
- **Search Scope Selector:** Default is "This shop"; can switch to "All of Halava"
- **Merchant Branding:** Cover image, logo, colors defined by merchant
- **Category Filter Bar:** Horizontal scrollable filter for product categories
- **Product Grid:** Merchant's catalog with add-to-cart functionality
- **Powered by Halava Footer:** Subtle Halava branding with link to marketplace

**Search Behavior on Merchant Pages:**
- Default scope is "This shop" - searches only within merchant's catalog
- User can switch to "All of Halava" to search globally
- Search results within shop stay on merchant-branded pages

**Cart Behavior (Single-Merchant Enforcement):**
- Adding item keeps user on merchant shopfront
- If cart contains items from different merchant, show modal:
  - "Start a new cart" (clears current, adds new item)
  - "Keep current cart" (cancel action)

---

### 2.5 Product Detail Page

**URL:** `/m/{merchant-slug}/products/{product-slug}`

**Purpose:** Comprehensive product information page with purchase options.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ MERCHANT TOPBAR                                                 │
├─────────────────────────────────────────────────────────────────┤
│ BREADCRUMB: Halava / {Merchant} / Products / {Product Name}    │
├──────────────────────────┬──────────────────────────────────────┤
│ PRODUCT IMAGES           │ PRODUCT INFO                         │
│ [Main Image]             │ Product Name                         │
│ [Thumbnail Gallery]      │ ★ 4.5 (32 reviews)                  │
│                          │ ¥1,200                               │
│                          │ In Stock (15 available)              │
│                          │                                      │
│                          │ [Quantity: - 1 +]                    │
│                          │ [Add to Cart - ¥1,200]               │
│                          │                                      │
│                          │ Pickup available at store            │
│                          │ Delivery: 2-3 business days          │
├──────────────────────────┴──────────────────────────────────────┤
│ TABS: [Description] [Specifications] [Reviews]                  │
├─────────────────────────────────────────────────────────────────┤
│ TAB CONTENT                                                     │
│ - Full product description                                      │
│ - Ingredients / Nutritional info (if applicable)               │
│ - Halal certification details                                   │
│ - Customer reviews                                              │
├─────────────────────────────────────────────────────────────────┤
│ RELATED PRODUCTS                                                │
│ [Product Card] [Product Card] [Product Card] [Product Card]     │
├─────────────────────────────────────────────────────────────────┤
│ FOOTER                                                          │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Image Gallery:** Main image with zoomable thumbnails
- **Price Display:** Current price, original price if discounted, unit pricing
- **Stock Status:** Real-time availability with count
- **Quantity Selector:** Increment/decrement with max based on stock
- **Add to Cart Button:** Primary CTA with dynamic price update
- **Fulfillment Options:** Pickup availability, delivery timeframe
- **Product Tabs:** Description, Specifications, Reviews
- **Related Products:** Algorithm-based suggestions from same merchant

**Stock Status Display:**
- "In Stock" (green) - stock > low_stock_threshold
- "Low Stock - X left" (orange) - stock ≤ low_stock_threshold
- "Out of Stock" (gray) - stock = 0, add-to-cart disabled

---

### 2.6 Menu Item Detail Page (Restaurant)

**URL:** `/m/{merchant-slug}/menu/{item-slug}`

**Purpose:** Menu item details with customization options for restaurant orders.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ MERCHANT TOPBAR                                                 │
├─────────────────────────────────────────────────────────────────┤
│ BREADCRUMB: Halava / {Merchant} / Menu / {Item Name}           │
├──────────────────────────┬──────────────────────────────────────┤
│ ITEM IMAGE               │ ITEM INFO                            │
│ [Main Image]             │ Nasi Goreng Special                  │
│                          │ ★ 4.7 (89 reviews)                  │
│                          │ ¥980                                 │
│                          │                                      │
│                          │ Indonesian fried rice with chicken,  │
│                          │ prawns, and vegetables               │
│                          │                                      │
│                          │ ⏱ Prep time: ~15 min                │
│                          │ 🌶 Spicy level: Medium              │
├──────────────────────────┴──────────────────────────────────────┤
│ CUSTOMIZATIONS                                                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Spice Level (required)                                      │ │
│ │ ○ Mild  ○ Medium  ○ Hot  ○ Extra Hot (+¥50)               │ │
│ └─────────────────────────────────────────────────────────────┘ │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Add-ons (optional)                                          │ │
│ │ ☐ Extra Egg (+¥100)  ☐ Extra Prawns (+¥200)               │ │
│ │ ☐ Kerupuk (+¥50)                                           │ │
│ └─────────────────────────────────────────────────────────────┘ │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Special Instructions                                        │ │
│ │ [Text area for notes: "No onions please"]                  │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ [Quantity: - 1 +]        [Add to Cart - ¥1,130]                │
├─────────────────────────────────────────────────────────────────┤
│ SIMILAR ITEMS                                                   │
│ [Menu Card] [Menu Card] [Menu Card]                             │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Item Image:** High-quality food photo
- **Item Info:** Name, rating, base price, description, prep time, dietary tags
- **Customization Options:** Modifiers grouped by category (required vs optional)
- **Price Modifier Display:** Additional costs shown inline (+¥50)
- **Special Instructions:** Free-text field for customer notes
- **Dynamic Price:** Cart button price updates based on selections

**Modifier Types:**
- **Required (radio):** Must select one option (e.g., spice level)
- **Optional (checkbox):** Can select multiple or none (e.g., add-ons)
- **Quantity modifiers:** Some add-ons may have quantity selectors

---

### 2.7 Shopping Cart Page

**URL:** `/cart`

**Purpose:** Review cart contents before proceeding to checkout.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
├─────────────────────────────────────────────────────────────────┤
│ PAGE HEADER: Shopping Cart                                      │
├─────────────────────────────────────────────────────────────────┤
│ MERCHANT CONTEXT BANNER                                         │
│ Shopping at: [Merchant Logo] Merchant Name                      │
├──────────────────────────────────────────────────────────────────┤
│ CART ITEMS                                                      │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [Image] Product Name                        [- 2 +] ¥2,400 │ │
│ │         Variant: Large                       [Remove]       │ │
│ └─────────────────────────────────────────────────────────────┘ │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [Image] Nasi Goreng                         [- 1 +] ¥1,130 │ │
│ │         Spicy: Hot, +Extra Egg               [Remove]       │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ COUPON CODE                                                     │
│ [Enter coupon code] [Apply]                                     │
│ ✓ WELCOME10 applied: -¥353                                     │
├─────────────────────────────────────────────────────────────────┤
│ ORDER SUMMARY                          │                        │
│ Subtotal (3 items)           ¥3,530    │                        │
│ Discount (WELCOME10)          -¥353    │                        │
│ ──────────────────────────────────     │                        │
│ Total                        ¥3,177    │                        │
│                                        │                        │
│ [Continue Shopping]  [Proceed to Checkout →]                   │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Merchant Context Banner:** Shows which merchant the cart belongs to
- **Cart Item Row:** Image, name, modifiers, quantity controls, line total, remove button
- **Quantity Controls:** Real-time price updates, max limited by stock
- **Coupon Input:** Code entry with validation and applied discount display
- **Order Summary:** Itemized calculation with subtotal, discounts, total
- **Action Buttons:** Continue shopping (back to merchant), Proceed to checkout

**Empty Cart State:**
- "Your cart is empty" message
- Suggestions or link to explore marketplace

---

### 2.8 Checkout Page

**URL:** `/checkout` (multi-step), `/checkout/payment`, `/checkout/confirmation`

**Purpose:** Complete the purchase with fulfillment selection and payment.

**Layout Structure (Multi-Step):**
```
┌─────────────────────────────────────────────────────────────────┐
│ MINIMAL TOPBAR: [Halava Logo] Secure Checkout                   │
├─────────────────────────────────────────────────────────────────┤
│ CHECKOUT STEPPER                                                │
│ [1. Fulfillment ●] → [2. Payment ○] → [3. Confirm ○]           │
├──────────────────────────────────────────────────────────────────┤
│                                                                 │
│ STEP 1: FULFILLMENT (/checkout)                                 │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ How would you like to receive your order?                   │ │
│ │                                                             │ │
│ │ ○ Pickup at store                                          │ │
│ │   📍 123 Shibuya St, Tokyo                                 │ │
│ │   Ready in ~30 minutes                                      │ │
│ │                                                             │ │
│ │ ○ Delivery                                                 │ │
│ │   [Enter delivery address]                                  │ │
│ │   Estimated: 2-3 business days                              │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ FOR RESTAURANT ORDERS:                                          │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Order Type                                                  │ │
│ │ ○ Dine-in    ○ Takeaway                                    │ │
│ │                                                             │ │
│ │ (If Dine-in + Pay Online selected)                         │ │
│ │ When would you like your food ready?                        │ │
│ │ [Time Selector: ○ 15 min ○ 30 min ○ 45 min ○ Custom]       │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [← Back to Cart]                    [Continue to Payment →]    │
├─────────────────────────────────────────────────────────────────┤
│ ORDER SUMMARY (sidebar on desktop, collapsed on mobile)         │
│ - Item list                                                     │
│ - Subtotal, fees, total                                         │
└─────────────────────────────────────────────────────────────────┘
```

**Step 2: Payment (`/checkout/payment`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ STEP 2: PAYMENT                                                 │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ How would you like to pay?                                  │ │
│ │                                                             │ │
│ │ ○ Pay online (Bank Transfer)                               │ │
│ │   Transfer to merchant's bank account                       │ │
│ │                                                             │ │
│ │ ○ Pay at counter (Restaurant only)                         │ │
│ │   Pay when you arrive (cash/card/QR accepted)               │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [← Back]                           [Place Order - ¥3,177 →]    │
└─────────────────────────────────────────────────────────────────┘
```

**Step 3: Confirmation (`/checkout/confirmation`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ ORDER CONFIRMED ✓                                               │
│                                                                 │
│ Thank you for your order!                                       │
│ Order #HL-2026-0001234                                         │
│                                                                 │
│ IF PAY ONLINE (Phase 1 - Bank Transfer):                       │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Please complete your payment:                               │ │
│ │                                                             │ │
│ │ Bank: Mitsubishi UFJ                                        │ │
│ │ Account: 1234567                                            │ │
│ │ Name: Halal Foods Co.                                       │ │
│ │ Amount: ¥3,177                                              │ │
│ │ Reference: HL-2026-0001234                                  │ │
│ │                                                             │ │
│ │ [Copy Details]                                              │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ IF PAY AT COUNTER:                                              │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Your order has been sent to the restaurant.                 │ │
│ │ Please proceed to the counter to pay.                       │ │
│ │                                                             │ │
│ │ Order Code: A-23                                            │ │
│ │ Show this to the cashier                                    │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [Track Order]                     [Continue Shopping]           │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Checkout Stepper:** Visual progress indicator (Fulfillment → Payment → Confirm)
- **Fulfillment Selection:** Pickup vs Delivery (shop), Dine-in vs Takeaway (restaurant)
- **Time Selector:** For online dine-in orders, select when food should be ready
- **Payment Options:** Pay online (bank transfer in Phase 1) or Pay at counter (restaurant)
- **Order Summary Sidebar:** Persistent summary of cart contents and totals
- **Confirmation Details:** Order number, payment instructions, next steps

**Payment Method Logic:**
| Capability | Pay Online Available | Pay at Counter Available |
|------------|---------------------|-------------------------|
| Shop | ✓ | ✗ (cashier must scan items) |
| Restaurant | ✓ | ✓ |

---

### 2.9 Order Tracking Page

**URL:** `/orders/{order-id}/track`

**Purpose:** Real-time order status tracking with visual progress and notifications.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
├─────────────────────────────────────────────────────────────────┤
│ ORDER TRACKING                                                  │
│ Order #HL-2026-0001234                                         │
│ Merchant Name · Takeaway                                        │
├─────────────────────────────────────────────────────────────────┤
│ PROGRESS INDICATOR                                              │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │  [✓ Placed] ─── [✓ Confirmed] ─── [● Preparing] ─── [○ Ready]│ │
│ │     2:30 PM        2:32 PM          2:35 PM                 │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ CURRENT STATUS                                                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🍳 Your food is being prepared                              │ │
│ │                                                             │ │
│ │ Estimated ready time: 2:50 PM (~12 minutes)                │ │
│ │                                                             │ │
│ │ [Animated cooking indicator]                                │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ PICKUP INSTRUCTIONS                                             │
│ 📍 123 Shibuya St, Tokyo                                       │
│ Show order number A-23 at the counter                          │
│ [Get Directions]                                                │
├─────────────────────────────────────────────────────────────────┤
│ ORDER DETAILS                                                   │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Nasi Goreng Special (Hot, +Egg)              x1    ¥1,130  │ │
│ │ Teh Tarik                                    x2      ¥600  │ │
│ │ ─────────────────────────────────────────────────────────  │ │
│ │ Total                                               ¥1,730  │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ IF ORDER WAS MODIFIED AT CHECKOUT:                              │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ⚠ Order modified at checkout:                              │ │
│ │ ~~Roti Canai x2~~ (removed)                                │ │
│ │ Teh Tarik x~~2~~1 (quantity changed)                       │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ [Contact Merchant]                          [Cancel Order]      │
└─────────────────────────────────────────────────────────────────┘
```

**Status States:**
| Status | Visual | Description |
|--------|--------|-------------|
| Placed | ✓ Gray | Order submitted |
| Pending Payment | ⏳ Yellow | Awaiting bank transfer (Phase 1) |
| Confirmed | ✓ Green | Payment verified, order accepted |
| Preparing | 🍳 Blue | Kitchen is cooking |
| Ready | 🔔 Green pulse | Food ready for pickup/serving |
| Fulfilled | ✓ Complete | Order handed off |

**Key Components:**
- **Progress Indicator:** Horizontal stepper with timestamps
- **Status Card:** Current status with animated indicator and ETA countdown
- **Pickup Instructions:** Location, order code, directions link
- **Order Details:** Itemized list with modifications highlighted
- **Action Buttons:** Contact merchant, Cancel order (if allowed)

**Real-Time Updates:**
- WebSocket or polling for status changes (no page refresh needed)
- Push notification when status changes to "Ready"
- Audio alert option for "Ready" status

---

### 2.10 Purchase History Page

**URL:** `/purchase-history`

**Purpose:** Unified view of all purchases for expense tracking and price comparison.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
├─────────────────────────────────────────────────────────────────┤
│ PURCHASE HISTORY                                                │
│                                                                 │
│ FILTER BAR                                                      │
│ [Date Range: This Month ▼] [Category: All ▼] [Merchant: All ▼] │
├─────────────────────────────────────────────────────────────────┤
│ SPENDING SUMMARY CARD                                           │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Total Spending: ¥45,230                                     │ │
│ │ Groceries: ¥28,500  |  Dining: ¥16,730                     │ │
│ │ [View Chart]                                                │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ TRANSACTION LIST                                                │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Jan 28, 2026                                                │ │
│ │ [Logo] Halal Mart Shibuya        Online Order     ¥3,200   │ │
│ │        Pickup · 3 items                           [View]    │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ Jan 27, 2026                                                │ │
│ │ [Logo] Warung Nusantara          Dine-in          ¥1,980   │ │
│ │        Restaurant · Pay at counter                [View]    │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ Jan 25, 2026                                                │ │
│ │ [Logo] Halal Mart Shibuya        In-Store (POS)   ¥890     │ │
│ │        Groceries · Linked via QR                  [View]    │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [Load More]                                                     │
├─────────────────────────────────────────────────────────────────┤
│ PRICE COMPARISON (when viewing specific product history)        │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Halal Chicken Breast - Price History                        │ │
│ │ Halal Mart: ¥450/kg (Jan 2026) → ¥480/kg (now)            │ │
│ │ Tokyo Halal: ¥420/kg (Dec 2025)                            │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Filter Bar:** Date range, category, merchant dropdowns
- **Spending Summary:** Aggregate spending with category breakdown
- **Transaction List:** Chronological list with merchant, type, amount
- **Transaction Types:** Online Order, Dine-in, Takeaway, In-Store (POS)
- **Price Comparison:** Historical price data for specific products across merchants

**Transaction Linking Indicators:**
- **Online Order:** "Order #HL-2026-xxx"
- **In-Store (POS):** "Linked via QR" or "Claimed with code"
- **Unlinked:** (Not shown in consumer history - merchant only)

---

### 2.11 Group Purchase Pages

**URL:** `/group-purchase/{invite-code}` (join), `/group-purchase/{id}/manage` (initiator)

**Purpose:** Collaborative shopping where multiple users contribute to a shared cart.

**Join Page Layout (`/group-purchase/{invite-code}`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
├─────────────────────────────────────────────────────────────────┤
│ GROUP PURCHASE INVITATION                                       │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [Initiator Avatar] Sarah invited you to a group purchase    │ │
│ │                                                             │ │
│ │ 🛒 Halal Mart Shibuya                                      │ │
│ │ 📅 Deadline: Jan 30, 2026 at 6:00 PM                       │ │
│ │ 👥 3 participants so far                                    │ │
│ │                                                             │ │
│ │ Current cart total: ¥8,500 (¥1,500 until free shipping)   │ │
│ │                                                             │ │
│ │ [Join & Add Items]                                         │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ CURRENT CART CONTENTS (read-only)                               │
│ Sarah: Halal Chicken x2, Rice 5kg                   ¥3,200     │
│ Ahmed: Lamb Chops x1, Spice Set                     ¥2,800     │
│ You: (No items yet)                                             │
└─────────────────────────────────────────────────────────────────┘
```

**Manage Page Layout (`/group-purchase/{id}/manage` - Initiator only):**
```
┌─────────────────────────────────────────────────────────────────┐
│ MANAGE GROUP PURCHASE                                           │
│                                                                 │
│ STATUS: Open for contributions                                  │
│ Deadline: Jan 30, 2026 at 6:00 PM (2 days left)                │
├─────────────────────────────────────────────────────────────────┤
│ INVITE LINK                                                     │
│ [https://halava.jp/group-purchase/abc123] [Copy] [Share]       │
├─────────────────────────────────────────────────────────────────┤
│ PARTICIPANTS & CONTRIBUTIONS                                    │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Sarah (You - Initiator)                           ¥3,200   │ │
│ │ - Halal Chicken Breast x2                                   │ │
│ │ - Premium Basmati Rice 5kg                                  │ │
│ │                                                             │ │
│ │ Ahmed                                             ¥2,800   │ │
│ │ - Lamb Chops 500g                                           │ │
│ │ - Indonesian Spice Set                                      │ │
│ │                                                             │ │
│ │ Maria (pending)                                   ¥0       │ │
│ │ - No items added yet                                        │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ ORDER SUMMARY                                                   │
│ Subtotal: ¥8,500                                               │
│ Shipping: ¥500 (Free if ≥ ¥10,000)                             │
│ You need ¥1,500 more for free shipping!                        │
│ ──────────────────────                                         │
│ Total: ¥9,000                                                  │
│                                                                 │
│ [Add More Items]     [Extend Deadline]     [Submit Order →]    │
└─────────────────────────────────────────────────────────────────┘
```

---

### 2.12 User Profile & Settings Pages

**URL:** `/profile`, `/profile/settings`, `/profile/receipts`, `/saved`, `/notifications`

**Profile Page (`/profile`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ GLOBAL TOPBAR                                                   │
├─────────────────────────────────────────────────────────────────┤
│ MY PROFILE                                                      │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [Avatar] John Doe                                           │ │
│ │ john@email.com                                              │ │
│ │ Member since January 2026                                   │ │
│ │ [Edit Profile]                                              │ │
│ └─────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│ QUICK LINKS                                                     │
│ [📦 My Orders] [📜 Purchase History] [💾 Saved Items]          │
│ [🧾 My Receipts] [⚙️ Settings] [🔔 Notifications]              │
├─────────────────────────────────────────────────────────────────┤
│ RECENT ACTIVITY                                                 │
│ - Ordered from Halal Mart (2 hours ago)                        │
│ - Saved Warung Nusantara (yesterday)                           │
│ - Joined group purchase (3 days ago)                           │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Merchant-Facing Pages

### 3.1 Merchant Dashboard (Overview)

**URL:** `/dashboard`

**Purpose:** Central hub for merchants to monitor business health and access all capabilities.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ MERCHANT TOPBAR: [Halava] Dashboard · {Merchant Name}  [Profile]│
├──────────────────────┬──────────────────────────────────────────┤
│ SIDEBAR NAVIGATION   │ MAIN CONTENT                             │
│                      │                                          │
│ Overview ●          │ WELCOME BANNER (if setup incomplete)      │
│ Capabilities         │ ┌────────────────────────────────────┐   │
│ Listings             │ │ Complete your setup to start       │   │
│ Products & Menu      │ │ selling! [Continue Setup →]        │   │
│ Orders               │ └────────────────────────────────────┘   │
│ Kitchen Queue        │                                          │
│ Inventory            │ TODAY'S SUMMARY                          │
│ Promotions           │ ┌──────────┬──────────┬──────────┐      │
│ Staff                │ │ ¥45,230  │ 23       │ 5        │      │
│ Settings             │ │ Revenue  │ Orders   │ New      │      │
│                      │ │ Today    │ Today    │ Reviews  │      │
│                      │ └──────────┴──────────┴──────────┘      │
│                      │                                          │
│                      │ ALERTS                                   │
│                      │ ⚠ 3 items low on stock                  │
│                      │ 📦 2 orders pending confirmation         │
│                      │                                          │
│                      │ QUICK ACTIONS                            │
│                      │ [Open POS] [Add Product] [View Orders]   │
│                      │                                          │
│                      │ RECENT ORDERS                            │
│                      │ [Order list with status indicators]      │
└──────────────────────┴──────────────────────────────────────────┘
```

**Key Components:**
- **Sidebar Navigation:** Persistent navigation to all dashboard sections
- **Welcome/Setup Banner:** Shown if any capability needs setup
- **Summary Cards:** Revenue, orders, reviews for current period
- **Alert Section:** Low stock warnings, pending orders, action items
- **Quick Actions:** One-click access to common tasks
- **Recent Orders:** Live feed of latest orders

---

### 3.2 Capabilities Page

**URL:** `/dashboard/capabilities`, `/dashboard/capabilities/{capability}/setup`

**Purpose:** Enable and configure business capabilities (POS, Shop, Restaurant, etc.)

**Layout Structure:**
```
┌──────────────────────┬──────────────────────────────────────────┐
│ SIDEBAR              │ CAPABILITIES                             │
│                      │                                          │
│                      │ ┌─────────────────────────────────────┐  │
│                      │ │ 📍 DIRECTORY LISTING        [Active]│  │
│                      │ │ Your business is listed and visible │  │
│                      │ │ to customers on Halava.              │  │
│                      │ │ [Manage Listing] [Settings]          │  │
│                      │ └─────────────────────────────────────┘  │
│                      │                                          │
│                      │ ┌─────────────────────────────────────┐  │
│                      │ │ 💳 POINT OF SALE (POS)  [Needs Setup]│  │
│                      │ │ Process in-store sales and generate  │  │
│                      │ │ receipts.                             │  │
│                      │ │ [Complete Setup →]                    │  │
│                      │ └─────────────────────────────────────┘  │
│                      │                                          │
│                      │ ┌─────────────────────────────────────┐  │
│                      │ │ 🛒 SHOP / MARKETPLACE      [Disabled]│  │
│                      │ │ Sell products online with delivery   │  │
│                      │ │ or pickup options.                   │  │
│                      │ │ [Enable →]                           │  │
│                      │ └─────────────────────────────────────┘  │
│                      │                                          │
│                      │ ┌─────────────────────────────────────┐  │
│                      │ │ 🍽 RESTAURANT OPERATIONS   [Disabled]│  │
│                      │ │ Accept food orders for dine-in or   │  │
│                      │ │ takeaway.                            │  │
│                      │ │ [Enable →]                           │  │
│                      │ └─────────────────────────────────────┘  │
│                      │                                          │
│                      │ ┌─────────────────────────────────────┐  │
│                      │ │ 🎫 PROMOTIONS              [Disabled]│  │
│                      │ │ Create coupons and featured listings.│  │
│                      │ │ [Enable →]                           │  │
│                      │ └─────────────────────────────────────┘  │
└──────────────────────┴──────────────────────────────────────────┘
```

**Capability States:**
| State | Badge | Actions Available |
|-------|-------|-------------------|
| Disabled | Gray "Disabled" | "Enable" button |
| Needs Setup | Yellow "Needs Setup" | "Complete Setup" button |
| Active | Green "Active" | "Manage", "Settings" buttons |
| Suspended | Red "Suspended" | "Contact Support" link |

**Setup Wizard (`/dashboard/capabilities/{capability}/setup`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ SETUP: POINT OF SALE                                            │
│ Step 2 of 3: Configure Receipt Settings                        │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Receipt Header                                              │ │
│ │ [Text area: Business name, address, tax ID...]              │ │
│ │                                                             │ │
│ │ Tax Settings                                                │ │
│ │ Tax Rate: [10%]                                             │ │
│ │ ☐ Show tax breakdown on receipts                           │ │
│ │                                                             │ │
│ │ Default Payment Methods                                     │ │
│ │ ☑ Cash  ☑ Credit Card  ☐ QR Payment                       │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [← Back]                                    [Next: Finish →]   │
└─────────────────────────────────────────────────────────────────┘
```

---

### 3.3 POS Screen

**URL:** `/pos`, `/pos/prepared-orders`, `/pos/transactions`, `/pos/transactions/{id}`

**Purpose:** Cashier interface for processing in-store sales and prepared orders.

**POS Main Screen Layout (`/pos`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ POS TOPBAR: {Merchant} · POS   [Prepared Orders (3)] [≡ Menu]  │
├──────────────────────────────────┬──────────────────────────────┤
│ PRODUCT GRID                     │ CURRENT SALE                 │
│                                  │                              │
│ [Search products...] [Scan 📷]   │ ┌──────────────────────────┐ │
│                                  │ │ Halal Chicken    x2 ¥900 │ │
│ CATEGORIES:                      │ │ [- +]           [Remove] │ │
│ [All] [Meat] [Dairy] [Frozen]    │ ├──────────────────────────┤ │
│                                  │ │ Basmati Rice     x1 ¥450 │ │
│ ┌─────┐ ┌─────┐ ┌─────┐         │ │ [- +]           [Remove] │ │
│ │     │ │     │ │     │         │ └──────────────────────────┘ │
│ │ 🍗  │ │ 🥩  │ │ 🧀  │         │                              │
│ │¥450 │ │¥800 │ │¥350 │         │ ──────────────────────────── │
│ └─────┘ └─────┘ └─────┘         │ Subtotal:            ¥1,350 │
│                                  │ Tax (10%):             ¥135 │
│ ┌─────┐ ┌─────┐ ┌─────┐         │ ──────────────────────────── │
│ │     │ │     │ │     │         │ TOTAL:               ¥1,485 │
│ │ 🍚  │ │ 🥛  │ │ 🍞  │         │                              │
│ │¥450 │ │¥280 │ │¥320 │         │ [Link Customer QR]           │
│ └─────┘ └─────┘ └─────┘         │                              │
│                                  │ PAYMENT:                     │
│ [More products...]               │ [Cash] [Card] [Other]        │
│                                  │                              │
│                                  │ [Complete Sale - ¥1,485]    │
├──────────────────────────────────┴──────────────────────────────┤
│ STATUS BAR: ● Online  |  Quota: 245/300 this month  |  [Top-up] │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Product Search:** Text search and optional barcode scanner
- **Category Filter:** Quick category tabs for product navigation
- **Product Grid:** Touch-friendly grid with product image, name, price
- **Current Sale Panel:** Active cart with line items, quantity controls
- **Customer Linking:** QR scanner to link transaction to customer account
- **Payment Methods:** Cash, Card, Other buttons
- **Quota Status Bar:** Current usage and top-up shortcut

**Prepared Orders Queue (`/pos/prepared-orders`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ PREPARED ORDERS (Pay at Counter)                   [← Back to POS]│
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Order A-23                               ⏱ 5 min ago       │ │
│ │ Table 4 · Dine-in                                          │ │
│ │ 2 items · ¥1,730                                           │ │
│ │ [Open & Complete Payment]                                   │ │
│ └─────────────────────────────────────────────────────────────┘ │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Order A-24                               ⏱ 2 min ago       │ │
│ │ Counter · Takeaway                                         │ │
│ │ 1 item · ¥980                                              │ │
│ │ [Open & Complete Payment]                                   │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [Clear Expired Orders (3)]                                      │
└─────────────────────────────────────────────────────────────────┘
```

---

### 3.4 Kitchen Order Queue (KOQ)

**URL:** `/dashboard/kitchen`

**Purpose:** Real-time queue for kitchen staff to manage food order preparation.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ KITCHEN QUEUE                    [🔊 Sound: On] [⚙ Settings]   │
├─────────────────────────────────────────────────────────────────┤
│ TABS: [All (8)] [New (2)] [Preparing (4)] [Ready (2)]          │
├─────────────────────────────────────────────────────────────────┤
│ ORDER CARDS (Kanban-style columns or list)                      │
│                                                                 │
│ ┌─NEW─────────────────┐  ┌─PREPARING──────────┐  ┌─READY──────┐│
│ │                     │  │                     │  │            ││
│ │ #A-25 🔔 NEW       │  │ #A-23              │  │ #A-21      ││
│ │ Takeaway            │  │ Dine-in (Table 4)  │  │ Takeaway   ││
│ │ Ready by: 3:15 PM   │  │ ⏱ 8 min elapsed   │  │ ⏱ Ready!  ││
│ │ ─────────────────── │  │ ─────────────────── │  │            ││
│ │ Nasi Goreng x2      │  │ Mie Goreng x1      │  │ Waiting    ││
│ │  - Hot              │  │  - Medium          │  │ for pickup ││
│ │  - +Extra Egg       │  │ Satay Ayam x1      │  │            ││
│ │ Teh Tarik x2        │  │                     │  │ [Fulfilled]││
│ │ ─────────────────── │  │ ─────────────────── │  │            ││
│ │ [Accept]            │  │ [Mark Ready]        │  │            ││
│ │                     │  │                     │  │            ││
│ └─────────────────────┘  └─────────────────────┘  └────────────┘│
│                                                                 │
│ ┌─────────────────────┐                                        │
│ │ #A-26 🔔 NEW       │                                        │
│ │ Online (Dine-in)    │                                        │
│ │ Ready at: 3:30 PM   │  ← Time-targeted order                 │
│ │ ─────────────────── │                                        │
│ │ Rendang Set x1      │                                        │
│ │ ─────────────────── │                                        │
│ │ [Accept]            │                                        │
│ └─────────────────────┘                                        │
└─────────────────────────────────────────────────────────────────┘
```

**Key Components:**
- **Tab Filters:** Filter by order status (New, Preparing, Ready)
- **Order Cards:** Compact display with order code, type, items, elapsed time
- **Time Indicators:** "Ready by" time for online orders, elapsed timer for in-progress
- **Quick Actions:** Accept, Start Preparing, Mark Ready, Fulfilled buttons
- **Audio Alerts:** Configurable sound for new orders
- **Overdue Highlighting:** Red border on orders exceeding expected prep time

---

### 3.5 Products & Menu Management

**URL:** `/dashboard/products`, `/dashboard/products/new`, `/dashboard/products/{id}/edit`

**Purpose:** Manage product catalog and menu items.

**Product List Layout (`/dashboard/products`):**
```
┌──────────────────────┬──────────────────────────────────────────┐
│ SIDEBAR              │ PRODUCTS & MENU                          │
│                      │                                          │
│                      │ [+ Add Product] [+ Add Menu Item] [Import]│
│                      │                                          │
│                      │ FILTERS:                                 │
│                      │ [Type: All ▼] [Category: All ▼] [Stock ▼]│
│                      │ [Search products...]                     │
│                      │                                          │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ [☐] [Img] Halal Chicken Breast         ││
│                      │ │     Product · Meat · ¥450              ││
│                      │ │     Stock: 25   | Channels: Shop, POS  ││
│                      │ │                     [Edit] [Duplicate] ││
│                      │ ├────────────────────────────────────────┤│
│                      │ │ [☐] [Img] Nasi Goreng Special          ││
│                      │ │     Menu Item · Main Course · ¥980     ││
│                      │ │     Available ✓ | Channels: Restaurant ││
│                      │ │                     [Edit] [Toggle Off]││
│                      │ ├────────────────────────────────────────┤│
│                      │ │ [☐] [Img] Fresh Bread Loaf             ││
│                      │ │     Hybrid · Bakery · ¥320             ││
│                      │ │     Stock: 8 ⚠ Low | Shop, Restaurant  ││
│                      │ │                     [Edit] [Restock]   ││
│                      │ └────────────────────────────────────────┘│
│                      │                                          │
│                      │ Showing 1-20 of 156 items                │
└──────────────────────┴──────────────────────────────────────────┘
```

**Add/Edit Product Form (`/dashboard/products/new`, `/dashboard/products/{id}/edit`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ ADD NEW PRODUCT                                    [Save Draft] │
├─────────────────────────────────────────────────────────────────┤
│ BASIC INFORMATION                                               │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Product Name *                                              │ │
│ │ [Halal Chicken Breast                              ]        │ │
│ │                                                             │ │
│ │ Description                                                 │ │
│ │ [Premium halal-certified chicken breast...        ]         │ │
│ │                                                             │ │
│ │ Item Type *                                                 │ │
│ │ ○ Product (inventory tracked)                              │ │
│ │ ○ Menu Item (available/unavailable toggle)                 │ │
│ │ ○ Hybrid (inventory tracked, available in restaurant)      │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ PRICING & INVENTORY                                             │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Base Price *         │ Stock Count      │ Low Stock Alert   │ │
│ │ [¥ 450         ]     │ [25         ]    │ [5           ]    │ │
│ │                                                             │ │
│ │ SKU/Barcode (optional)                                      │ │
│ │ [4901234567890                                    ]         │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ CHANNELS *                                                      │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Where should this item be available?                        │ │
│ │ ☑ Shop (online marketplace)                                │ │
│ │ ☑ POS (in-store sales)                                     │ │
│ │ ☐ Restaurant Menu                                          │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ IMAGES                                                          │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [+ Upload Images] [Drag & drop or click to upload]          │ │
│ │ [Thumb 1] [Thumb 2] [Thumb 3]                               │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ FOR MENU ITEMS: MODIFIERS                                       │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [+ Add Modifier Group]                                      │ │
│ │ ┌───────────────────────────────────────────────────────┐   │ │
│ │ │ Spice Level (Required)                                │   │ │
│ │ │ ○ Mild (¥0) ○ Medium (¥0) ○ Hot (¥0) ○ Extra Hot (¥50)│   │ │
│ │ │                                       [Edit] [Delete] │   │ │
│ │ └───────────────────────────────────────────────────────┘   │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [Cancel]                              [Save & Publish Product] │
└─────────────────────────────────────────────────────────────────┘
```

---

### 3.6 Orders & Transactions Page

**URL:** `/dashboard/orders`, `/dashboard/orders/{id}`

**Purpose:** Unified view of all orders (online, POS, prepared orders) and their management.

**Layout Structure:**
```
┌──────────────────────┬──────────────────────────────────────────┐
│ SIDEBAR              │ ORDERS & TRANSACTIONS                    │
│                      │                                          │
│                      │ TABS: [All] [Online] [POS] [Pending]     │
│                      │                                          │
│                      │ FILTERS:                                 │
│                      │ [Date: Today ▼] [Status: All ▼] [Type ▼] │
│                      │                                          │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ #HL-2026-0001234          ⏱ 10 min   ││
│                      │ │ Online Order · Takeaway                ││
│                      │ │ Status: [● Preparing]                  ││
│                      │ │ 3 items · ¥1,730                       ││
│                      │ │ Customer: John D.                      ││
│                      │ │                    [View] [Update Status]│
│                      │ ├────────────────────────────────────────┤│
│                      │ │ #POS-2026-0045           Today 2:15 PM ││
│                      │ │ POS Transaction · In-store             ││
│                      │ │ Status: [✓ Completed]                  ││
│                      │ │ 5 items · ¥2,340                       ││
│                      │ │ Customer: Linked (QR)                  ││
│                      │ │                    [View] [Print Receipt]│
│                      │ └────────────────────────────────────────┘│
└──────────────────────┴──────────────────────────────────────────┘
```

---

### 3.7 Inventory Management

**URL:** `/dashboard/inventory`

**Purpose:** Monitor stock levels, receive alerts, and make manual adjustments.

**Layout Structure:**
```
┌──────────────────────┬──────────────────────────────────────────┐
│ SIDEBAR              │ INVENTORY                                │
│                      │                                          │
│                      │ SUMMARY                                  │
│                      │ ┌──────────┬──────────┬──────────┐       │
│                      │ │ 156      │ 12       │ 3        │       │
│                      │ │ Total    │ Low      │ Out of   │       │
│                      │ │ Products │ Stock    │ Stock    │       │
│                      │ └──────────┴──────────┴──────────┘       │
│                      │                                          │
│                      │ ALERTS                                   │
│                      │ ⚠ Fresh Bread Loaf - 8 remaining (low)  │
│                      │ ⚠ Lamb Chops - 3 remaining (low)        │
│                      │ ❌ Saffron Spice - Out of stock         │
│                      │                                          │
│                      │ INVENTORY TABLE                          │
│                      │ [Search] [Filter: Low Stock ▼] [Export]  │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ Product         │ Stock │ Threshold │+ ││
│                      │ │ ────────────────│───────│───────────│──││
│                      │ │ Chicken Breast  │ 25    │ 10        │🔧││
│                      │ │ Fresh Bread     │ 8 ⚠  │ 10        │🔧││
│                      │ │ Lamb Chops      │ 3 ⚠  │ 5         │🔧││
│                      │ │ Saffron Spice   │ 0 ❌  │ 2         │🔧││
│                      │ └────────────────────────────────────────┘│
│                      │                                          │
│                      │ ADJUSTMENT MODAL (when 🔧 clicked):      │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ Adjust Stock: Chicken Breast           ││
│                      │ │ Current: 25                            ││
│                      │ │ Adjustment: [+10         ]             ││
│                      │ │ Reason: [Restock from supplier     ▼] ││
│                      │ │ Notes: [                          ]    ││
│                      │ │              [Cancel] [Save Adjustment]││
│                      │ └────────────────────────────────────────┘│
└──────────────────────┴──────────────────────────────────────────┘
```

---

### 3.8 Staff & Roles Management

**URL:** `/dashboard/staff`, `/dashboard/staff/invite`

**Purpose:** Manage team members and their access permissions.

**Layout Structure:**
```
┌──────────────────────┬──────────────────────────────────────────┐
│ SIDEBAR              │ STAFF & ROLES                            │
│                      │                                          │
│                      │ [+ Invite Staff Member]                  │
│                      │                                          │
│                      │ TEAM MEMBERS                             │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ [Avatar] Sarah Johnson                 ││
│                      │ │ Owner · sarah@email.com                ││
│                      │ │ Full access to all features            ││
│                      │ │                           [You]        ││
│                      │ ├────────────────────────────────────────┤│
│                      │ │ [Avatar] Ahmed Hassan                  ││
│                      │ │ Cashier · ahmed@email.com              ││
│                      │ │ POS access, view orders                ││
│                      │ │              [Edit Role] [Remove]      ││
│                      │ ├────────────────────────────────────────┤│
│                      │ │ [Avatar] Pending Invitation            ││
│                      │ │ Cashier · maria@email.com              ││
│                      │ │ Invited 2 days ago                     ││
│                      │ │              [Resend] [Cancel]         ││
│                      │ └────────────────────────────────────────┘│
│                      │                                          │
│                      │ ROLE PERMISSIONS                         │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ Role: Cashier                          ││
│                      │ │ ✓ Access POS                          ││
│                      │ │ ✓ View today's orders                 ││
│                      │ │ ✓ Generate receipts                   ││
│                      │ │ ✗ Manage products                     ││
│                      │ │ ✗ View analytics                      ││
│                      │ │ ✗ Manage staff                        ││
│                      │ └────────────────────────────────────────┘│
└──────────────────────┴──────────────────────────────────────────┘
```

---

### 3.9 Merchant Settings

**URL:** `/dashboard/settings`, `/dashboard/settings/pos`, `/dashboard/settings/fulfillment`

**Purpose:** Configure business settings, POS preferences, and fulfillment options.

**Settings Sections:**
- **Business Profile:** Name, address, contact, tax ID
- **Operating Hours:** Day-by-day schedule with exceptions
- **POS Settings:** Receipt header, tax rules, payment methods
- **Fulfillment Settings:** Pickup hours, delivery zones, prep time defaults
- **Notifications:** Email preferences, alert thresholds
- **Billing:** Plan details, top-up history, invoices

---

## 4. Moderator Pages

### 4.1 Moderator Dashboard

**URL:** `/mod`

**Purpose:** Central hub for content moderation with report queue and metrics.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ MODERATOR TOPBAR: [Halava] Moderation · {Mod Name}     [Logout] │
├──────────────────────┬──────────────────────────────────────────┤
│ SIDEBAR              │ MODERATION OVERVIEW                      │
│                      │                                          │
│ Dashboard ●         │ TODAY'S METRICS                          │
│ Reports Queue        │ ┌──────────┬──────────┬──────────┐       │
│ My Actions           │ │ 23       │ 8        │ 2        │       │
│ Guidelines           │ │ Pending  │ Resolved │ Escalated│       │
│                      │ │ Reports  │ Today    │          │       │
│                      │ └──────────┴──────────┴──────────┘       │
│                      │                                          │
│                      │ HIGH PRIORITY REPORTS                    │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ 🚨 Fraudulent halal certificate       ││
│                      │ │ Merchant: ABC Halal Foods              ││
│                      │ │ Reported: 2 hours ago                  ││
│                      │ │                          [Review Now →]││
│                      │ └────────────────────────────────────────┘│
│                      │                                          │
│                      │ RECENT ACTIVITY                          │
│                      │ - Resolved report #1234 (spam review)    │
│                      │ - Escalated report #1230 to admin        │
└──────────────────────┴──────────────────────────────────────────┘
```

---

### 4.2 Reports Queue

**URL:** `/mod/reports`, `/mod/reports/{id}`

**Purpose:** View and process all pending content reports.

**Report Detail Layout (`/mod/reports/{id}`):**
```
┌─────────────────────────────────────────────────────────────────┐
│ REPORT #1234                                    [← Back to Queue]│
├─────────────────────────────────────────────────────────────────┤
│ REPORT DETAILS                                                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Type: Review                                                │ │
│ │ Reported by: consumer@email.com                             │ │
│ │ Reported: January 28, 2026 at 3:45 PM                      │ │
│ │ Reason: Misleading content                                  │ │
│ │ Description: "This review appears to be fake, promoting..." │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ REPORTED CONTENT                                                │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Review by: user123                                          │ │
│ │ Rating: ★★★★★                                              │ │
│ │ "Best halal food ever! You must try this place..."         │ │
│ │ Posted: January 27, 2026                                    │ │
│ │ [View in context] [View user profile]                       │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ ACTIONS                                                         │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ○ Dismiss report (no violation)                            │ │
│ │ ○ Hide content (violates policy)                           │ │
│ │ ○ Remove content permanently                               │ │
│ │ ○ Request clarification from user                          │ │
│ │ ○ Escalate to admin                                        │ │
│ │                                                             │ │
│ │ Notes for action:                                           │ │
│ │ [Text area for moderator notes]                             │ │
│ │                                                             │ │
│ │              [Cancel]              [Submit Decision]        │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

---

## 5. Admin Pages

### 5.1 Admin Dashboard

**URL:** `/admin`

**Purpose:** Platform-wide monitoring and administrative controls.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ ADMIN TOPBAR: [Halava] Admin Panel              [Admin] [Logout]│
├──────────────────────┬──────────────────────────────────────────┤
│ SIDEBAR              │ PLATFORM OVERVIEW                        │
│                      │                                          │
│ Dashboard ●         │ KEY METRICS                              │
│ Users                │ ┌───────┬───────┬───────┬───────┐        │
│ Merchants            │ │12,450 │ 342   │¥4.2M  │ 23    │        │
│ Configuration        │ │Users  │Merch. │GMV    │Reports│        │
│ Audit Log            │ │Active │Active │Today  │Pending│        │
│ Escalations          │ └───────┴───────┴───────┴───────┘        │
│                      │                                          │
│                      │ ALERTS & ESCALATIONS                     │
│                      │ 🚨 3 escalated reports need attention    │
│                      │ ⚠ 2 merchants suspended pending review  │
│                      │                                          │
│                      │ SYSTEM HEALTH                            │
│                      │ API: ● Healthy | DB: ● Healthy          │
│                      │ Search: ● Healthy | POS Sync: ● Healthy │
└──────────────────────┴──────────────────────────────────────────┘
```

---

### 5.2 User & Merchant Management

**URL:** `/admin/users`, `/admin/users/{id}`, `/admin/merchants`, `/admin/merchants/{id}`

**Purpose:** Manage platform users and merchant accounts.

**User Detail Page (`/admin/users/{id}`):**
```
┌──────────────────────┬──────────────────────────────────────────┐
│ SIDEBAR              │ USER: John Doe                           │
│                      │                                          │
│                      │ PROFILE                                  │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ [Avatar] John Doe                      ││
│                      │ │ Email: john@email.com                  ││
│                      │ │ Role: Consumer                         ││
│                      │ │ Joined: December 2025                  ││
│                      │ │ Last active: 2 hours ago               ││
│                      │ │ Status: [Active]                       ││
│                      │ └────────────────────────────────────────┘│
│                      │                                          │
│                      │ ACTIVITY SUMMARY                         │
│                      │ Orders: 15 | Reviews: 8 | Reports: 0     │
│                      │                                          │
│                      │ ADMIN ACTIONS                            │
│                      │ [Suspend Account] [Reset Password]       │
│                      │ [View Activity Log] [Delete Account]     │
│                      │                                          │
│                      │ ROLE MANAGEMENT                          │
│                      │ Current roles: Consumer                  │
│                      │ [+ Add Role: Moderator ▼] [Assign]       │
└──────────────────────┴──────────────────────────────────────────┘
```

---

### 5.3 Platform Configuration

**URL:** `/admin/config`, `/admin/config/categories`, `/admin/config/tags`, `/admin/config/capabilities`

**Purpose:** Manage platform-wide settings, categories, and default configurations.

---

### 5.4 Audit Log

**URL:** `/admin/audit-log`

**Purpose:** Trace all sensitive administrative actions for accountability.

**Layout Structure:**
```
┌──────────────────────┬──────────────────────────────────────────┐
│ SIDEBAR              │ AUDIT LOG                                │
│                      │                                          │
│                      │ FILTERS:                                 │
│                      │ [Date Range] [Action Type ▼] [User ▼]   │
│                      │                                          │
│                      │ ┌────────────────────────────────────────┐│
│                      │ │ Jan 28, 2026 3:45 PM                   ││
│                      │ │ admin@halava.jp                        ││
│                      │ │ Action: Suspended merchant account     ││
│                      │ │ Target: ABC Halal Foods (ID: 12345)   ││
│                      │ │ Reason: Policy violation - fake cert  ││
│                      │ │                              [Details] ││
│                      │ ├────────────────────────────────────────┤│
│                      │ │ Jan 28, 2026 2:30 PM                   ││
│                      │ │ mod@halava.jp                          ││
│                      │ │ Action: Escalated report to admin     ││
│                      │ │ Target: Report #1230                   ││
│                      │ │ Reason: Suspected fraud                ││
│                      │ │                              [Details] ││
│                      │ └────────────────────────────────────────┘│
│                      │                                          │
│                      │ [Export Log]                             │
└──────────────────────┴──────────────────────────────────────────┘
```

---

## 6. Authentication Pages

### 6.1 Login Page

**URL:** `/auth/login`

**Purpose:** Passwordless authentication entry point.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│                         [Halava Logo]                           │
│                                                                 │
│                   Welcome to Halava                             │
│              Halal, Available Anywhere                          │
│                                                                 │
│           ┌───────────────────────────────────────┐             │
│           │ Enter your email address              │             │
│           │ [email@example.com                  ] │             │
│           │                                       │             │
│           │ [Continue with Email →]               │             │
│           │                                       │             │
│           │ ─────────── or ───────────           │             │
│           │                                       │             │
│           │ [🔵 Continue with Google]             │             │
│           │ [⚫ Continue with Apple]              │             │
│           └───────────────────────────────────────┘             │
│                                                                 │
│           New to Halava? [Create an account]                    │
│                                                                 │
│           Are you a merchant? [Register your business]          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 6.2 OTP Verification Page

**URL:** `/auth/verify`

**Purpose:** Enter OTP or magic link confirmation.

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│                         [Halava Logo]                           │
│                                                                 │
│                   Check your email                              │
│       We sent a 6-digit code to john@email.com                 │
│                                                                 │
│           ┌───────────────────────────────────────┐             │
│           │                                       │             │
│           │    [ 4 ] [ 5 ] [ 2 ] [ 8 ] [ 9 ] [ 1 ]│             │
│           │                                       │             │
│           │ [Verify →]                            │             │
│           │                                       │             │
│           │ Didn't receive the code?              │             │
│           │ [Resend code] (available in 45s)      │             │
│           │                                       │             │
│           │ [← Use a different email]             │             │
│           └───────────────────────────────────────┘             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 6.3 Merchant Registration

**URL:** `/auth/merchant/register`

**Purpose:** Merchant onboarding with minimal friction (no business type selection).

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│                         [Halava Logo]                           │
│                                                                 │
│               Register Your Business                            │
│                                                                 │
│           ┌───────────────────────────────────────┐             │
│           │ Business Name *                       │             │
│           │ [ABC Halal Foods                    ] │             │
│           │                                       │             │
│           │ Your Email *                          │             │
│           │ [owner@abchalal.com                 ] │             │
│           │                                       │             │
│           │ Phone Number                          │             │
│           │ [+81 90-1234-5678                   ] │             │
│           │                                       │             │
│           │ Business Address *                    │             │
│           │ [123 Shibuya St, Tokyo              ] │             │
│           │ [📍 Set on map]                      │             │
│           │                                       │             │
│           │ ☑ I agree to the Terms of Service   │             │
│           │   and Merchant Agreement             │             │
│           │                                       │             │
│           │ [Create Merchant Account →]           │             │
│           └───────────────────────────────────────┘             │
│                                                                 │
│           Already have an account? [Login]                      │
│                                                                 │
│    💡 You'll choose what to sell (shop, restaurant, or both)   │
│       after registration. No commitment upfront!                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 7. UI Components Inventory

This section enumerates reusable UI building blocks for consistent implementation across all pages.

### 7.1 Navigation & Layout Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Global Topbar** | Logo, search, location, profile menu | All consumer pages |
| **Merchant Topbar** | Breadcrumb identity, scoped search | Merchant shopfronts |
| **Dashboard Sidebar** | Vertical navigation for dashboards | Merchant, Mod, Admin |
| **Breadcrumbs** | Hierarchical navigation trail | Detail pages |
| **Footer** | Links, legal, "Powered by Halava" variant | All pages |
| **Tab Navigation** | Horizontal tabs for section switching | Place pages, forms |

### 7.2 Discovery & Catalog Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Search Bar** | Input with scope selector, autocomplete | Topbars, search page |
| **Filter Panel** | Collapsible filters with checkboxes/sliders | Search, catalog |
| **Sort Selector** | Dropdown for result ordering | Search, listings |
| **Product Card** | Image, name, price, merchant, quick-add | Grids, carousels |
| **Merchant Card** | Logo, name, tags, distance, status | Directory, search |
| **Category Grid** | Visual category icons/images | Home, browse |

### 7.3 Commerce Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Add-to-Cart Button** | Primary CTA with quantity, price | Product pages |
| **Quantity Selector** | Increment/decrement control | Cart, product pages |
| **Cart Drawer** | Slide-out cart summary | Global, any page |
| **Checkout Stepper** | Progress indicator for checkout | Checkout flow |
| **Order Summary** | Itemized totals, discounts | Cart, checkout |
| **Receipt View** | Formatted receipt display | Orders, POS |

### 7.4 POS Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **POS Product Grid** | Touch-optimized product tiles | POS main screen |
| **POS Cart Panel** | Current sale with line items | POS main screen |
| **Payment Selector** | Cash/Card/Other buttons | POS checkout |
| **QR Scanner** | Camera-based code scanning | Customer linking |
| **Quota Banner** | Usage warning with CTA | POS status bar |
| **Sync Indicator** | Online/offline status | POS status bar |

### 7.5 Status & Feedback Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Progress Stepper** | Horizontal status visualization | Order tracking |
| **Status Badge** | Colored label (Active, Pending, etc.) | Lists, cards |
| **Toast Notification** | Temporary success/error message | All pages |
| **Empty State** | Illustration + message + CTA | Empty lists |
| **Loading Skeleton** | Placeholder during data load | All pages |
| **Confirmation Modal** | Action confirmation dialog | Destructive actions |

### 7.6 Form Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Text Input** | Single-line text field | All forms |
| **Text Area** | Multi-line text field | Descriptions, notes |
| **Select Dropdown** | Single-choice selector | Filters, forms |
| **Checkbox Group** | Multi-select options | Filters, settings |
| **Radio Group** | Single-select options | Forms, modifiers |
| **Date/Time Picker** | Calendar and time selection | Scheduling, reports |
| **File Upload** | Drag-drop or click upload | Images, certificates |

---

## 8. Navigation Patterns

### 8.1 Primary Navigation by Role

**Consumer:**
- Global topbar with: Home, Search, Cart, Profile
- Bottom nav on mobile: Home, Search, Orders, Profile

**Merchant (Owner/Staff):**
- Dashboard sidebar with capability-based sections
- POS has dedicated full-screen interface

**Moderator:**
- Simplified sidebar: Dashboard, Reports, History

**Admin:**
- Full sidebar with all management sections

### 8.2 Deep Linking Support

All pages support direct deep linking for sharing and bookmarking:
- Product: `/m/{merchant}/products/{product}`
- Order tracking: `/orders/{id}/track`
- Group purchase invite: `/group-purchase/{code}`

### 8.3 Back Navigation

- Browser back button always works
- Breadcrumbs provide hierarchical navigation
- "Back to..." links on detail pages

---

## 9. Responsive Design Guidelines

### 9.1 Breakpoints

| Breakpoint | Width | Target Devices |
|------------|-------|----------------|
| Mobile | < 640px | Phones |
| Tablet | 640px - 1024px | Tablets, small laptops |
| Desktop | > 1024px | Laptops, desktops |

### 9.2 Mobile-First Adaptations

**Home / Explore:**
- Single-column layout
- Horizontal carousels for sections
- Bottom navigation bar

**Search Results:**
- Filters in slide-out drawer
- 2-column product grid

**Checkout:**
- Single-column stepper
- Order summary collapses to bottom sheet

**POS:**
- Optimized for tablet (landscape)
- Product grid 3-4 columns
- Cart as slide-out panel

**Dashboard:**
- Sidebar becomes hamburger menu
- Cards stack vertically

### 9.3 Touch Targets

- Minimum touch target: 44x44 px
- Adequate spacing between interactive elements
- Swipe gestures for carousels and drawers

---

## Appendix: Page-to-Journey Mapping

| Page | Supports User Journeys |
|------|----------------------|
| Home / Explore | 4.1 Buy at shop, 4.2 Order food |
| Place Page | 4.1, 4.2 |
| Merchant Shopfront | 4.1 Buy at shop |
| Product Detail | 4.1 Buy at shop |
| Menu Item Detail | 4.2 Order food |
| Cart & Checkout | 4.1, 4.2 |
| Order Tracking | 4.2 Order food |
| Purchase History | 4.3 Track expenses |
| Group Purchase | 4.1 (group variation) |
| Merchant Dashboard | 4.4 Registration |
| Capabilities | 4.4, 4.5, 4.6, 4.7 |
| POS Screen | 4.5 Operate shop with POS |
| Kitchen Queue | 4.7.1 Manage food orders |
| Products & Menu | 4.5, 4.6, 4.7 |
| Moderator Dashboard | 4.8 Moderator |
| Admin Dashboard | 4.9 Admin |

---

*End of Pages & Navigation UX Specification*
