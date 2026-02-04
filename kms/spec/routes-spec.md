# Halava — Web App Routes Specification

> **Last updated:** February 2026
> **Status:** Active specification
> **Parent document:** [[web-app-spec]]
>
> This document provides the complete URL routing specification for the Halava web application client.

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
7. [Moderator Routes](#7-moderator-routes)
8. [Admin Routes](#8-admin-routes)
9. [Route Parameters Reference](#9-route-parameters-reference)

---

## 1. URL Conventions

### 1.1 Naming Rules

- Lowercase, hyphen-separated slugs: `/purchase-history`, not `/purchaseHistory`
- Resource-based paths: `/products/{slug}`, `/orders/{id}`
- Query parameters for filtering: `?category=food&sort=price`

### 1.2 Path Prefixes

| Prefix | Audience | Description |
|--------|----------|-------------|
| `/` | Public/Consumer | Consumer-facing pages |
| `/m/{merchant}` | Public | Merchant storefronts (public) |
| `/dashboard` | Merchant | Merchant admin dashboard |
| `/pos` | Merchant Staff | Point of Sale interface |
| `/mod` | Moderator | Content moderation tools |
| `/admin` | Admin | Platform administration |

### 1.3 Authentication Requirements

| Route Pattern | Auth Required | Role Required |
|---------------|---------------|---------------|
| `/`, `/places/*`, `/products/*` | No | — |
| `/m/{merchant}/*` | No | — |
| `/cart`, `/checkout` | Yes | Consumer |
| `/orders/*`, `/profile/*`, `/saved/*` | Yes | Consumer |
| `/group-purchase/*` | Yes | Consumer |
| `/dashboard/*` | Yes | Merchant (Owner/Staff) |
| `/pos/*` | Yes | Merchant Staff |
| `/mod/*` | Yes | Moderator |
| `/admin/*` | Yes | Admin |

---

## 2. Public Routes

> Routes accessible without authentication.

### 2.1 Home & Discovery

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/` | Home / Explore | Primary landing with discovery | [[marketplace]] |
| `/search` | Search Results | Global search (places + products) | [[directory]] |
| `/places` | Places Directory | Map + list view of places | [[directory]] |
| `/places/{slug}` | Place Page | Business details, photos, halal status | [[directory]] |
| `/places/{slug}/reviews` | Place Reviews | Reviews for a place | [[reviews-ratings]] |
| `/products` | Products Browse | Browse all marketplace products | [[marketplace]] |
| `/products/{slug}` | Product Details | Product info, reviews, purchase | [[marketplace]] |
| `/products/{slug}/reviews` | Product Reviews | Reviews for a product | [[reviews-ratings]] |

### 2.2 Merchant Storefronts

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/m/{merchant}` | Merchant Shopfront | Branded storefront landing | [[marketplace]] |
| `/m/{merchant}/shop` | Merchant Products | Product catalog | [[marketplace]] |
| `/m/{merchant}/menu` | Restaurant Menu | QR menu for restaurants | [[restaurant-ops]] |
| `/m/{merchant}/menu/{item}` | Menu Item | Item details + modifiers | [[restaurant-ops]] |

### 2.3 Group Purchase (Public Entry)

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/group-purchase/{code}` | Group Lobby | Join group purchase (prompts login) | [[group-purchase]] |

---

## 3. Consumer Routes

> Routes for authenticated consumers.

### 3.1 Shopping & Checkout

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/cart` | Shopping Cart | Current cart contents | [[marketplace]] |
| `/checkout` | Checkout | Multi-step checkout flow | [[marketplace]] |
| `/m/{merchant}/checkout` | Restaurant Checkout | Restaurant order checkout | [[restaurant-ops]] |

### 3.2 Orders

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/orders` | My Orders | List of all orders | [[order-management]] |
| `/orders/{id}` | Order Details | Order tracking and status | [[order-management]] |
| `/orders/{id}/pickup` | Pickup Details | Pickup QR code and info | [[bopu]] |

### 3.3 Saved Items & Collections

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/saved` | All Saved | All saved items | [[saved-items]] |
| `/saved/places` | Saved Places | Saved places only | [[saved-items]] |
| `/saved/products` | Saved Products | Saved products only | [[saved-items]] |
| `/saved/collections` | Collections | Manage collections | [[saved-items]] |
| `/saved/collections/{id}` | Collection View | Single collection | [[saved-items]] |
| `/shared/{token}` | Shared Collection | View shared collection (public) | [[saved-items]] |

### 3.4 Expense Tracking

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/profile/expenses` | Expense Insight | Purchase history with filters | [[expense-insight]] |
| `/profile/expenses/{id}` | Transaction Detail | Receipt and breakdown | [[expense-insight]] |
| `/profile/expenses/insights` | Spending Insights | Analytics and trends | [[expense-insight]] |
| `/profile/expenses/prices` | Price History | Personal price tracking | [[expense-insight]] |
| `/profile/expenses/prices/{id}` | Item Price History | Price history for one item | [[expense-insight]] |
| `/profile/expenses/frequent` | Frequent Items | Frequently bought | [[expense-insight]] |
| `/profile/expenses/budgets` | Budgets | Budget management | [[expense-insight]] |

### 3.5 Group Purchase

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/m/{merchant}/group/new` | Create Group | Start new group purchase | [[group-purchase]] |
| `/group-purchase/{code}` | Group Lobby | View/manage group | [[group-purchase]] |
| `/group-purchase/{code}/invite` | Share Group | Invite link page | [[group-purchase]] |
| `/group-purchase/{code}/checkout` | Group Checkout | Submit group order | [[group-purchase]] |

### 3.6 Reviews

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/review/new` | Write Review | New review form | [[reviews-ratings]] |
| `/profile/reviews` | My Reviews | User's review history | [[reviews-ratings]] |

### 3.7 Profile & Settings

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/profile` | User Profile | Personal settings | [[onboarding]] |
| `/profile/qr` | My QR Code | QR for in-store linking | [[expense-insight]] |
| `/settings` | Settings | Account settings | [[onboarding]] |
| `/settings/notifications` | Notification Settings | Notification preferences | [[notifications]] |
| `/settings/language` | Language | Language preference | [[multi-language]] |

---

## 4. Merchant Dashboard Routes

> Routes for merchant owners and staff with dashboard access.

### 4.1 Overview

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard` | Dashboard Home | Overview and quick actions | [[onboarding]] |
| `/dashboard/capabilities` | Capabilities | Enable/configure capabilities | [[onboarding]] |

### 4.2 Orders & Fulfillment

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/orders` | Orders | All orders and transactions | [[order-management]] |
| `/dashboard/orders/{id}` | Order Details | Single order management | [[order-management]] |
| `/dashboard/orders/stats` | Order Statistics | Order analytics | [[order-management]] |

### 4.3 Products & Catalog

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/products` | Products | Product list management | [[products]] |
| `/dashboard/products/new` | Add Product | Create new product | [[products]] |
| `/dashboard/products/{id}` | Edit Product | Edit product details | [[products]] |
| `/dashboard/products/categories` | Categories | Manage categories | [[products]] |
| `/dashboard/products/import` | Import/Export | Bulk operations | [[products]] |

### 4.4 Menu Management (Restaurant)

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/menu` | Menu | Menu item management | [[restaurant-ops]] |
| `/dashboard/menu/new` | Add Menu Item | Create menu item | [[restaurant-ops]] |
| `/dashboard/menu/{id}` | Edit Menu Item | Edit menu item | [[restaurant-ops]] |

### 4.5 Kitchen

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/kitchen` | Kitchen Queue | Real-time order queue | [[restaurant-ops]] |
| `/dashboard/kitchen/display` | Kitchen Display | Full-screen kitchen mode | [[restaurant-ops]] |

### 4.6 Inventory

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/inventory` | Inventory | Stock status dashboard | [[inventory]] |
| `/dashboard/inventory/{id}` | Stock Details | Product stock management | [[inventory]] |
| `/dashboard/inventory/adjustments` | Adjustments | Stock adjustment history | [[inventory]] |
| `/dashboard/inventory/stocktake` | Stocktake | Physical inventory count | [[inventory]] |
| `/dashboard/inventory/stocktake/{id}` | Stocktake Session | Active stocktake | [[inventory]] |
| `/dashboard/inventory/alerts` | Low Stock Alerts | Alert management | [[inventory]] |

### 4.7 Promotions

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/promotions` | Promotions | All promotions | [[promotions]] |
| `/dashboard/promotions/new` | Create Promotion | New coupon/discount | [[promotions]] |
| `/dashboard/promotions/{id}` | Edit Promotion | Edit promotion | [[promotions]] |
| `/dashboard/promotions/featured` | Featured Listings | Manage featured items | [[promotions]] |

### 4.8 Accounting

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/accounting` | Accounting | Financial overview | [[accounting]] |
| `/dashboard/accounting/sales` | Sales Report | Revenue analysis | [[accounting]] |
| `/dashboard/accounting/expenses` | Expenses | Expense ledger | [[accounting]] |
| `/dashboard/accounting/invoices` | Invoices | Invoice management | [[accounting]] |
| `/dashboard/accounting/invoices/new` | Create Invoice | New invoice | [[accounting]] |
| `/dashboard/accounting/invoices/{id}` | Invoice Detail | View/edit invoice | [[accounting]] |
| `/dashboard/accounting/tax` | Tax Export | Tax report generation | [[accounting]] |

### 4.9 Directory Listing

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/place` | Place Listing | Directory listing setup | [[directory]] |
| `/dashboard/pickup-locations` | Pickup Locations | BOPU location management | [[bopu]] |

### 4.10 Staff & Roles

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/staff` | Staff | Team member management | [[roles-permissions]] |
| `/dashboard/staff/invite` | Invite Staff | Send staff invitation | [[roles-permissions]] |
| `/dashboard/staff/{id}` | Staff Member | Edit staff details | [[roles-permissions]] |
| `/dashboard/roles` | Roles | Custom role management | [[roles-permissions]] |
| `/dashboard/roles/{id}` | Edit Role | Configure role permissions | [[roles-permissions]] |

### 4.11 Settings

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/settings` | Settings | Business configuration | [[onboarding]] |
| `/dashboard/settings/profile` | Business Profile | Edit business info | [[onboarding]] |
| `/dashboard/settings/notifications` | Notifications | Alert preferences | [[notifications]] |
| `/dashboard/settings/pos` | POS Settings | POS configuration | [[pos]] |
| `/dashboard/settings/orders` | Order Settings | Order preferences | [[order-management]] |

### 4.12 QR Codes

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/dashboard/qr-codes` | QR Codes | Manage QR codes | [[restaurant-ops]] |
| `/dashboard/qr-codes/generate` | Generate QR | Create new QR codes | [[restaurant-ops]] |

---

## 5. POS Routes

> Point of Sale interface for in-store transactions.

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/pos` | POS Main | Primary cashier interface | [[pos]] |
| `/pos/prepared-orders` | Prepared Orders | Orders awaiting payment | [[pos]] |
| `/pos/transactions` | Transactions | Today's transaction history | [[pos]] |
| `/pos/transactions/{id}` | Transaction Detail | Single transaction | [[pos]] |
| `/pos/kitchen` | Kitchen Queue | Kitchen view (compact) | [[restaurant-ops]] |
| `/pos/quota` | Quota Status | Usage and top-up | [[pos]] |
| `/pos/settings` | POS Settings | Quick POS config | [[pos]] |

---

## 6. Restaurant Routes

> Consumer-facing restaurant ordering via QR.

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/m/{merchant}/menu` | QR Menu | Browse menu | [[restaurant-ops]] |
| `/m/{merchant}/menu?table={n}` | Table Menu | Menu with table pre-filled | [[restaurant-ops]] |
| `/m/{merchant}/menu/{item}` | Menu Item | Item detail + modifiers | [[restaurant-ops]] |
| `/m/{merchant}/cart` | Restaurant Cart | Current order | [[restaurant-ops]] |
| `/m/{merchant}/checkout` | Restaurant Checkout | Complete order | [[restaurant-ops]] |
| `/orders/{id}` | Order Status | Real-time tracking | [[restaurant-ops]] |

---

## 7. Moderator Routes

> Content moderation interface.

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/mod` | Mod Dashboard | Moderation overview | [[admin-moderation]] |
| `/mod/reports` | Reports Queue | Pending reports | [[admin-moderation]] |
| `/mod/reports/{id}` | Report Detail | Review report | [[admin-moderation]] |
| `/mod/content` | Flagged Content | Auto-flagged content | [[admin-moderation]] |
| `/mod/content/{id}` | Content Detail | Review content | [[admin-moderation]] |
| `/mod/audit` | Audit Log | Moderation history | [[admin-moderation]] |

---

## 8. Admin Routes

> Platform administration interface.

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/admin` | Admin Dashboard | Platform overview | [[admin-moderation]] |
| `/admin/users` | Users | User management | [[admin-moderation]] |
| `/admin/users/{id}` | User Detail | View/edit user | [[admin-moderation]] |
| `/admin/merchants` | Merchants | Merchant management | [[admin-moderation]] |
| `/admin/merchants/{id}` | Merchant Detail | View/edit merchant | [[admin-moderation]] |
| `/admin/escalations` | Escalations | Escalated issues | [[admin-moderation]] |
| `/admin/escalations/{id}` | Escalation Detail | Handle escalation | [[admin-moderation]] |
| `/admin/settings` | Platform Settings | Global configuration | [[admin-moderation]] |
| `/admin/announcements` | Announcements | System announcements | [[admin-moderation]] |

---

## 9. Authentication Routes

> Login, registration, and verification flows.

| Route | Page | Description | Feature |
|-------|------|-------------|---------|
| `/login` | Sign In | Email/OAuth login | [[authentication]] |
| `/signup` | Sign Up | Consumer registration | [[onboarding]] |
| `/merchant/signup` | Merchant Sign Up | Merchant registration | [[onboarding]] |
| `/verify` | Verify | OTP/magic link entry | [[authentication]] |
| `/check-email` | Check Email | Magic link sent confirmation | [[authentication]] |
| `/logout` | Logout | Sign out (redirect) | [[authentication]] |

---

## 10. Route Parameters Reference

### 10.1 Path Parameters

| Parameter | Format | Example | Description |
|-----------|--------|---------|-------------|
| `{slug}` | kebab-case string | `halal-mart-shibuya` | URL-friendly identifier |
| `{id}` | UUID | `550e8400-e29b-41d4-a716-446655440000` | Unique resource ID |
| `{merchant}` | slug or ID | `salam-kitchen` | Merchant identifier |
| `{code}` | alphanumeric | `ABC123` | Group purchase invite code |
| `{item}` | slug or ID | `beef-rendang` | Menu/product item |
| `{token}` | alphanumeric | `share_xyz123` | Share token |

### 10.2 Common Query Parameters

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

| Section | Route Count |
|---------|-------------|
| Public Routes | 12 |
| Consumer Routes | 28 |
| Merchant Dashboard Routes | 42 |
| POS Routes | 7 |
| Restaurant Routes | 6 |
| Moderator Routes | 6 |
| Admin Routes | 9 |
| Authentication Routes | 6 |
| **Total** | **116** |

---

#halava #spec #routes #navigation
