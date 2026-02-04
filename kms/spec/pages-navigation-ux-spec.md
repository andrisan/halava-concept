# Halava — Web App Pages & Navigation UX Specification

> **Last updated:** February 2026
> **Status:** Active specification
> **Parent document:** [[web-app-spec]]
>
> This document defines cross-cutting UX patterns: template architecture, URL structure, navigation, components, and responsive design. For page-specific layouts, see individual feature documents.

---

## Related Documents

- [[web-app-spec]] — Full product specification
- [[routes-spec]] — Complete URL routing specification
- [[api-spec]] — API contracts
- [[architecture]] — Technical implementation
- [[wireframes]] — Visual wireframe specifications
- [[design-system]] — Component library

---

## Table of Contents

1. [Dual-Template Architecture](#1-dual-template-architecture)
2. [URL Structure & Routing](#2-url-structure--routing)
3. [Page Specifications by Feature](#3-page-specifications-by-feature)
4. [Navigation Patterns](#4-navigation-patterns)
5. [UI Components Inventory](#5-ui-components-inventory)
6. [Responsive Design Guidelines](#6-responsive-design-guidelines)

---

## 1. Dual-Template Architecture

> **Critical:** The mobile template is **NOT** a responsive version of the desktop template. It is a **completely separate codebase** designed like a native mobile app — with its own component tree, layouts, and navigation patterns. No desktop UI elements (hamburger menus, sidebars, hover states) exist in the mobile template. Only the desktop template uses responsive design (scaling from tablet to desktop).

Halava uses **two entirely independent templates** based on device type:

| Template | Target | Breakpoint | Architecture |
|----------|--------|------------|--------------|
| **Mobile Template** | Phones | < 640px | Separate component tree, dedicated mobile UI |
| **Desktop Template** | Tablets, laptops, desktops | ≥ 640px | Single codebase with responsive CSS (tablet ↔ desktop) |

### 1.1 Why Separate Templates (Not Responsive)

The mobile template is a distinct implementation designed like a **native mobile app**, not CSS media queries on the desktop template:

- **Native app paradigm:** No desktop elements (no hamburger menus, no sidebars, no hover states)
- **Different component trees:** Mobile and desktop render entirely different UI components
- **Different navigation structure:** Bottom tabs only (mobile) vs topbar + sidebar (desktop)
- **Different page layouts:** Not just resized — fundamentally different information architecture
- **Different interaction patterns:** Swipe gestures, bottom sheets, pull-to-refresh (no click/hover)
- **Different bundle:** Mobile loads only mobile components (smaller JS payload)
- **Different feature set:** POS, Admin, and full Merchant dashboard are desktop-only

### 1.2 What This Means for Development

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

### 1.3 Template Detection

| Method | Purpose |
|--------|---------|
| **Server-side (User-Agent)** | Initial SSR render with correct template |
| **Client-side (viewport width)** | Hydration and resize handling |
| **Template switch** | Triggers full re-render (not CSS toggle) |

### 1.4 Shared Across Templates

Both templates share:
- Design tokens (colors, typography, spacing)
- Reusable logic and state management
- API layer and data fetching
- Authentication state
- Business logic and validation

### 1.5 Template-Specific Features

| Feature | Mobile Template | Desktop Template |
|---------|-----------------|------------------|
| **Consumer browsing** | Full support | Full support |
| **Consumer checkout** | Full support | Full support |
| **Merchant dashboard** | Limited (view-only) | Full support |
| **POS** | Not supported | Full support |
| **Admin/Moderator** | Not supported | Full support |

---

## 2. URL Structure & Routing

### 2.1 URL Naming Conventions

Halava uses a consistent, RESTful URL structure designed for clarity and SEO optimization.

**Core principles:**
- Lowercase, hyphen-separated slugs (e.g., `/purchase-history`, not `/purchaseHistory`)
- Resource-based paths (e.g., `/products/{slug}`, `/orders/{id}`)
- Merchant-namespaced paths for merchant-owned pages (`/m/{merchant-slug}/...`)
- Dashboard paths grouped by role (`/dashboard/...`, `/admin/...`, `/mod/...`)
- Query parameters for filtering and search (e.g., `?category=food&sort=trending`)

### 2.2 Complete URL Map

> **Full route specification:** [[routes-spec]] — 116 routes across all user types.

Below is a summary of key routes. See [[routes-spec]] for the complete listing.

#### Public (Consumer) Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/` | Home / Explore | Primary marketplace landing page |
| `/search` | Search Results | Global search results across all merchants |
| `/places` | Places Directory | Map + list view of all merchants |
| `/places/{slug}` | Place Page | Business details, photos, halal status |
| `/products` | Products | Browse all marketplace products |
| `/products/{slug}` | Product Details | Product info, reviews, purchase |
| `/m/{merchant}` | Merchant Shopfront | Merchant-owned branded storefront |
| `/m/{merchant}/menu` | Restaurant Menu | QR menu for restaurants |
| `/cart` | Shopping Cart | Current cart contents and actions |
| `/checkout` | Checkout | Multi-step checkout flow |
| `/orders` | My Orders | List of all consumer orders |
| `/orders/{id}` | Order Details | Order tracking and status |
| `/saved` | Saved Items | All saved places and products |
| `/profile/expenses` | Expense Tracker | Expense tracking and insights |
| `/group-purchase/{code}` | Group Purchase | Join/manage group purchase |
| `/profile` | User Profile | Personal settings and preferences |

#### Merchant Dashboard Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/dashboard` | Merchant Dashboard | Overview and quick actions |
| `/dashboard/capabilities` | Capabilities | Enable/configure business capabilities |
| `/dashboard/products` | Products | Product catalog management |
| `/dashboard/menu` | Menu | Restaurant menu management |
| `/dashboard/orders` | Orders | All orders and transactions |
| `/dashboard/kitchen` | Kitchen Queue | Real-time kitchen order management |
| `/dashboard/inventory` | Inventory | Stock levels and alerts |
| `/dashboard/promotions` | Promotions | Coupons and discounts |
| `/dashboard/accounting` | Accounting | Financial overview and reports |
| `/dashboard/staff` | Staff & Roles | Team member management |
| `/dashboard/settings` | Settings | Business configuration |

#### POS Routes (Desktop Only)

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/pos` | POS Main Screen | Primary cashier interface |
| `/pos/prepared-orders` | Prepared Orders Queue | Orders awaiting payment |
| `/pos/transactions` | Today's Transactions | Daily transaction history |
| `/pos/kitchen` | Kitchen Queue | Real-time order preparation |

#### Admin & Moderator Routes (Desktop Only)

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/mod` | Mod Dashboard | Content moderation overview |
| `/mod/reports` | Reports Queue | Pending content reports |
| `/admin` | Admin Dashboard | Platform administration |
| `/admin/users` | Users | User management |
| `/admin/merchants` | Merchants | Merchant management |

---

## 3. Page Specifications by Feature

Detailed page layouts and UI specifications live in the respective feature documents:

### Consumer Features (Mobile + Desktop)

| Feature | Document | Key Screens |
|---------|----------|-------------|
| Directory & Search | [[directory#UI/UX Specification]] | Search bar, results (list/map), place page, filter sheet |
| Expense Tracker | [[expense-tracker#UI/UX Specification]] | Purchase history, insights dashboard, price history |
| Group Purchase | [[group-purchase#UI/UX Specification]] | Group creation, contribution, tracking |
| Saved Items | [[saved-items#UI/UX Specification]] | Bookmarked places and products |
| Reviews & Ratings | [[reviews-ratings#UI/UX Specification]] | Review form, rating display |
| BOPU | [[bopu#UI/UX Specification]] | Store selection, pickup scheduling |
| Marketplace | [[marketplace#UI/UX Specification]] | Product browsing, cart, checkout |

### Merchant Features (Desktop Only)

| Feature | Document | Key Screens |
|---------|----------|-------------|
| POS | [[pos#UI/UX Specification]] | POS main screen, checkout modal, receipt options |
| Order Management | [[order-management#UI/UX Specification]] | Orders dashboard, order details |
| Restaurant Ops | [[restaurant-ops#UI/UX Specification]] | Kitchen queue, menu management |
| Inventory | [[inventory#UI/UX Specification]] | Stock levels, alerts |
| Promotions | [[promotions#UI/UX Specification]] | Coupon management |
| Products | [[products#UI/UX Specification]] | Catalog management |
| Accounting | [[accounting#UI/UX Specification]] | Financial reports, invoicing |

### Shared Features (Mobile + Desktop)

| Feature | Document | Key Screens |
|---------|----------|-------------|
| Authentication | [[authentication#UI/UX Specification]] | Login, OTP verification |
| Onboarding | [[onboarding#UI/UX Specification]] | Consumer/merchant registration flows |
| Notifications | [[notifications#UI/UX Specification]] | Notification center, settings |

### Platform Features (Desktop Only)

| Feature | Document | Key Screens |
|---------|----------|-------------|
| Admin & Moderation | [[admin-moderation#UI/UX Specification]] | Reports queue, user management |
| Roles & Permissions | [[roles-permissions#UI/UX Specification]] | Staff management |

---

## 4. Navigation Patterns

### 4.1 Primary Navigation by Template

| User Type | Mobile Template | Desktop Template |
|-----------|-----------------|------------------|
| **Consumer** | Bottom tab bar (Home, Search, Cart, Profile) | Topbar with mega menu + sidebar filters |
| **Merchant** | Limited view-only (bottom tabs) | Dashboard sidebar + topbar quick actions |
| **POS Staff** | Not supported | POS topbar + contextual menu |
| **Admin/Mod** | Not supported | Dashboard sidebar + topbar notifications |

### 4.2 Navigation Flows

**Consumer Discovery Flow:**
```
Home → Search/Browse → Place/Product Page → Add to Cart → Cart → Checkout → Order Confirmation
```

**Merchant Order Flow:**
```
Dashboard → Orders → Order Details → Update Status → Fulfillment Complete
```

**POS Transaction Flow:**
```
POS Main → Add Items → Checkout → Payment → Receipt → Next Customer
```

### 4.3 Deep Linking

All pages support direct URL access for:
- Sharing (products, places, orders)
- Bookmarking
- QR code scanning (group purchase, menu)
- Push notification targets

### 4.4 Back Navigation

| Context | Back Behavior |
|---------|---------------|
| **Within flow** | Previous step in flow |
| **From detail page** | Return to list |
| **From search result** | Return to search with filters preserved |
| **From external link** | Home page |

---

## 5. UI Components Inventory

This section enumerates reusable UI building blocks.

> See [[design-system]] for component specifications.

### 5.1 Navigation & Layout Components

| Component | Description | Template |
|-----------|-------------|----------|
| **Global Topbar** | Logo, search, location, profile menu | Desktop |
| **Merchant Topbar** | Breadcrumb identity, scoped search | Desktop |
| **Dashboard Sidebar** | Vertical navigation for dashboards | Desktop |
| **Bottom Navigation** | Tab bar (Home, Search, Cart, Profile) | Mobile |
| **Breadcrumbs** | Hierarchical path navigation | Desktop |

### 5.2 Commerce Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Product Card** | Thumbnail, name, price, rating | Product listings |
| **Place Card** | Photo, name, distance, status | Directory listings |
| **Add-to-Cart Button** | Primary CTA with quantity, price | Product pages |
| **Cart Drawer** | Slide-out cart summary | Global, any page |
| **Checkout Stepper** | Progress indicator for checkout | Checkout flow |
| **Order Summary** | Itemized totals, discounts | Cart, checkout |

### 5.3 POS Components (Desktop Only)

| Component | Description | Usage |
|-----------|-------------|-------|
| **POS Product Grid** | Touch-optimized product tiles | POS main screen |
| **POS Cart Panel** | Current sale with line items | POS main screen |
| **Payment Selector** | Cash/Card/Other buttons | POS checkout |
| **QR Scanner** | Camera-based code scanning | Customer linking |
| **Quota Banner** | Usage warning with CTA | POS status bar |

### 5.4 Feedback Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Toast** | Transient success/error message | After actions |
| **Empty State** | Illustration + message + CTA | No results, empty lists |
| **Loading Skeleton** | Placeholder animation | Data loading |
| **Error State** | Error message + retry button | Failed requests |

---

## 6. Responsive Design Guidelines

### 6.1 Breakpoints

**Mobile Template (< 640px):**
- Single breakpoint, optimized for phones
- Fixed bottom navigation
- Full-screen modals and sheets

**Desktop Template (≥ 640px) — Responsive within template:**

| Breakpoint | Width | Target Devices |
|------------|-------|----------------|
| Tablet | 640px - 1024px | Tablets, small laptops |
| Desktop | > 1024px | Laptops, desktops |

### 6.2 Layout Adaptations

| Element | Mobile Template | Desktop Template (Tablet) | Desktop Template (Desktop) |
|---------|-----------------|---------------------------|----------------------------|
| **Navigation** | Bottom tabs | Topbar | Topbar + sidebar |
| **Product Grid** | 2 columns | 3 columns | 4-5 columns |
| **Place List** | Card stack | Cards | Cards + map split |
| **Dashboard** | Limited view-only | Sidebar collapsed | Sidebar expanded |
| **POS** | Not supported | Split view | Split view |
| **Checkout** | Full-screen steps | Modal | Side panel |

### 6.3 Touch Targets

- Minimum touch target: 44x44 px
- Adequate spacing between interactive elements
- Swipe gestures for carousels and drawers

### 6.4 Mobile Template Considerations

Designed like a native mobile app:

- Bottom tab navigation (no hamburger menus or sidebars)
- Full-screen pages with back gesture (no nested modals)
- Thumb-friendly actions at bottom of screen
- Native patterns: swipe back, pull to refresh, bottom sheets
- Progressive disclosure (show less, reveal on demand)
- Offline support for browsing cached content

---

#halava #spec #ux #navigation
