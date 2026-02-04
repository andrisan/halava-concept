# Reviews & Ratings

> **Feature Type:** Consumer (Always Available)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[directory]] · [[marketplace]] · [[expense-tracker]]

---

## Definition

**Reviews & Ratings** is Halava's trust and feedback system that enables consumers to share experiences and help others make informed decisions. It covers both places (restaurants, shops) and products, creating a community-driven quality layer.

**Core value proposition:**
- Share authentic experiences with the halal community
- Help others discover quality halal options
- Provide merchants with actionable feedback
- Build trust through verified purchase reviews

---

## How It Works

### Review Types

| Type | Subject | Verified | Trigger |
|------|---------|----------|---------|
| Place Review | Restaurant, Shop, Service | ✅ After visit/order | Order completed |
| Product Review | Individual products | ✅ After purchase | Order delivered |
| Quick Rating | Star-only (no text) | ✅ After transaction | POS checkout |

### Rating Components

**Places (5-star + aspects):**
- Overall rating (1-5 stars)
- Food/Product quality
- Service
- Halal trustworthiness
- Value for money

**Products (5-star + optional):**
- Overall rating (1-5 stars)
- Quality
- Value for money
- Would recommend (Yes/No)

### Verification Badges

| Badge | Meaning |
|-------|---------|
| ✓ Verified Purchase | Reviewer bought this item on Halava |
| ✓ Verified Visit | Reviewer ordered from this place |
| 📍 Local Guide | 10+ reviews in this area |
| 🏆 Top Reviewer | 50+ helpful reviews |

---

## User Journey

### Consumer: Write a Place Review

```
Order Completed → Notification: "How was your experience?"
  → Tap to Review
  → Rate Overall: ★★★★☆ (4 stars)
  → Rate Aspects:
    • Food Quality: ★★★★★
    • Service: ★★★★☆
    • Halal Trust: ★★★★★
    • Value: ★★★☆☆
  → Write Review (optional):
    "Amazing halal ramen! Authentic taste..."
  → Add Photos (optional)
  → [Submit Review]
  → Review posted with "Verified Visit" badge
```

### Consumer: Write a Product Review

```
Order Delivered → Product Page → [Write Review]
  → Rate: ★★★★★ (5 stars)
  → "Would you recommend?" → [Yes]
  → Write Review:
    "Best halal beef I've found in Tokyo..."
  → Add Photo (optional)
  → [Submit]
  → Review posted with "Verified Purchase" badge
```

### Consumer: Quick Rating at POS

```
In-Store Checkout → QR Linked
  → App Notification: "Rate your visit?"
  → Quick tap: ★★★★☆
  → Done (no text required)
```

### Consumer: Browse Reviews

```
Place Page → Reviews Tab
  → See overall: 4.5 ★ (128 reviews)
  → Filter: [Most Recent] [Most Helpful] [With Photos]
  → Read reviews
  → [Helpful] button on useful reviews
```

---

## UI/UX Specification

