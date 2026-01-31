# Directory (Halal Place Discovery)

> **Capability:** Directory Listing
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[capabilities]] · [[web-app-spec]]

---

## Definition

The **Directory** is Halava's location-based discovery system for halal businesses. It enables consumers to find halal restaurants, shops, and services based on location, cuisine, amenities, and halal status.

**Core value proposition:**
- Consumers discover halal places with confidence
- Merchants gain visibility to a halal-seeking audience
- Trust through transparent halal status disclosure

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

## UI/UX Specification

### Consumer Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Explore/Home** | `/` | Map + search bar + nearby places |
| **Search Results** | `/search?q=...` | Filtered list/map view |
| **Place Page** | `/places/{slug}` | Full place details |
| **Saved Places** | `/saved` | User's bookmarked places |

### Place Page Layout

```
┌──────────────────────────────────────────┐
│ [←] Place Name            [♡] [Share]    │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │         Cover Photo Gallery          │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ★ 4.5 (128 reviews) · Japanese · $$     │
│ 📍 1.2 km · Shibuya                      │
│ 🕐 Open until 21:00                      │
│ 🥩 Certified Halal [View Certificate]   │
│                                          │
├──────────────────────────────────────────┤
│ [📍 Directions] [📞 Call] [🛒 Order]     │
├──────────────────────────────────────────┤
│ About                                    │
│ Hours | Menu | Photos | Reviews          │
└──────────────────────────────────────────┘
```

### Search Filters

- **Distance:** < 1km, < 2km, < 5km, < 10km
- **Status:** Open Now, Open 24h
- **Cuisine:** Japanese, Indonesian, Middle Eastern, etc.
- **Amenities:** Prayer space, Parking, Halal certificate
- **Sort:** Distance, Rating, Newest

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
| `GET` | `/api/v1/places` | Search/list places |
| `GET` | `/api/v1/places/{slug}` | Get place details |
| `POST` | `/api/v1/merchant/places` | Create place (merchant) |
| `PUT` | `/api/v1/merchant/places/{id}` | Update place |
| `POST` | `/api/v1/places/{id}/reviews` | Add review |
| `GET` | `/api/v1/places/{id}/reviews` | List reviews |

### Search Query Parameters

```
GET /api/v1/places?
  lat=35.6762&lng=139.6503
  &radius=2000
  &q=ramen
  &cuisine=japanese
  &open_now=true
  &sort=distance
  &limit=20
```

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Places indexed | 100+ |
| Search p95 latency | < 500ms |
| Place page load | < 2s |
| Save-to-visit conversion | > 20% |

---

## Dependencies

- [[web-app-spec#Capability lifecycle]] — Directory Listing must be enabled
- [[architecture#PostGIS]] — Geo-search implementation
- [[data-model#Place]] — Full schema

---

#halava #feature #directory #consumer
