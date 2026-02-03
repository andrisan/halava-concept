# Directory (Halal Place Discovery)

> **Feature Type:** Shared (Consumer & Merchant)
> **Capability:** Directory Listing
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[web-app-spec]] · [[onboarding]] · [[reviews-ratings]]

---

## Definition

The **Directory** is Halava's location-based discovery system for halal businesses. It enables consumers to find halal restaurants, shops, and services based on location, cuisine, amenities, and halal status.

**Core value proposition:**
- Consumers discover halal places with confidence
- Merchants gain visibility to a halal-seeking audience
- Trust through transparent halal status disclosure

**Sub-features:**
- **Search & Filters** — Finding places via text search, map, and faceted filters
- **Place Pages** — Detailed business profiles with hours, photos, reviews

---

## How It Works

### For Consumers

1. **Search** by location, keyword, or category
2. **Filter** by distance, open now, cuisine, amenities
3. **View** place details: hours, photos, menu, halal status
4. **Save** favorites for later
5. **Review** and rate after visiting

### For Merchants

1. **Enable** Directory Listing capability
2. **Complete** business profile (name, address, photos, hours)
3. **Declare** halal status (with optional evidence)
4. **Manage** public storefront page

### Halal Status Model

| Status | Display | Evidence |
|--------|---------|----------|
| **Declared** | "Halal" | None required |
| **Certified** | "Certified Halal" badge | Certificate uploaded |
| **Muslim-owned** | "Muslim-owned" label | Optional declaration |

> **Note:** Halava does not certify halal status. Merchants self-declare; moderators check for obvious fraud only.

---

## User Journey

### Consumer: Discover a Halal Place

```
Home → Search "halal ramen" → Filter: Open Now, < 2km
  → View Results (map + list)
  → Tap Place Card
  → Place Page: Photos, Hours, Menu, Reviews
  → [Save] or [Get Directions] or [Order]
```

### Merchant: Set Up Directory Listing

```
Dashboard → Capabilities → Enable Directory Listing
  → Setup Wizard:
    1. Business name & category
    2. Address (map pin)
    3. Operating hours
    4. Photos (cover + gallery)
    5. Halal status declaration
    6. Optional: Upload certificate
  → Publish → Live on Directory
```

---

## Search & Filters

### Search Types

| Type | Scope | Examples |
|------|-------|----------|
| **Place Search** | Directory | "halal ramen near me", "Indonesian restaurant" |
| **Product Search** | Marketplace | "halal beef", "sambal sauce" |
| **Universal Search** | Both | Returns places + products matching query |

### Place Filters

| Filter | Options | Default |
|--------|---------|---------|
| **Distance** | < 1km, < 2km, < 5km, < 10km, Any | < 5km |
| **Status** | Open Now, Open 24h, Any | Any |
| **Cuisine** | Japanese, Indonesian, Middle Eastern, Indian, etc. | Any |
| **Category** | Restaurant, Shop, Service | Any |
| **Halal Status** | Certified, Declared, Muslim-owned | Any |
| **Amenities** | Prayer space, Parking, Delivery, Takeaway | Any |
| **Rating** | 4+, 3+, 2+, Any | Any |
| **Price** | ¥, ¥¥, ¥¥¥ | Any |

### Sort Options

| Context | Sort Options |
|---------|--------------|
| **Places** | Distance, Rating (high→low), Newest |

### Search Algorithm

```
score = text_match_score
      + (is_open ? 0.2 : 0)
      + (is_certified ? 0.1 : 0)
      + (rating / 10)
      - (distance_km * 0.05)
```

---

## Place Pages

### Page Components

| Component | Description |
|-----------|-------------|
| Cover photo | Primary business image (gallery swipeable) |
| Business name | Official name |
| Rating | Star rating + review count |
| Category & price | "Japanese · $$" |
| Distance | From user's location |
| Status | Open/Closed + hours |
| Halal status | Declared/Certified/Muslim-owned |

### Action Bar

| Action | Icon | Function |
|--------|------|----------|
| Directions | 📍 | Open in maps app |
| Call | 📞 | Initiate phone call |
| Order | 🛒 | Go to shop/menu |
| Save | ♡ | Add to saved places |
| Share | ↗ | Share link |

### Content Tabs

| Tab | Content |
|-----|---------|
| **About** | Description, contact, address |
| **Hours** | Operating hours by day |
| **Menu/Products** | If shop/restaurant enabled |
| **Photos** | Gallery of business photos |
| **Reviews** | Customer ratings and reviews |

### Halal Certificate Modal

When user taps "View Certificate":

