# Promotions

> **Capability:** Promotions & Marketing
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[directory]] · [[monetization]]

---

## Definition

**Promotions** is Halava's marketing toolkit for merchants to attract customers through discounts, coupons, and enhanced visibility. It enables merchants to run targeted campaigns without external advertising platforms.

**Core value proposition:**
- Create discount codes and automatic promotions
- Boost visibility through featured listings
- Track promotion performance and ROI
- Reach halal-seeking customers directly

---

## How It Works

### Promotion Types

| Type | Description | Version |
|------|-------------|---------|
| **Coupon Codes** | Customer enters code at checkout | MVP |
| **Automatic Discounts** | Applied when conditions met | MVP |
| **Featured Listing** | Boosted visibility in search/directory | MVP |
| **Flash Sales** | Time-limited deep discounts | Future |
| **Loyalty Rewards** | Points and repeat customer perks | Future |

### Coupon Code Types

| Type | Example | Behavior |
|------|---------|----------|
| Percentage off | 10OFF | 10% off order total |
| Fixed amount off | SAVE500 | ¥500 off order |
| Free shipping | FREESHIP | Waive shipping fee |
| Buy X Get Y | BUY2GET1 | Free item with purchase |

### Automatic Discount Triggers

| Trigger | Example |
|---------|---------|
| Minimum order value | ¥500 off orders over ¥5,000 |
| Specific products | 20% off all beef products |
| First-time customer | 10% off first order |
| Time-based | Weekend special pricing |

---

## User Journey

### Merchant: Create Coupon Code

```
Dashboard → Promotions → [Create Promotion]
  → Type: Coupon Code
  → Code: "WELCOME10"
  → Discount: 10% off
  → Conditions:
    • Minimum order: ¥2,000
    • First-time customers only: ✅
    • Usage limit: 100 uses
    • Valid: Feb 1 - Feb 28, 2026
  → [Create Coupon]
  → Share code via social media, flyers, etc.
```

### Merchant: Set Up Automatic Discount

```
Dashboard → Promotions → [Create Promotion]
  → Type: Automatic Discount
  → Discount: ¥500 off
  → Trigger: Order total ≥ ¥5,000
  → Display: Show on product pages as "Spend ¥5,000, Save ¥500"
  → Valid: Always
  → [Activate]
```

### Merchant: Feature Listing

```
Dashboard → Promotions → Featured Listings
  → Select: "Halal Beef 500g"
  → Placement: Category search "Meat"
  → Duration: 7 days
  → Cost: ¥500/day
  → [Preview] → [Confirm & Pay]
  → Product appears with "Featured" badge
```

### Consumer: Apply Coupon

```
Cart → [Have a coupon code?]
  → Enter: "WELCOME10"
  → [Apply]
  → ✅ "WELCOME10 applied: -¥320 (10% off)"
  → Discount reflected in total
  → Checkout
```

### Consumer: Automatic Discount Applied

```
Cart → Subtotal: ¥5,200
  → ✅ "Spend ¥5,000 discount: -¥500" (auto-applied)
  → Total: ¥4,700
  → No code needed
```

---

## UI/UX Specification

### Merchant Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Promotions Dashboard** | `/merchant/promotions` | All promotions |
| **Create Promotion** | `/merchant/promotions/new` | New promo wizard |
| **Promotion Details** | `/merchant/promotions/{id}` | Edit & stats |
| **Featured Listings** | `/merchant/promotions/featured` | Boost products |

### Promotions Dashboard Layout

