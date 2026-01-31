# Reviews & Ratings

> **Feature Type:** Consumer (Always Available)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[directory]] · [[marketplace]] · [[purchase-history]]

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

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Place Reviews** | `/places/{slug}/reviews` | All reviews for a place |
| **Product Reviews** | `/products/{id}/reviews` | All reviews for a product |
| **Write Review** | `/review/new?type=place&id={id}` | Submit new review |
| **My Reviews** | `/profile/reviews` | User's review history |

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

```
Review
├── id: UUID
├── user_id: FK → User
├── subject_type: enum (place, product)
├── subject_id: UUID (FK to Place or Product)
├── order_id: UUID (nullable, for verification)
│
├── rating: int (1-5)
├── aspect_ratings: JSONB (nullable)
│   └── { food_quality: 5, service: 4, ... }
├── content: text (nullable)
├── photos: string[] (URLs)
│
├── is_verified: boolean
├── helpful_count: int (default: 0)
├── status: enum (active, hidden, removed)
│
├── created_at: timestamp
├── updated_at: timestamp

ReviewHelpful (vote tracking)
├── id: UUID
├── review_id: FK → Review
├── user_id: FK → User
├── created_at: timestamp
├── UNIQUE(review_id, user_id)

ReviewReport
├── id: UUID
├── review_id: FK → Review
├── reporter_id: FK → User
├── reason: enum (spam, fake, inappropriate, other)
├── details: text (nullable)
├── status: enum (pending, reviewed, actioned)
├── created_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/places/{id}/reviews` | List place reviews |
| `GET` | `/api/v1/products/{id}/reviews` | List product reviews |
| `POST` | `/api/v1/reviews` | Create review |
| `PUT` | `/api/v1/reviews/{id}` | Update own review |
| `DELETE` | `/api/v1/reviews/{id}` | Delete own review |
| `POST` | `/api/v1/reviews/{id}/helpful` | Mark as helpful |
| `DELETE` | `/api/v1/reviews/{id}/helpful` | Remove helpful vote |
| `POST` | `/api/v1/reviews/{id}/report` | Report review |
| `GET` | `/api/v1/profile/reviews` | Get user's reviews |

### Query Parameters

```
GET /api/v1/places/{id}/reviews?
  sort=recent|helpful|rating_high|rating_low
  &verified_only=true
  &with_photos=true
  &rating=5
  &limit=20
  &offset=0
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
- [[purchase-history]] — Verification of purchases
- [[admin-moderation]] — Review moderation queue
- [[notifications]] — Review prompts and responses

---

#halava #feature #reviews #ratings #consumer