```
┌──────────────────────────────────────────┐
│ Halal Certificate                   [×]  │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │      [Certificate Image/PDF]        │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Certifying Body: Japan Halal Association │
│ Certificate Number: JHA-2025-12345       │
│ Valid: Jan 1, 2025 - Dec 31, 2026       │
│                                          │
│ ⚠️ Halava does not verify certificates.  │
└──────────────────────────────────────────┘
```

---

## UI/UX Specification

### Consumer Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Explore/Home** | `/` | Map + search bar + nearby places |
| **Search Results** | `/search?q=...` | Filtered list/map view |
| **Place Page** | `/places/{slug}` | Full place details |
| **Saved Places** | `/saved` | User's bookmarked places |

### Search Bar

```
┌──────────────────────────────────────────┐
│ 🔍 Search halal places and products...   │
└──────────────────────────────────────────┘
```

When focused:
```
┌──────────────────────────────────────────┐
│ 🔍 halal ramen                      [×]  │
├──────────────────────────────────────────┤
│ Recent Searches                          │
│ 🕐 halal beef                            │
│ 🕐 indonesian restaurant shibuya         │
│                                          │
│ Popular                                  │
│ 🔥 halal ramen                           │
│ 🔥 muslim friendly cafe                  │
└──────────────────────────────────────────┘
```

### Search Results (List View)

```
┌──────────────────────────────────────────┐
│ [←] "halal ramen"               [Filter] │
├──────────────────────────────────────────┤
│ [Places (8)] [Products (24)]             │
│ [List View] [Map View]                   │
│                                          │
│ Sorted by: Distance ▼                    │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 📷 │ Halal Ramen Tokyo              │ │
│ │    │ ★ 4.5 · Japanese · 0.8 km      │ │
│ │    │ 🟢 Open · Certified Halal      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 📷 │ Ramen Ichiban Halal           │ │
│ │    │ ★ 4.2 · Japanese · 1.2 km      │ │
│ │    │ 🟢 Open · Muslim-owned         │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Search Results (Map View)

```
┌──────────────────────────────────────────┐
│ [←] "halal ramen"               [Filter] │
├──────────────────────────────────────────┤
│ [Places (8)] [Products (24)]             │
│ [List View] [Map View]                   │
├──────────────────────────────────────────┤
│     ┌─────────────────────────────────┐  │
│     │            📍                   │  │
│     │       📍        📍              │  │
│     │    📍      [You]     📍         │  │
│     │         📍       📍             │  │
│     │    [Search this area]          │  │
│     └─────────────────────────────────┘  │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Ramen Tokyo · 0.8 km      [→] │ │
│ │ ★ 4.5 · 🟢 Open · Certified         │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Filter Sheet

```
┌──────────────────────────────────────────┐
│ Filters                             [×]  │
├──────────────────────────────────────────┤
│ Distance                                 │
│ [<1km] [<2km] [<5km] [<10km] [Any]       │
│                                          │
│ Status                                   │
│ [Open Now] [Open 24h] [Any]              │
│                                          │
│ Cuisine                                  │
│ [Japanese] [Indonesian] [Indian] ...     │
│                                          │
│ Halal Status                             │
│ [Certified] [Declared] [Muslim-owned]    │
│                                          │
│ Amenities                                │
│ ☐ Prayer space  ☐ Parking               │
│ ☐ Delivery      ☐ Takeaway              │
│                                          │
│ Rating: ★★★★☆ and above                 │
├──────────────────────────────────────────┤
│ [Clear All]              [Show 12 Places]│
└──────────────────────────────────────────┘
```

### Place Page Layout

```
┌──────────────────────────────────────────┐
│ [←]                        [♡] [Share]   │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │         Cover Photo Gallery          │ │
│ │              (swipeable)             │ │
│ │                          ● ○ ○ ○     │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Halal Ramen Tokyo                        │
│ ★ 4.5 (128 reviews) · Japanese · $$     │
│                                          │
│ 📍 1.2 km · Shibuya                      │
│ 🕐 Open · Closes at 21:00                │
│ 🥩 Certified Halal [View Certificate]   │
│                                          │
├──────────────────────────────────────────┤
│ [📍 Directions] [📞 Call] [🛒 Order]     │
├──────────────────────────────────────────┤
│ [About] [Hours] [Menu] [Photos] [Reviews]│
├──────────────────────────────────────────┤
│ About                                    │
│ ─────                                    │
│ Authentic halal Japanese ramen with      │
│ beef and chicken options.                │
│                                          │
│ Address                                  │
│ 〒150-0001 Tokyo, Shibuya-ku,            │
│ Jingumae 1-2-3, ABC Building 1F          │
│ [Copy Address] [Open in Maps]            │
│                                          │
│ Contact                                  │
│ 📞 03-1234-5678 · 🌐 halal-ramen.tokyo   │
└──────────────────────────────────────────┘
```

### Hours Tab