```
┌──────────────────────────────────────────┐
│ Promotions                    [+ Create] │
├──────────────────────────────────────────┤
│ [Active (3)] [Scheduled] [Ended] [All]   │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 🏷️ WELCOME10                        │ │
│ │ 10% off first order                  │ │
│ │ Coupon Code · Min ¥2,000             │ │
│ │                                      │ │
│ │ Used: 47 / 100                       │ │
│ │ Revenue: ¥156,800                    │ │
│ │ Ends: Feb 28, 2026                   │ │
│ │                                      │ │
│ │ [Edit] [Pause] [View Stats]          │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 🔄 Spend ¥5,000 Save ¥500            │ │
│ │ Automatic Discount                   │ │
│ │ Always active                        │ │
│ │                                      │ │
│ │ Applied: 23 times                    │ │
│ │ Total saved: ¥11,500                 │ │
│ │                                      │ │
│ │ [Edit] [Disable]                     │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ─────────────────────────────────────── │
│ Featured Listings                        │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ ⭐ Halal Beef 500g                   │ │
│ │ Featured in: Meat category           │ │
│ │ Remaining: 5 days                    │ │
│ │ Impressions: 1,240 · Clicks: 89      │ │
│ │ [Extend] [Stop]                      │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Create Promotion Form

```
┌──────────────────────────────────────────┐
│ [←] Create Promotion                     │
├──────────────────────────────────────────┤
│ Promotion Type                           │
│ ○ Coupon Code                            │
│ ○ Automatic Discount                     │
│ ○ Featured Listing                       │
│                                          │
│ ─────────────────────────────────────── │
│ Discount Details                         │
│                                          │
│ Discount Type:                           │
│ [Percentage ▼]                           │
│                                          │
│ Value:                                   │
│ [10] %                                   │
│                                          │
│ ─────────────────────────────────────── │
│ Coupon Code                              │
│ [WELCOME10          ]  [Generate Random] │
│                                          │
│ ─────────────────────────────────────── │
│ Conditions (optional)                    │
│                                          │
│ ☑️ Minimum order value: [¥2,000    ]     │
│ ☑️ First-time customers only             │
│ ☐ Specific products only                 │
│ ☐ Specific categories only               │
│                                          │
│ ─────────────────────────────────────── │
│ Limits                                   │
│                                          │
│ Total uses: [100    ] (leave empty = unlimited) │
│ Per customer: [1     ]                   │
│                                          │
│ Valid from: [Feb 1, 2026]                │
│ Valid until: [Feb 28, 2026]              │
│                                          │
│ ─────────────────────────────────────── │
│ [Preview] [Create Promotion]             │
└──────────────────────────────────────────┘
```

### Consumer: Cart with Discounts

```
┌──────────────────────────────────────────┐
│ Your Cart                                │
├──────────────────────────────────────────┤
│ Halal Beef 500g × 2           ¥2,400    │
│ Chicken Breast 1kg × 1        ¥1,200    │
│ Basmati Rice 5kg × 1          ¥1,800    │
│                                          │
│ ─────────────────────────────────────── │
│ Subtotal:                     ¥5,400    │
│                                          │
│ 🏷️ WELCOME10: -¥540 (10%)               │
│ 🎁 Spend ¥5,000 bonus: -¥500             │
│                                          │
│ ─────────────────────────────────────── │
│ Total:                        ¥4,360    │
│                                          │
│ [Have a code?] Enter here               │
│                                          │
│ [Checkout]                               │
└──────────────────────────────────────────┘
```

### Featured Listing Display

```
Search Results: "halal beef"

┌──────────────────────────────────────────┐
│ ⭐ FEATURED                              │
│ ┌──────────────────────────────────────┐ │
│ │ [Image] Halal Beef 500g              │ │
│ │ ¥1,200 · Halal Mart Shibuya          │ │
│ │ ★ 4.8 (45 reviews)                   │ │
│ └──────────────────────────────────────┘ │
├──────────────────────────────────────────┤
│ All Results                              │
│ ┌──────────────────────────────────────┐ │
│ │ [Image] Halal Beef 500g              │ │
│ │ ¥1,100 · Muslim Grocers              │ │
│ │ ★ 4.5 (32 reviews)                   │ │
│ └──────────────────────────────────────┘ │
│ ...                                      │
└──────────────────────────────────────────┘
```

---

## Featured Listings Pricing

| Placement | Duration | Price | Impressions (est.) |
|-----------|----------|-------|-------------------|
| Category search | 1 day | ¥500 | ~200 |
| Category search | 7 days | ¥3,000 | ~1,400 |
| Homepage carousel | 1 day | ¥2,000 | ~1,000 |
| Homepage carousel | 7 days | ¥12,000 | ~7,000 |

> Pricing subject to market testing. See [[monetization#Featured Listings]] for details.

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                       Promotion                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  name            VARCHAR(255) NOT NULL                          │
│  type            ENUM(coupon, automatic, featured)              │
│  status          ENUM(draft, active, paused, ended)             │
│  discount_type   ENUM(percentage, fixed, free_shipping, bogo)   │
│  discount_value  DECIMAL(10,2)                                  │
│  discount_config JSONB (buy_quantity, get_quantity, etc.)       │
│  code            VARCHAR(50) (for coupon type)                  │
│  conditions      JSONB (min_order, first_time, products, etc.)  │
│  usage_limit     INT (total uses)                               │
│  per_customer_limit  INT (uses per customer)                    │
│  usage_count     INT DEFAULT 0                                  │
│  starts_at       TIMESTAMP NOT NULL                             │
│  ends_at         TIMESTAMP                                      │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    PromotionUsage                                │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  promotion_id    UUID FK → Promotion                            │
│  order_id        UUID FK → Order                                │
│  consumer_id     UUID FK → User                                 │
│  discount_amount DECIMAL(10,2) NOT NULL                         │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    FeaturedListing                               │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  item_id         UUID FK → Item (nullable)                      │
│  place_id        UUID FK → Place (nullable)                     │
│  placement       ENUM(search_category, homepage, directory)     │
│  category        VARCHAR(100) (for category-specific placement) │
│  starts_at       TIMESTAMP NOT NULL                             │
│  ends_at         TIMESTAMP NOT NULL                             │
│  daily_rate      DECIMAL(10,2) NOT NULL                         │
│  total_cost      DECIMAL(10,2) NOT NULL                         │
│  impressions     INT DEFAULT 0                                  │
│  clicks          INT DEFAULT 0                                  │
│  status          ENUM(pending, active, completed, cancelled)    │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘
```

