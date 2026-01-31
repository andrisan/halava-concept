# Halava Data Model

> **Last updated:** February 2026
> **Status:** Active specification
>
> **Related documents:**
> - [[web-app-spec]] — Detailed product specification
> - [[architecture]] — Technical architecture
> - [[api-spec]] — API contracts

---

## 1. Entity Overview

### Core Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         USERS & AUTH                             │
├─────────────────────────────────────────────────────────────────┤
│  User                                                           │
│  ├── id, email, name, role, created_at                         │
│  ├── Merchant (one-to-one if merchant)                         │
│  └── Staff (one-to-many through merchant)                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         MERCHANTS                                │
├─────────────────────────────────────────────────────────────────┤
│  Merchant                                                       │
│  ├── id, name, slug, description, contact_info                 │
│  ├── MerchantCapability (one-to-many)                          │
│  ├── Place (one-to-one, directory listing)                     │
│  ├── Item (one-to-many, products/menu items)                   │
│  └── Staff (one-to-many)                                       │
│                                                                 │
│  MerchantCapability                                             │
│  └── merchant_id, capability_type, status, enabled_at          │
│                                                                 │
│  Staff                                                          │
│  └── id, user_id, merchant_id, role                            │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         DIRECTORY                                │
├─────────────────────────────────────────────────────────────────┤
│  Place                                                          │
│  ├── id, merchant_id, name, slug, description                  │
│  ├── address, location (PostGIS point)                         │
│  ├── halal_status, halal_evidence_url                          │
│  ├── opening_hours (JSONB)                                      │
│  ├── amenities (array), tags (array)                           │
│  └── photos (one-to-many)                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         CATALOG                                  │
├─────────────────────────────────────────────────────────────────┤
│  Item (unified product/menu item)                               │
│  ├── id, merchant_id, name, description, base_price            │
│  ├── item_type: 'product' | 'menu_item' | 'hybrid'             │
│  ├── enabled_channels: ['shop', 'restaurant', 'pos']           │
│  ├── is_available, halal_status                                │
│  ├── ProductExtension (if product/hybrid)                      │
│  │   └── stock_count, low_stock_threshold, sku, barcode        │
│  └── MenuItemExtension (if menu_item)                          │
│      └── modifiers[], prep_time_minutes, dietary_tags[]        │
│                                                                 │
│  Category                                                       │
│  └── id, name, slug, parent_id                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         COMMERCE                                 │
├─────────────────────────────────────────────────────────────────┤
│  Cart                                                           │
│  ├── id, consumer_id, merchant_id, created_at                  │
│  └── CartItem (one-to-many)                                    │
│                                                                 │
│  Order                                                          │
│  ├── id, consumer_id, merchant_id, order_number                │
│  ├── status, type (online | group | pos)                       │
│  ├── subtotal, discount_amount, shipping_fee, total            │
│  ├── payment_method, payment_status                            │
│  ├── fulfillment_type, shipping_address (JSONB)                │
│  └── OrderItem (one-to-many)                                   │
│                                                                 │
│  GroupPurchase                                                  │
│  ├── id, initiator_id, merchant_id, invite_code                │
│  ├── deadline, status, order_id                                │
│  └── GroupPurchaseParticipant (one-to-many)                    │
│                                                                 │
│  POSTransaction                                                 │
│  ├── id, merchant_id, transaction_number                       │
│  ├── items (JSONB), total, payment_method                      │
│  ├── consumer_id (nullable, if linked)                         │
│  └── claim_code, created_at                                    │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         ENGAGEMENT                               │
├─────────────────────────────────────────────────────────────────┤
│  Review                                                         │
│  └── id, consumer_id, target_type, target_id, rating, text     │
│                                                                 │
│  SavedItem                                                      │
│  └── id, consumer_id, target_type, target_id                   │
│                                                                 │
│  Notification                                                   │
│  └── id, user_id, type, payload (JSONB), read, created_at      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         MODERATION                               │
├─────────────────────────────────────────────────────────────────┤
│  Report                                                         │
│  ├── id, reporter_id, target_type, target_id                   │
│  ├── reason, description, status                               │
│  └── moderator_id, resolution, resolved_at                     │
│                                                                 │
│  AuditLog                                                       │
│  └── id, actor_id, action, target_type, target_id, metadata    │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. Unified Item Model

> See [[web-app-spec#6.3.3 Unified Item Model]] for rationale.

### Item Types

| Type | Description | Inventory Behavior |
|------|-------------|-------------------|
| **product** | Physical goods sold online/POS | Counted inventory (`stock_count`) |
| **menu_item** | Made-to-order food | Availability toggle (`is_available`) |
| **hybrid** | Dual-purpose (e.g., fresh bread) | Counted inventory |

### Channel Visibility

| Channel | Description |
|---------|-------------|
| **shop** | Available in online marketplace |
| **restaurant** | Available in restaurant menu |
| **pos** | Available in POS interface |

---

## 3. Capability States

> See [[web-app-spec#Capability lifecycle]] for state machine.

| State | Description |
|-------|-------------|
| **disabled** | Capability not enabled |
| **enabled_needs_setup** | Enabled but requires configuration |
| **active** | Fully configured and usable |
| **suspended** | Temporarily disabled (policy/billing) |

---

## 4. Order Status Flow

### Online Orders (Phase 1)

```
placed → pending_payment → confirmed → preparing → ready → fulfilled
                ↓
            cancelled
```

### POS Transactions

```
completed (instant)
```

### Prepared Orders (Pay at Counter)

```
prepared → confirmed (paid@POS) → preparing → ready → fulfilled
```

---

## 5. Indexing Strategy

### Primary Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `place` | `location` (GiST) | Geo-search |
| `place` | `slug` (unique) | URL lookup |
| `item` | `merchant_id, item_type` | Catalog queries |
| `item` | `name, description` (GIN tsvector) | Full-text search |
| `order` | `consumer_id, created_at` | Purchase history |
| `order` | `merchant_id, status` | Merchant dashboard |
| `pos_transaction` | `merchant_id, created_at` | POS history |

### Composite Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `item` | `merchant_id, enabled_channels, is_available` | Channel-specific queries |
| `order` | `merchant_id, status, created_at` | Dashboard filtering |

---

## 6. Data Retention

| Data Type | Retention | Reason |
|-----------|-----------|--------|
| User accounts | Until deletion | APPI compliance |
| Orders | 7 years | Accounting/tax |
| POS Transactions | 7 years | Accounting/tax |
| Audit logs | 3 years | Compliance |
| Session tokens | 7 days | Security |
| Cart data | 30 days inactive | Cleanup |

---

#halava #technical #data-model
