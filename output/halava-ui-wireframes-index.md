# Halava — UI Wireframes Index

> **Purpose:** Index and implementation tracker for all UI wireframes
> **Last updated:** February 2026
> **Parent document:** [halava-ui-prototype-brief.md](./halava-ui-prototype-brief.md)

---

## Overview

This document serves as the central index for all Halava UI wireframes. Each feature area has been split into its own file for incremental implementation.

### Wireframe Files

| # | File | Feature | Target | MVP | Status |
|---|------|---------|--------|-----|--------|
| 1 | [01-home.md](./wireframes/01-home.md) | Home / Explore | Consumer | Yes | Not Started |
| 2 | [02-directory-search.md](./wireframes/02-directory-search.md) | Directory & Search | Consumer | Yes | Not Started |
| 3 | [03-expense-insight.md](./wireframes/03-expense-insight.md) | Expense Insight | Consumer | Yes | Not Started |
| 4 | [04-group-purchase.md](./wireframes/04-group-purchase.md) | Group Purchase | Consumer | Yes | Not Started |
| 5 | [05-pos.md](./wireframes/05-pos.md) | Point of Sale | Merchant | Yes | Not Started |
| 6 | [06-order-management.md](./wireframes/06-order-management.md) | Order Management | Merchant | Yes | Not Started |
| 7 | [07-inventory.md](./wireframes/07-inventory.md) | Inventory | Merchant | Yes | Not Started |
| 8 | [08-restaurant-ops.md](./wireframes/08-restaurant-ops.md) | Restaurant Ops + Kitchen | Merchant | v1.1 | Not Started |

---

## Implementation Plan

### Priority Order

Implementation follows a **consumer-first strategy**: consumer features before merchant features, and MVP features first.

| Priority | Feature | Rationale |
|----------|---------|-----------|
| **1** | Home | Entry point for all users; first impression |
| **2** | Directory & Search | Core discovery feature; drives engagement |
| **3** | Expense Insight | Personal value proposition; differentiator |
| **4** | Group Purchase | Social feature; viral growth driver |
| **5** | POS | Core merchant MVP capability |
| **6** | Order Management | Required for merchant operations |
| **7** | Inventory | Stock management for merchants |
| **8** | Restaurant Ops | v1.1 feature; can defer |

### Implementation Status Legend

| Status | Description |
|--------|-------------|
| **Not Started** | Wireframes complete, implementation not begun |
| **In Progress** | Active development |
| **Review** | Implementation complete, pending review |
| **Complete** | Implemented and verified |

---

## File Structure

```
output/
├── halava-ui-prototype-brief.md    # Product specification
├── halava-ui-wireframes-index.md   # This file
└── wireframes/
    ├── 01-home.md                  # Home / Explore
    ├── 02-directory-search.md      # Directory & Search
    ├── 03-expense-insight.md       # Expense Insight
    ├── 04-group-purchase.md        # Group Purchase
    ├── 05-pos.md                   # Point of Sale
    ├── 06-order-management.md      # Order Management
    ├── 07-inventory.md             # Inventory
    └── 08-restaurant-ops.md        # Restaurant Ops + Kitchen
```

---

## Screen Coverage

### Consumer Screens

All consumer screens support both mobile and desktop templates.

**Mobile:** Full-screen pages with bottom tab navigation, swipe gestures, native share sheets. No modals — all content renders as dedicated pages.

**Desktop:** Pages, side panels, or modals as appropriate. Topbar navigation with hover states.

| Screen | File | Mobile | Desktop |
|--------|------|--------|---------|
| Home / Explore | 01-home.md | Full-screen | Page |
| Search Bar | 02-directory-search.md | Full-screen | Topbar |
| Search Results | 02-directory-search.md | Full-screen list | Split view |
| Map View | 02-directory-search.md | Full-screen map | Split view |
| Filter Panel | 02-directory-search.md | Bottom sheet | Sidebar |
| Place Page | 02-directory-search.md | Full-screen page | Modal/panel |
| Halal Certificate | 02-directory-search.md | Full-screen page | Modal |
| Purchase History | 03-expense-insight.md | Full-screen list | Main content |
| Transaction Detail | 03-expense-insight.md | Full-screen page | Side panel |
| Insights Dashboard | 03-expense-insight.md | Full-screen | Dashboard |
| Item Price History | 03-expense-insight.md | Full-screen page | Side panel |
| Frequently Bought | 03-expense-insight.md | Full-screen list | Grid |
| Product Page Integration | 03-expense-insight.md | Inline section | Inline section |
| My QR Code | 03-expense-insight.md | Full-screen page | Modal |
| Create Group | 04-group-purchase.md | Full-screen form | Modal |
| Group Lobby | 04-group-purchase.md | Full-screen page | Page |
| Shipping Progress | 04-group-purchase.md | Inline component | Inline component |
| Invite Share | 04-group-purchase.md | Native share sheet | Modal |
| Participant Breakdown | 04-group-purchase.md | Full-screen page | Page |
| Distribution Tracking (v1.2) | 04-group-purchase.md | Full-screen page | Page |
| Reimbursement Request (v1.2) | 04-group-purchase.md | Full-screen page | Modal |
| QR Menu Page | 08-restaurant-ops.md | Full-screen grid | Page |
| Menu Item Detail | 08-restaurant-ops.md | Full-screen page | Modal |
| Dine-in Order Tracking | 08-restaurant-ops.md | Full-screen page | Page |

### Merchant Screens (Desktop Only)

Merchant operational screens are desktop-only due to the nature of business workflows (POS registers, kitchen displays, inventory management).

| Screen | File |
|--------|------|
| POS Main | 05-pos.md |
| POS Checkout Modal | 05-pos.md |
| POS Receipt Options | 05-pos.md |
| Prepared Orders Queue | 05-pos.md |
| Table Management (v1.1) | 05-pos.md |
| Split Bills (v1.1) | 05-pos.md |
| Modifiers (v1.1) | 05-pos.md |
| Orders Dashboard | 06-order-management.md |
| Order Details | 06-order-management.md |
| Inventory Overview | 07-inventory.md |
| Product Stock Detail | 07-inventory.md |
| Stock Adjustment Modal | 07-inventory.md |
| Stocktake Mode | 07-inventory.md |
| Low Stock Alerts | 07-inventory.md |
| Kitchen Queue | 08-restaurant-ops.md |
| Order Card Detail | 08-restaurant-ops.md |
| Kitchen Display Mode | 08-restaurant-ops.md |
| QR Code Generation | 08-restaurant-ops.md |

---

## Related Documents

- **Product Specification:** [halava-ui-prototype-brief.md](./halava-ui-prototype-brief.md)
- **Routes Specification:** [kms/spec/routes-spec.md](../kms/spec/routes-spec.md)
- **API Specification:** [kms/spec/api-spec.md](../kms/spec/api-spec.md)
- **Feature Specifications:** [kms/features/](../kms/features/)

---

*End of Wireframes Index*
