# Halava — Web App Routes Specification

> **Last updated:** March 2026
> **Status:** Active specification
> **Parent document:** [[web-app-spec]]
>
> This document provides the complete URL routing specification for the Halava web application client.
> Routes are sourced from the implementation at `halava.dev/src/app/`.

---

## Related Documents

- [[web-app-spec]] — Full product specification
- [[pages-navigation-ux-spec]] — Page layouts and navigation UX
- [[api-spec]] — Backend API contracts
- [[architecture]] — Technical implementation

---

## Table of Contents

1. [URL Conventions](#1-url-conventions)
2. [Public Routes](#2-public-routes)
3. [Consumer Routes](#3-consumer-routes)
4. [Merchant Dashboard Routes](#4-merchant-dashboard-routes)
5. [POS Routes](#5-pos-routes)
6. [Restaurant Routes](#6-restaurant-routes)
7. [App Platform Routes](#7-app-platform-routes)
8. [Moderator Routes](#8-moderator-routes)
9. [Admin Routes](#9-admin-routes)
10. [Authentication Routes](#10-authentication-routes)
11. [Route Parameters Reference](#11-route-parameters-reference)

---

## 1. URL Conventions

### 1.1 Naming Rules

- Lowercase, hyphen-separated slugs: `/group-order`, not `/groupOrder`
- Resource-based paths: `/products/{slug}`, `/orders/{id}`
- Query parameters for filtering: `?category=food&sort=price`

### 1.2 Path Prefixes

| Prefix | Audience | Description |
|--------|----------|-------------|
| `/` | Public/Consumer | Consumer-facing pages |
| `/m/{merchant}` | Public | Merchant storefronts (public) |
| `/dashboard` | Merchant | Merchant admin dashboard |
| `/pos` | Merchant Staff | Point of Sale interface |
| `/apps` | Consumer | App store & connected apps |
| `/app/{slug}` | Consumer | Running app instance |
| `/mod` | Moderator | Content moderation tools |
| `/admin` | Admin | Platform administration |

### 1.3 Authentication Requirements

| Route Pattern | Auth Required | Role Required |
|---------------|---------------|---------------|
| `/`, `/places/*`, `/products/*` | No | — |
| `/m/{merchant}/*` | No | — |
| `/cart`, `/checkout` | Yes | Consumer |
| `/orders/*`, `/saved/*` | Yes | Consumer |
| `/group-order/*` | Yes | Consumer |
| `/apps/*`, `/app/*` | Yes | Consumer |
| `/messages/*` | Yes | Consumer |
| `/dashboard/*` | Yes | Merchant (Owner/Staff) |
| `/pos/*` | Yes | Merchant Staff |
| `/mod/*` | Yes | Moderator |
| `/admin/*` | Yes | Admin |

### 1.4 Route Groups

The implementation uses Next.js route groups for shared layouts:

| Group | Purpose | Layout Includes |
|-------|---------|-----------------|
| `(topbar-pages)` | Consumer discovery pages | GlobalTopbar, BottomTabBar, Footer |

Routes inside `(topbar-pages)` share a persistent navigation shell. The group name does not appear in the URL.

---

## 2. Public Routes

> Routes accessible without authentication.

### 2.1 Home & Discovery

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/` | Home / Explore | Primary landing with discovery | ✅ |
| `/search` | Search Results | Global search (places + products) | ✅ |
| `/places` | Places Directory | List view of halal places | ✅ |
| `/places/{slug}` | Place Page | Business details, photos, halal status | ✅ |
| `/places/{slug}/reviews` | Place Reviews | Reviews for a place | ❌ |
| `/products` | Products Browse | Browse all marketplace products | ✅ |
| `/products/{slug}` | Product Details | Product info, purchase | ✅ |
| `/products/{slug}/reviews` | Product Reviews | Reviews for a product | ❌ |

### 2.2 Product Category Pages

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/products/beverages` | Beverages | Beverages category browse | ✅ |
| `/products/canned` | Canned Goods | Canned goods category | ✅ |
| `/products/frozen` | Frozen Products | Frozen products category | ✅ |
| `/products/grains` | Grains | Grains category | ✅ |
| `/products/packaged` | Packaged Goods | Packaged goods category | ✅ |
| `/products/snacks` | Snacks | Snacks category | ✅ |
| `/products/spices` | Spices | Spices category | ✅ |

### 2.3 Discovery Pages

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/restaurants` | Restaurants | Restaurant-only browse | ✅ |
| `/restaurants/{slug}` | Restaurant Detail | Restaurant details | ✅ |
| `/community` | Community | Community page | ✅ |
| `/deals` | Deals | Deals listing | ✅ |
| `/new-arrivals` | New Arrivals | New arrivals feed | ✅ |
| `/ramadan` | Ramadan | Ramadan seasonal page | ✅ |
| `/groceries` | Groceries | Groceries browse | ✅ |
| `/groceries/{slug}` | Grocery Category | Grocery category detail | ✅ |

### 2.4 Merchant Storefronts

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/m/{merchant}` | Merchant Shopfront | Branded storefront (products shown as tab) | ✅ |
| `/m/{merchant}/menu` | Restaurant Menu | QR menu for restaurants | ✅ |

> **Note:** Menu item details are shown in a dialog/sheet inside `/m/{merchant}/menu`, not as a sub-route. Products are shown as a tab on the merchant page, not at `/m/{merchant}/shop`.

### 2.5 Static & Info Pages

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/about` | About | Mission and values | ✅ |
| `/help` | Help / FAQ | FAQ accordion | ✅ |
| `/contact` | Contact | Contact form and info | ✅ |
| `/terms` | Terms of Service | Legal terms | ✅ |
| `/privacy` | Privacy Policy | Privacy policy | ✅ |

---

## 3. Consumer Routes

> Routes for authenticated consumers.

### 3.1 Shopping & Checkout

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/cart` | Shopping Cart | Current cart contents | ✅ |
| `/checkout` | Checkout | Multi-step checkout flow | ✅ |

### 3.2 Orders

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/orders` | My Orders | List of all orders | ✅ |
| `/orders/{id}` | Order Details | Order tracking and status | ✅ |
| `/orders/{id}/pickup` | Pickup Details | Pickup QR code and info | ❌ |

### 3.3 Saved Items & Collections

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/saved` | All Saved | All saved items (places + products tabs) | ✅ |
| `/saved/places` | Saved Places | Saved places only | ❌ |
| `/saved/products` | Saved Products | Saved products only | ❌ |
| `/saved/collections` | Collections | Manage collections | ❌ |
| `/saved/collections/{id}` | Collection View | Single collection | ❌ |
| `/shared/{token}` | Shared Collection | View shared collection (public) | ❌ |

### 3.4 Group Order

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/group-order` | Group Orders | Group order listing | ✅ |
| `/group-order/new` | New Group Order | Start new group order | ✅ |
| `/group-order/{code}` | Group Lobby | View/manage group | ✅ |
| `/group-order/{code}/checkout` | Group Checkout | Submit group order | ✅ |
| `/group-order/join` | Join Group | Join page (no code) | ✅ |
| `/group-order/join/{code}` | Join Group | Join group via invite code | ✅ |
| `/group-order/favorites` | Favorites | Favorite group orders | ✅ |
| `/m/{merchant}/group-order/new` | Create Group | Start group order for merchant | ✅ |

### 3.5 Reviews

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/review/new` | Write Review | New review form | ❌ |
| `/profile/reviews` | My Reviews | User's review history | ❌ |

### 3.6 Messaging

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/messages` | Messages Inbox | All conversations | ✅ |
| `/messages/{merchantSlug}` | Conversation | Conversation thread with merchant | ✅ |

### 3.7 Profile & Settings

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/profile` | User Profile | Personal settings | ✅ |
| `/profile/qr` | My QR Code | QR for in-store linking | ❌ |
| `/settings` | Settings | Account settings | ✅ |
| `/settings/notifications` | Notification Settings | Notification preferences | ❌ |
| `/settings/language` | Language | Language preference | ❌ |

### 3.8 Notifications

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/notifications` | Notifications | Notification list page | ❌ |

---

## 4. Merchant Dashboard Routes

> Routes for merchant owners and staff with dashboard access.

### 4.1 Overview

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard` | Dashboard Home | Overview and quick actions | ✅ |
| `/dashboard/capabilities` | Capabilities | Enable/configure capabilities | ❌ |

### 4.2 Orders & Fulfillment

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/orders` | Orders | All orders and transactions | ✅ |
| `/dashboard/orders/{id}` | Order Details | Single order management | ✅ |

### 4.2b Sales Analytics

> Enterprise-grade analytics for understanding business performance. Follows the same sub-page pattern as Accounting.

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/analytics` | Analytics Home | Overview dashboard with key metrics | ❌ |
| `/dashboard/analytics/sales` | Sales Report | Revenue breakdown by period, channel, product | ❌ |
| `/dashboard/analytics/customers` | Customer Insights | Customer behavior, retention, cohorts | ❌ |
| `/dashboard/analytics/products` | Product Performance | Best/worst sellers, margin analysis | ❌ |
| `/dashboard/analytics/channels` | Channel Analysis | Online vs POS vs restaurant performance | ❌ |
| `/dashboard/analytics/trends` | Trends | Historical trends, forecasting, seasonality | ❌ |

### 4.3 Products & Catalog

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/products` | Products | Product list management | ✅ |
| `/dashboard/products/new` | Add Product | Create new product | ✅ |
| `/dashboard/products/{id}` | Edit Product | Edit product details | ✅ |
| `/dashboard/products/categories` | Categories | Manage categories | ❌ |
| `/dashboard/products/import` | Import/Export | Bulk operations | ❌ |

### 4.4 Menu Management (Restaurant)

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/menu` | Menu | Menu item management (includes QR code generation tab) | ✅ |

> **Note:** Menu item add/edit is handled inline in the split-panel UI. QR code generation is a tab inside `/dashboard/menu`, not a separate route.

### 4.5 Kitchen

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/kitchen` | Kitchen Queue | Real-time order queue (includes fullscreen display toggle) | ✅ |
| `/kitchen` | Kitchen Display | Standalone kitchen display page | ✅ |

> **Note:** The fullscreen kitchen display is available both as a toggle overlay inside `/dashboard/kitchen` and as a standalone page at `/kitchen`.

### 4.6 Inventory

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/inventory` | Inventory | Stock status dashboard | ✅ |
| `/dashboard/inventory/history` | Stock History | Stock adjustment history | ✅ |
| `/dashboard/inventory/{id}` | Stock Details | Product stock management | ❌ |
| `/dashboard/inventory/adjustments` | Adjustments | Stock adjustment log | ❌ |
| `/dashboard/inventory/stocktake` | Stocktake | Physical inventory count | ❌ |
| `/dashboard/inventory/stocktake/{id}` | Stocktake Session | Active stocktake | ❌ |
| `/dashboard/inventory/alerts` | Low Stock Alerts | Alert management | ❌ |

### 4.7 Promotions

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/promotions` | Promotions | All promotions | ❌ |
| `/dashboard/promotions/new` | Create Promotion | New coupon/discount | ❌ |
| `/dashboard/promotions/{id}` | Edit Promotion | Edit promotion | ❌ |
| `/dashboard/promotions/featured` | Featured Listings | Manage featured items | ❌ |

### 4.8 Accounting

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/accounting` | Accounting | Financial overview | ❌ |
| `/dashboard/accounting/sales` | Sales Report | Revenue analysis | ❌ |
| `/dashboard/accounting/expenses` | Expenses | Expense ledger | ❌ |
| `/dashboard/accounting/invoices` | Invoices | Invoice management | ❌ |
| `/dashboard/accounting/invoices/new` | Create Invoice | New invoice | ❌ |
| `/dashboard/accounting/invoices/{id}` | Invoice Detail | View/edit invoice | ❌ |
| `/dashboard/accounting/tax` | Tax Export | Tax report generation | ❌ |

### 4.9 Directory Listing & Location

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/place` | Place Listing | Directory listing setup | ✅ |
| `/dashboard/pickup-locations` | Pickup Locations | BOPU location management | ❌ |

### 4.10 Staff & Roles

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/staff` | Staff & Roles | Team members + roles/permissions (combined as tabs) | ✅ |

> **Note:** Staff invite, staff detail editing, role management, and role editing are all handled inline within `/dashboard/staff` (tabs and modals), not as separate routes.

### 4.11 Billing

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/billing` | Billing | Usage fees, SKU breakdown, monthly invoice | ✅ |

### 4.12 Merchant Messaging

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/messages` | Messages | Merchant message inbox | ✅ |

### 4.13 Settings

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/dashboard/settings` | Settings | Business configuration | ✅ |
| `/dashboard/settings/profile` | Business Profile | Edit business info | ❌ |
| `/dashboard/settings/notifications` | Notifications | Alert preferences | ❌ |
| `/dashboard/settings/pos` | POS Settings | POS configuration | ❌ |
| `/dashboard/settings/orders` | Order Settings | Order preferences | ❌ |

---

## 5. POS Routes

> Point of Sale interface for in-store transactions (desktop only).

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/pos` | POS Main | Primary cashier interface | ✅ |
| `/pos/transactions` | Transactions | Today's transaction history | ✅ |
| `/pos/settings` | POS Settings | Quick POS config | ✅ |
| `/pos/prepared-orders` | Prepared Orders | Orders awaiting payment | ❌ |
| `/pos/transactions/{id}` | Transaction Detail | Single transaction | ❌ |
| `/pos/usage` | Usage | Monthly walk-in transaction count | ❌ |

> **Note:** Kitchen view is not needed as a POS sub-route. Kitchen display is available at `/kitchen` as a standalone page.

---

## 6. Restaurant Routes

> Consumer-facing restaurant ordering via QR.

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/m/{merchant}/menu` | QR Menu | Browse menu | ✅ |
| `/m/{merchant}/menu?table={n}` | Table Menu | Menu with table pre-filled | ✅ |

> **Note:** Menu item details are shown in a dialog inside `/m/{merchant}/menu`. Restaurant cart uses a floating sheet, not a separate route.

---

## 7. App Platform Routes

> Halava App Platform for first-party and third-party apps.

### 7.1 App Store

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/apps` | Installed Apps | Grid of connected apps | ✅ |
| `/apps/explore` | Explore | Browse all available apps | ✅ |
| `/apps/categories` | Categories | Browse apps by category | ✅ |
| `/apps/featured` | Featured | Featured apps | ✅ |
| `/apps/top-apps` | Top Apps | Top apps listing | ✅ |
| `/apps/lifestyle` | Lifestyle | Lifestyle category apps | ✅ |
| `/apps/productivity` | Productivity | Productivity category apps | ✅ |
| `/apps/updates` | Updates | App update notifications | ✅ |
| `/apps/{slug}` | App Detail | App detail / install page | ✅ |

### 7.2 App Runner

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/app/{slug}` | Running App | Running app instance | ✅ |

First-party apps:
- `expense-insight` — Expense tracking, spending insights, personal price history
- `noor-trail` — Logging halal place visits
- `simple-reader` — Reading app

---

## 8. Moderator Routes

> Content moderation interface.

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/mod` | Mod Dashboard | Moderation overview | ❌ |
| `/mod/reports` | Reports Queue | Pending reports | ❌ |
| `/mod/reports/{id}` | Report Detail | Review report | ❌ |
| `/mod/content` | Flagged Content | Auto-flagged content | ❌ |
| `/mod/content/{id}` | Content Detail | Review content | ❌ |
| `/mod/audit` | Audit Log | Moderation history | ❌ |

---

## 9. Admin Routes

> Platform administration interface.

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/admin` | Admin Dashboard | Platform overview | ❌ |
| `/admin/users` | Users | User management | ❌ |
| `/admin/users/{id}` | User Detail | View/edit user | ❌ |
| `/admin/merchants` | Merchants | Merchant management | ❌ |
| `/admin/merchants/{id}` | Merchant Detail | View/edit merchant | ❌ |
| `/admin/escalations` | Escalations | Escalated issues | ❌ |
| `/admin/escalations/{id}` | Escalation Detail | Handle escalation | ❌ |
| `/admin/settings` | Platform Settings | Global configuration | ❌ |
| `/admin/announcements` | Announcements | System announcements | ❌ |

---

## 10. Authentication Routes

> Login, registration, and verification flows.

| Route | Page | Description | Status |
|-------|------|-------------|--------|
| `/login` | Sign In | Email/OAuth login | ✅ |
| `/signup` | Sign Up | Consumer registration | ✅ |
| `/verify` | Verify | OTP/magic link entry | ✅ |
| `/check-email` | Check Email | Magic link sent confirmation | ✅ |
| `/dashboard/create` | Create Merchant | Existing user creates a new merchant (becomes Owner) | ❌ |

> **Note:** There is no separate `/merchant/signup` — merchant creation is done by an existing Halava user who then becomes the Owner of that merchant. Logout is handled via `AuthContext` (clear tokens → redirect to home), not as a dedicated route.

---

## 11. Route Parameters Reference

### 11.1 Path Parameters

| Parameter | Format | Example | Description |
|-----------|--------|---------|-------------|
| `{slug}` | kebab-case string | `halal-mart-shibuya` | URL-friendly identifier |
| `{id}` | UUID | `550e8400-e29b-41d4-a716-446655440000` | Unique resource ID |
| `{merchant}` | slug or ID | `salam-kitchen` | Merchant identifier |
| `{code}` | alphanumeric | `ABC123` | Group order invite code |
| `{merchantSlug}` | kebab-case string | `salam-kitchen` | Merchant identifier for messaging |
| `{token}` | alphanumeric | `share_xyz123` | Share token |

### 11.2 Common Query Parameters

| Parameter | Type | Example | Description |
|-----------|------|---------|-------------|
| `q` | string | `?q=halal+chicken` | Search query |
| `category` | string | `?category=meat` | Category filter |
| `sort` | string | `?sort=price_asc` | Sort order |
| `page` | number | `?page=2` | Pagination |
| `limit` | number | `?limit=20` | Results per page |
| `table` | number | `?table=5` | Table number (restaurant) |
| `type` | string | `?type=place` | Resource type filter |
| `status` | string | `?status=pending` | Status filter |
| `from` | date | `?from=2026-01-01` | Date range start |
| `to` | date | `?to=2026-01-31` | Date range end |

---

## Appendix: Route Count Summary

| Section | Implemented | Not Started | Total |
|---------|-------------|-------------|-------|
| Public Routes | 22 | 2 | 24 |
| Consumer Routes | 13 | 9 | 22 |
| Merchant Dashboard | 14 | 19 | 33 |
| POS Routes | 3 | 3 | 6 |
| Restaurant Routes | 2 | 0 | 2 |
| App Platform Routes | 10 | 0 | 10 |
| Moderator Routes | 0 | 6 | 6 |
| Admin Routes | 0 | 9 | 9 |
| Authentication Routes | 4 | 1 | 5 |
| **Total** | **68** | **49** | **117** |

---

#halava #spec #routes #navigation