```
┌──────────────────────────────────────────┐
│ Hours                                    │
├──────────────────────────────────────────┤
│ Monday      11:00 - 21:00               │
│ Tuesday     11:00 - 21:00               │
│ Wednesday   11:00 - 21:00               │
│ Thursday    11:00 - 21:00               │
│ Friday      11:00 - 22:00               │
│ Saturday    11:00 - 22:00               │
│ Sunday      Closed                       │
│                                          │
│ 🕐 Currently: Open · Closes in 3 hours   │
└──────────────────────────────────────────┘
```

### Reviews Tab

```
┌──────────────────────────────────────────┐
│ Reviews                                  │
├──────────────────────────────────────────┤
│ ★ 4.5 average · 128 reviews              │
│                                          │
│ ★★★★★  72%  ████████████████             │
│ ★★★★☆  18%  ████                         │
│ ★★★☆☆   6%  ██                           │
│ ★★☆☆☆   3%  █                            │
│ ★☆☆☆☆   1%  ▏                            │
│                                          │
│ [Write a Review]                         │
│ ──────────────────────────────────────── │
│ Ahmad K. · ★★★★★ · Jan 25, 2026         │
│ "Best halal ramen I've had in Tokyo!"    │
│                                          │
│ Fatima S. · ★★★★☆ · Jan 20, 2026        │
│ "Great food, a bit crowded on weekends." │
│                                          │
│ [Load More Reviews]                      │
└──────────────────────────────────────────┘
```

---

## Data Model

```
Place
├── id: UUID
├── merchant_id: FK → Merchant
├── name: string
├── slug: string (unique)
├── description: text
├── category: enum (restaurant, shop, service)
├── cuisine_tags: string[]
├── amenities: string[]
│
├── address: string
├── location: PostGIS Point (lat, lng)
├── operating_hours: JSONB
│   └── { mon: [{open: "09:00", close: "21:00"}], ... }
│
├── halal_status: enum (declared, certified, muslim_owned)
├── halal_evidence_url: string (nullable)
│
├── cover_photo_url: string
├── photos: PlacePhoto[]
│
├── contact_phone: string (nullable)
├── website_url: string (nullable)
│
├── rating_avg: decimal (computed)
├── review_count: int (computed)
│
├── is_published: boolean
├── created_at, updated_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/search` | Universal search |
| `GET` | `/api/v1/search/suggestions` | Autocomplete |
| `GET` | `/api/v1/places` | Search/list places |
| `GET` | `/api/v1/places/{slug}` | Get place details |
| `GET` | `/api/v1/places/{id}/photos` | Get photo gallery |
| `GET` | `/api/v1/places/{id}/reviews` | List reviews |
| `POST` | `/api/v1/places/{id}/reviews` | Add review |
| `POST` | `/api/v1/saved/places/{id}` | Save place |
| `DELETE` | `/api/v1/saved/places/{id}` | Unsave place |
| `POST` | `/api/v1/merchant/places` | Create place (merchant) |
| `PUT` | `/api/v1/merchant/places/{id}` | Update place |

### Search Query Parameters

```
GET /api/v1/places?
  q=halal+ramen
  &lat=35.6762
  &lng=139.6503
  &radius=2000
  &open_now=true
  &cuisine=japanese
  &halal_status=certified
  &rating_min=4
  &sort=distance
  &limit=20
  &offset=0
```

### Response Format

```json
{
  "results": [...],
  "total": 42,
  "filters_applied": {
    "open_now": true,
    "cuisine": "japanese"
  },
  "facets": {
    "cuisine": [
      {"value": "japanese", "count": 12},
      {"value": "indonesian", "count": 8}
    ],
    "halal_status": [
      {"value": "certified", "count": 5},
      {"value": "declared", "count": 7}
    ]
  }
}
```

---

## Edge Cases

| Scenario | Handling |
|----------|----------|
| No results | "No places found. Try adjusting filters." |
| Location unavailable | Default to city center, prompt for location |
| Too many filters | Show "0 results" with clear suggestion |
| Store closes before pickup | Notify customer, extend to next business day |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Places indexed | 100+ |
| Search p95 latency | < 500ms |
| Place page load | < 2s |
| Search-to-click rate | > 40% |
| Filter usage rate | > 30% |
| Save rate | > 15% |
| Review submission rate | > 5% of visitors |

---

## Dependencies

- [[web-app-spec#Capability lifecycle]] — Directory Listing must be enabled
- [[architecture#PostGIS]] — Geo-search implementation
- [[data-model#Place]] — Full schema
- [[reviews-ratings]] — Review system
- [[saved-items]] — Bookmark functionality
- [[marketplace]] — Order action (if shop enabled)
- [[restaurant-ops]] — Menu action (if restaurant enabled)

---

#halava #feature #directory #shared #search #place-pages
