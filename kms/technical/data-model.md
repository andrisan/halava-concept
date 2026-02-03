# Halava Data Model

> **Last updated:** February 2026
> **Status:** Active specification
>
> **Related documents:**
> - [[web-app-spec]] — Detailed product specification
> - [[architecture]] — Technical architecture
> - [[api-spec]] — API contracts

---

## Overview

This document serves as an index to all data models in the Halava platform. Each feature page contains its own detailed data model definitions.

---

## Data Model by Feature

### Shared Features

| Feature | Entities |
|---------|----------|
| [[authentication#Data Model]] | User, Session, OTPCode, MagicLink, OAuthConnection |
| [[onboarding#Data Model]] | Merchant, MerchantCapability |
| [[directory#Data Model]] | Place, PlacePhoto |
| [[marketplace#Data Model]] | Item, Category, Cart, CartItem, Order, OrderItem, OrderStatusHistory |
| [[notifications#Data Model]] | Notification, NotificationPreference, MerchantNotificationPreference |
| [[multi-language#Data Model]] | UserPreferences, MerchantTranslation, TranslationCache |

### Consumer Features

| Feature | Entities |
|---------|----------|
| [[group-purchase#Data Model]] | GroupPurchase, GroupPurchaseParticipant, GroupPurchaseItem |
| [[reviews-ratings#Data Model]] | Review, ReviewHelpful, ReviewReport |
| [[saved-items#Data Model]] | SavedItem, Collection |
| [[expense-tracker#Data Model]] | PurchaseRecord, PersonalPriceHistory, FrequentItem, SpendingInsight, BudgetGoal |

### Merchant Features

| Feature | Entities |
|---------|----------|
| [[products#Data Model]] | Item, ProductExtension, MenuItemExtension, Category |
| [[inventory#Data Model]] | InventoryAdjustment, Stocktake, StocktakeItem |
| [[order-management#Data Model]] | Order, OrderItem, OrderStatusHistory |
| [[pos#Data Model]] | POSTransaction |
| [[promotions#Data Model]] | Promotion, PromotionUsage, FeaturedListing |
| [[accounting#Data Model]] | FinancialTransaction, Expense, Invoice |

### Platform Features

| Feature | Entities |
|---------|----------|
| [[roles-permissions#Data Model]] | Staff, StaffRole, RoleAssignment |
| [[admin-moderation#Data Model]] | Report, ReportResolution, AuditLog, PlatformSetting |

---

## Cross-Cutting Concepts

### Unified Item Model

> See [[products#Unified Item Model]] for full specification.

| Type | Description | Inventory Behavior |
|------|-------------|-------------------|
| **product** | Physical goods sold online/POS | Counted inventory (`stock_count`) |
| **menu_item** | Made-to-order food | Availability toggle (`is_available`) |
| **hybrid** | Dual-purpose (e.g., fresh bread) | Counted inventory |

### Capability States

> See [[onboarding#Capability Lifecycle]] for state machine.

| State | Description |
|-------|-------------|
| **disabled** | Capability not enabled |
| **enabled_needs_setup** | Enabled but requires configuration |
| **active** | Fully configured and usable |
| **suspended** | Temporarily disabled (policy/billing) |

### Order Status Flow

> See [[order-management#Order Status Flow]] for full specification.

**Online Orders:**
```
placed → pending_payment → confirmed → preparing → ready → fulfilled
                ↓
            cancelled
```

**POS Transactions:** `completed` (instant)

**Prepared Orders:** `prepared → confirmed → preparing → ready → fulfilled`

---

## Database Strategy

### Indexing Guidelines

Each feature page specifies its own indexes. Common patterns:

| Pattern | Use Case | Example |
|---------|----------|---------|
| GiST spatial | Geo-queries | `place.location` |
| GIN tsvector | Full-text search | `item.name, item.description` |
| B-tree composite | Filtered queries | `order(merchant_id, status, created_at)` |
| Unique partial | Conditional uniqueness | `promotion.code WHERE code IS NOT NULL` |

### Data Retention

| Category | Retention | Reason |
|----------|-----------|--------|
| **User Data** | Until deletion | APPI compliance |
| **Transactions** | 7 years | Accounting/tax (Orders, POS, Invoices, Expenses) |
| **Marketing** | 2 years after end | Analytics (Promotions, Featured listings) |
| **Security** | Short-lived | Sessions (7 days), OTP/Magic links (24 hours) |
| **Cache** | As needed | Translation cache (30 days), Frequent items (monthly) |
| **Audit** | 3 years | Compliance |

---

#halava #technical #data-model