> **Template Support:** Mobile + Desktop (see [[pages-navigation-ux-spec#1. Dual-Template Architecture]])

### Screens

| Screen | Path | Mobile | Desktop |
|--------|------|--------|---------|
| **Place Reviews** | `/places/{slug}/reviews` | Full-screen list | Tab in place page |
| **Product Reviews** | `/products/{id}/reviews` | Full-screen list | Section in product page |
| **Write Review** | `/review/new` | Full-screen form | Modal |
| **My Reviews** | `/profile/reviews` | Full-screen list | Profile section |

### Place Reviews Layout

```
┌──────────────────────────────────────────┐
│ [←] Reviews                              │
├──────────────────────────────────────────┤
│ Halal Ramen Ichiban                      │
│ ★★★★☆ 4.5 (128 reviews)                  │
│                                          │
│ Rating Breakdown:                        │
│ 5★ ████████████████████ 72              │
│ 4★ ████████████ 38                      │
│ 3★ ████ 12                              │
│ 2★ █ 4                                  │
│ 1★ █ 2                                  │
│                                          │
│ [All] [With Photos] [Verified Only]     │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │ ★★★★★ Ahmad K. · 2 days ago         │ │
│ │ ✓ Verified Visit                     │ │
│ │                                      │ │
│ │ "Best halal ramen in Shibuya! The   │ │
│ │ broth is rich and the noodles are   │ │
│ │ perfectly chewy. Staff was very     │ │
│ │ friendly and..."                    │ │
│ │ [Read More]                          │ │
│ │                                      │ │
│ │ 📷 [Photo] [Photo]                   │ │
│ │                                      │ │
│ │ 👍 12 found this helpful             │ │
│ │ [Helpful] [Report]                   │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ ★★★★☆ Fatima S. · 1 week ago        │ │
│ │ ✓ Verified Visit · 📍 Local Guide    │ │
│ │                                      │ │
│ │ "Good food but a bit pricey. The    │ │
│ │ halal certificate is displayed      │ │
│ │ clearly which I appreciate..."      │ │
│ │                                      │ │
│ │ 👍 8 found this helpful              │ │
│ │ [Helpful] [Report]                   │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Write Review Form

```
┌──────────────────────────────────────────┐
│ [×] Write a Review                       │
├──────────────────────────────────────────┤
│ Halal Ramen Ichiban                      │
│ Order on Jan 28, 2026                    │
│                                          │
│ Overall Rating *                         │
│ ☆ ☆ ☆ ☆ ☆  Tap to rate                  │
│                                          │
│ ─────────────────────────────────────── │
│                                          │
│ Rate Aspects (optional):                 │
│                                          │
│ Food Quality     ☆☆☆☆☆                  │
│ Service          ☆☆☆☆☆                  │
│ Halal Trust      ☆☆☆☆☆                  │
│ Value for Money  ☆☆☆☆☆                  │
│                                          │
│ ─────────────────────────────────────── │
│                                          │
│ Your Review (optional):                  │
│ ┌──────────────────────────────────────┐ │
│ │ Share your experience...             │ │
│ │                                      │ │
│ │                                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [📷 Add Photos]                          │
│                                          │
│ ─────────────────────────────────────── │
│                                          │
│ [Submit Review]                          │
└──────────────────────────────────────────┘
```

### My Reviews

```
┌──────────────────────────────────────────┐
│ [←] My Reviews                           │
├──────────────────────────────────────────┤
│ 23 reviews · 156 helpful votes           │
│ 📍 Local Guide (Shibuya)                 │
│                                          │
│ [Places] [Products]                      │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Ramen Ichiban                  │ │
│ │ ★★★★★ · Jan 28, 2026                 │ │
│ │ "Best halal ramen in Shibuya!..."    │ │
│ │ 👍 12 helpful                         │ │
│ │ [Edit] [Delete]                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Mart Shibuya                   │ │
│ │ ★★★★☆ · Jan 15, 2026                 │ │
│ │ "Great selection of halal meat..."   │ │
│ │ 👍 8 helpful                          │ │
│ │ [Edit] [Delete]                      │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         Review                                   │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User                                 │
│  subject_type    ENUM(place, product, order)                    │
│  subject_id      UUID NOT NULL                                  │
│  order_id        UUID FK → Order (for verification)             │
│  rating          INT NOT NULL (1-5)                             │
│  aspect_ratings  JSONB (food_quality, service, halal_trust,     │
│                         value_for_money)                        │
│  content         TEXT                                           │
│  photos          TEXT[]                                         │
│  is_verified     BOOLEAN DEFAULT false                          │
│  helpful_count   INT DEFAULT 0                                  │
│  status          ENUM(pending, published, hidden, removed)      │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
│  UNIQUE(user_id, subject_type, subject_id)                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                      ReviewHelpful                               │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  review_id       UUID FK → Review                               │
│  user_id         UUID FK → User                                 │
│  created_at      TIMESTAMP NOT NULL                             │
│  UNIQUE(review_id, user_id)                                     │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                      ReviewReport                                │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  review_id       UUID FK → Review                               │
│  reporter_id     UUID FK → User                                 │
│  reason          ENUM(spam, inappropriate, fake, other)         │
│  details         TEXT                                           │
│  status          ENUM(pending, reviewed, dismissed, actioned)   │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `review` | `subject_type, subject_id, created_at DESC` | Reviews list |
| `review` | `user_id, subject_type, subject_id` (unique) | One review per user |
| `review` | `status, helpful_count DESC` | Top reviews |
| `review_helpful` | `review_id, user_id` (unique) | Helpful check |
| `review_report` | `review_id, status` | Moderation queue |

---

## API Endpoints

> Full API index: [[api-spec#5.4 Reviews]]

### GET /v1/directory/places/{slug}/reviews

List reviews for a place.

```
Query Parameters:
  sort          string    Sort: recent, helpful, rating_high, rating_low
  verified_only boolean   Filter to verified visits only
  with_photos   boolean   Filter to reviews with photos
  rating        int       Filter by exact rating (1-5)
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "reviews": [
    {
      "id": "uuid",
      "user": { "name": "Ahmad K." },
      "rating": 5,
      "content": "Best halal ramen in Shibuya!",
      "photos": [...],
      "is_verified": true,
      "helpful_count": 12,
      "created_at": "2026-01-25"
    }
  ],
  "total": 128,
  "rating_summary": { "avg": 4.5, "count": 128, "distribution": {...} }
}
```

### POST /v1/directory/places/{slug}/reviews

Add a review for a place.

```json
// Request
{
  "rating": 5,
  "aspect_ratings": {
    "food_quality": 5,
    "service": 4,
    "halal_trust": 5,
    "value_for_money": 4
  },
  "content": "Amazing halal ramen!",
  "photos": ["url1", "url2"]
}

// Response
{
  "id": "uuid",
  "is_verified": true,
  "created_at": "2026-01-28"
}
```

### GET /v1/marketplace/products/{id}/reviews

List reviews for a product.

```json
// Response
{
  "reviews": [...],
  "total": 45,
  "rating_summary": { "avg": 4.8, "count": 45 }
}
```

### POST /v1/marketplace/products/{id}/reviews

Add a review for a product.

```json
// Request
{
  "rating": 5,
  "content": "Best halal beef I've found!",
  "would_recommend": true
}

// Response
{
  "id": "uuid",
  "is_verified": true
}
```

### GET /v1/consumer/reviews

Get current user's reviews.

```json
// Response
{
  "reviews": [...],
  "total": 23,
  "helpful_votes_received": 156
}
```

### POST /v1/consumer/reviews

Create a review (alternative endpoint).

```json
// Request
{
  "subject_type": "place",
  "subject_id": "uuid",
  "rating": 5,
  "content": "..."
}
```

### PUT /v1/consumer/reviews/{id}

Update own review.

```json
// Request
{
  "rating": 4,
  "content": "Updated review..."
}
```

### DELETE /v1/consumer/reviews/{id}

Delete own review.

```json
// Response
{
  "message": "Review deleted"
}
```

### POST /v1/consumer/reviews/{id}/helpful

Mark a review as helpful.

```json
// Response
{
  "helpful_count": 13
}
```

### DELETE /v1/consumer/reviews/{id}/helpful

Remove helpful vote.

```json
// Response
{
  "helpful_count": 12
}
```

### POST /v1/consumer/reviews/{id}/report

Report a review for moderation.

```json
// Request
{
  "reason": "spam",  // spam, inappropriate, fake, other
  "details": "This review is fake..."
}

// Response
{
  "report_id": "uuid",
  "message": "Report submitted"
}
```

---

## Moderation

### Automated Checks

- Spam detection (duplicate content, suspicious patterns)
- Profanity filter
- Photo content moderation

### Manual Review Queue

Reviews flagged for manual review:
- Multiple user reports
- Low confidence spam detection
- New accounts with many reviews
- Reviews with edited photos

### Merchant Response

Merchants can respond publicly to reviews:
- One response per review
- Response visible below review
- Response can be edited (edit history tracked)

---

## Gamification

| Achievement | Criteria | Reward |
|-------------|----------|--------|
| First Review | Submit first review | Welcome badge |
| Local Guide | 10+ reviews in one area | Local Guide badge |
| Top Reviewer | 50+ reviews with 100+ helpful | Top Reviewer badge |
| Photo Pro | 20+ reviews with photos | Photo badge |
| Helpful Hero | 500+ helpful votes received | Special profile flair |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Reviews per place (avg) | > 5 |
| Review submission rate | > 15% of orders |
| Verified review % | > 80% |
| Helpful vote engagement | > 10% of readers |
| Review response rate (merchants) | > 30% |

---

## Dependencies

- [[directory]] — Place pages display reviews
- [[marketplace]] — Product pages display reviews
- [[expense-tracker]] — Verification of purchases
- [[admin-moderation]] — Review moderation queue
- [[notifications]] — Review prompts and responses

---

#halava #feature #reviews #ratings #consumer
