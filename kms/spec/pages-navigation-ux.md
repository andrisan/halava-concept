# Halava — Web App Pages & Navigation UX Specification

> **Last updated:** February 2026
> **Status:** Active specification
> **Parent document:** [[web-app-spec]]
>
> This document provides the comprehensive UI/UX specification for all pages and navigation flows in the Halava web application.

---

## Related Documents

- [[web-app-spec]] — Full product specification
- [[architecture]] — Technical implementation
- [[api-spec]] — API contracts
- [[wireframes]] — Visual wireframe specifications
- [[design-system]] — Component library

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
| `/places` | Places Directory | Map + list view of all merchants |
| `/places/{merchant-slug}` | Place Page | Business details, photos, halal status |
| `/m/{merchant-slug}` | Merchant Shopfront | Merchant-owned branded storefront |
| `/cart` | Shopping Cart | Current cart contents and actions |
| `/checkout` | Checkout | Multi-step checkout flow |
| `/orders` | My Orders | List of all consumer orders |
| `/purchase-history` | Purchase History | Unified expense tracking view |
| `/group-purchase/{invite-code}` | Group Purchase Join | Join a group purchase via invite link |
| `/profile` | User Profile | Personal settings and preferences |

#### Merchant Dashboard Routes

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/dashboard` | Merchant Dashboard | Overview and quick actions |
| `/dashboard/capabilities` | Capabilities | Enable/configure business capabilities |
| `/dashboard/products` | Products & Menu | Product and menu item management |
| `/dashboard/orders` | Orders & Transactions | All orders and POS transactions |
| `/dashboard/kitchen` | Kitchen Order Queue | Real-time kitchen order management |
| `/dashboard/inventory` | Inventory | Stock levels and alerts |
| `/dashboard/staff` | Staff & Roles | Team member management |
| `/dashboard/settings` | Settings | Business and POS configuration |

#### POS Routes (Merchant Staff)

| URL Path | Page Name | Description |
|----------|-----------|-------------|
| `/pos` | POS Main Screen | Primary cashier interface |
| `/pos/prepared-orders` | Prepared Orders Queue | Orders awaiting payment |
| `/pos/transactions` | Today's Transactions | Daily transaction history |
| `/pos/kitchen` | Kitchen Queue | Real-time order preparation (v1.1) |

---

## 2. Consumer-Facing Pages

### 2.1 Home / Explore Page

**URL:** `/`

**Purpose:** Primary marketplace landing page where consumers discover halal products, restaurants, and shops.

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

### 2.2 POS Screen

**URL:** `/pos`

**Purpose:** Cashier interface for processing in-store sales and prepared orders.

> See [[monetization#POS Transaction Quota & Top-ups]] for quota logic.

**POS Main Screen Layout:**
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
│ │ 🍗  │ │ 🥩  │ │ 🧀  │         │ └──────────────────────────┘ │
│ │¥450 │ │¥800 │ │¥350 │         │                              │
│ └─────┘ └─────┘ └─────┘         │ TOTAL:               ¥1,485 │
│                                  │                              │
│                                  │ [Complete Sale - ¥1,485]    │
├──────────────────────────────────┴──────────────────────────────┤
│ STATUS BAR: ● Online  |  Quota: 245/300 this month  |  [Top-up] │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Merchant-Facing Pages

### 3.1 Merchant Dashboard (Overview)

**URL:** `/dashboard`

**Purpose:** Central hub for merchants to monitor business health and access all capabilities.

> See [[web-app-spec#Capability-based approach]] for capability model details.

---

## 7. UI Components Inventory

This section enumerates reusable UI building blocks.

> See [[design-system]] for component specifications.

### 7.1 Navigation & Layout Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Global Topbar** | Logo, search, location, profile menu | All consumer pages |
| **Merchant Topbar** | Breadcrumb identity, scoped search | Merchant shopfronts |
| **Dashboard Sidebar** | Vertical navigation for dashboards | Merchant, Mod, Admin |

### 7.2 Commerce Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **Add-to-Cart Button** | Primary CTA with quantity, price | Product pages |
| **Cart Drawer** | Slide-out cart summary | Global, any page |
| **Checkout Stepper** | Progress indicator for checkout | Checkout flow |
| **Order Summary** | Itemized totals, discounts | Cart, checkout |

### 7.3 POS Components

| Component | Description | Usage |
|-----------|-------------|-------|
| **POS Product Grid** | Touch-optimized product tiles | POS main screen |
| **POS Cart Panel** | Current sale with line items | POS main screen |
| **Payment Selector** | Cash/Card/Other buttons | POS checkout |
| **QR Scanner** | Camera-based code scanning | Customer linking |
| **Quota Banner** | Usage warning with CTA | POS status bar |

---

## 9. Responsive Design Guidelines

### 9.1 Breakpoints

| Breakpoint | Width | Target Devices |
|------------|-------|----------------|
| Mobile | < 640px | Phones |
| Tablet | 640px - 1024px | Tablets, small laptops |
| Desktop | > 1024px | Laptops, desktops |

### 9.2 Touch Targets

- Minimum touch target: 44x44 px
- Adequate spacing between interactive elements
- Swipe gestures for carousels and drawers

---

## Appendix: Page-to-Journey Mapping

| Page | Supports User Journeys |
|------|----------------------|
| Home / Explore | [[web-app-spec#4.1 Consumer — buy at a shop online]] |
| POS Screen | [[web-app-spec#4.5 Merchant — operate a shop with POS]] |
| Kitchen Queue | [[web-app-spec#4.7.1 Merchant — manage online food orders]] |

---

#halava #spec #ux #pages