### Conditions JSONB Structure

```json
{
  "min_order_value": 2000,
  "first_time_only": true,
  "product_ids": ["uuid1", "uuid2"],
  "category_ids": ["uuid3"],
  "excluded_product_ids": []
}
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `promotion` | `merchant_id, status, starts_at, ends_at` | Active promotions |
| `promotion` | `code` (unique where not null) | Coupon lookup |
| `promotion_usage` | `promotion_id, consumer_id` | Per-customer usage |
| `promotion_usage` | `order_id` | Order discount lookup |
| `featured_listing` | `placement, status, starts_at, ends_at` | Active featured |
| `featured_listing` | `merchant_id, status` | Merchant's listings |

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/merchant/promotions` | List promotions |
| `POST` | `/api/v1/merchant/promotions` | Create promotion |
| `GET` | `/api/v1/merchant/promotions/{id}` | Get promotion details |
| `PUT` | `/api/v1/merchant/promotions/{id}` | Update promotion |
| `DELETE` | `/api/v1/merchant/promotions/{id}` | Delete promotion |
| `POST` | `/api/v1/merchant/promotions/{id}/pause` | Pause promotion |
| `POST` | `/api/v1/merchant/promotions/{id}/resume` | Resume promotion |
| `GET` | `/api/v1/merchant/promotions/{id}/stats` | Get usage stats |
| `POST` | `/api/v1/cart/apply-coupon` | Apply coupon (consumer) |
| `DELETE` | `/api/v1/cart/remove-coupon` | Remove coupon (consumer) |
| `GET` | `/api/v1/merchant/featured` | List featured listings |
| `POST` | `/api/v1/merchant/featured` | Create featured listing |

### Validate Coupon

```json
// POST /api/v1/cart/apply-coupon
{
  "code": "WELCOME10"
}

// Response (success)
{
  "valid": true,
  "discount_type": "percentage",
  "discount_value": 10,
  "discount_amount": 540,
  "message": "10% off applied!"
}

// Response (failure)
{
  "valid": false,
  "error": "coupon_expired",
  "message": "This coupon has expired."
}
```

---

## Promotion Stacking Rules

| Rule | Behavior |
|------|----------|
| Multiple coupons | ❌ Only one coupon per order |
| Coupon + Automatic | ✅ Can stack (both apply) |
| Multiple Automatic | ✅ All matching discounts apply |
| Max discount cap | Optional per-promotion setting |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Merchants with active promotions | > 30% |
| Coupon redemption rate | > 5% of distributed codes |
| Featured listing CTR | > 5% |
| Promo-driven order increase | > 15% lift |

---

## Dependencies

- [[marketplace]] — Discount application at checkout
- [[monetization]] — Featured listing fees
- [[order-management]] — Promo usage tracking
- [[notifications]] — Promo announcements (future)

---

#halava #feature #promotions #merchant #marketing
