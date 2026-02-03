# Saved Items (Bookmarks)

> **Feature Type:** Consumer (Always Available)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[directory]] · [[marketplace]] · [[expense-tracker]]

---

## Definition

**Saved Items** is Halava's bookmarking system that allows consumers to save places and products for later. It serves as a personal collection of favorites, wishlists, and planning tools for halal discovery and shopping.

**Core value proposition:**
- Save interesting places to visit later
- Build wishlists of products to buy
- Organize saved items into collections
- Quick access to favorites across devices

---

## How It Works

### Saveable Items

| Item Type | Save From | Quick Action |
|-----------|-----------|--------------|
| Place | Directory, Search, Map | ♡ Heart icon |
| Product | Marketplace, Search | ♡ Heart icon |
| Menu Item | Restaurant page | ♡ Heart icon |

### Organization

- **Default Lists:** All Saved, Places, Products
- **Custom Collections:** User-created lists (e.g., "Date Night Spots", "Weekly Groceries")
- **Smart Lists:** Auto-generated (e.g., "Recently Saved", "Near Me Now")

---

## User Journey

### Consumer: Save a Place

```
Explore → Find "Halal Ramen Ichiban"
  → Tap ♡ (heart icon)
  → Toast: "Saved to Places"
  → [View Saved] or [Add to Collection]
```

### Consumer: Save a Product

```
Marketplace → Product Page
  → Tap ♡ (heart icon)
  → "Add to Collection?"
    → [All Saved] or [+ New Collection]
  → Create: "Eid Shopping List"
  → Saved with confirmation
```

### Consumer: View Saved Items

```
Profile → Saved Items
  → Tabs: [All] [Places] [Products]
  → View saved items
  → Tap item → Go to page
  → Long press → [Remove] [Move to Collection]
```

### Consumer: Create Collection

```
Saved Items → [+ New Collection]
  → Name: "Weekly Groceries"
  → Icon: 🛒 (optional)
  → Privacy: Private/Shared
  → [Create]
  → Collection created
```

### Consumer: Share Collection

```
Collection → [Share]
  → Toggle: "Anyone with link can view"
  → Copy Link
  → Share with friends
  → Friends can view (read-only)
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Saved Items** | `/saved` | All saved items |
| **Places Saved** | `/saved/places` | Saved places only |
| **Products Saved** | `/saved/products` | Saved products only |
| **Collection** | `/saved/collections/{id}` | Single collection view |
| **Manage Collections** | `/saved/collections` | All collections |

### Saved Items Layout

```
┌──────────────────────────────────────────┐
│ [←] Saved                        [Edit]  │
├──────────────────────────────────────────┤
│ [All] [Places] [Products]                │
│                                          │
│ Collections                              │
│ ┌────────┐ ┌────────┐ ┌────────┐        │
│ │  🍽️   │ │  🛒   │ │  🎁   │        │
│ │ Date   │ │ Weekly │ │  Eid  │        │
│ │ Night  │ │Grocery │ │ Gifts │        │
│ │   5    │ │   12   │ │   8   │        │
│ └────────┘ └────────┘ └────────┘        │
│ [+ New Collection]                       │
│                                          │
│ ─────────────────────────────────────── │
│                                          │
│ Recently Saved                           │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 📍 Halal Ramen Ichiban          [♥] │ │
│ │ Japanese · Shibuya · ★4.5           │ │
│ │ Saved 2 hours ago                    │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 🛒 Halal Beef Wagyu 500g        [♥] │ │
│ │ ¥2,400 · Halal Mart                  │ │
│ │ Saved yesterday                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 📍 Muslim Grocers               [♥] │ │
│ │ Grocery · Shinjuku · ★4.2           │ │
│ │ Saved 3 days ago                     │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Collection View

```
┌──────────────────────────────────────────┐
│ [←] Weekly Groceries      [Share] [Edit] │
├──────────────────────────────────────────┤
│ 🛒 12 items · Private                    │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Chicken Breast 1kg        [♥] │ │
│ │ ¥1,200 · 3 merchants                 │ │
│ │ [Add to Cart]                        │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Halal Beef Mince 500g           [♥] │ │
│ │ ¥980 · 4 merchants                   │ │
│ │ [Add to Cart]                        │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Basmati Rice 5kg                [♥] │ │
│ │ ¥1,800 · 2 merchants                 │ │
│ │ [Add to Cart]                        │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ─────────────────────────────────────── │
│ [Add All to Cart] (¥12,450 estimated)    │
└──────────────────────────────────────────┘
```

### Saved Places Map View

```
┌──────────────────────────────────────────┐
│ [←] Saved Places              [List/Map] │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │                                      │ │
│ │            [Map View]                │ │
│ │     📍        📍                     │ │
│ │          📍         📍               │ │
│ │     📍                 📍            │ │
│ │                                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Showing 8 saved places near you      │ │
│ │                                      │ │
│ │ • Halal Ramen Ichiban (0.5 km)      │ │
│ │ • Muslim Grocers (1.2 km)            │ │
│ │ • Halal Bistro (2.1 km)              │ │
│ └──────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Edit Mode

```
┌──────────────────────────────────────────┐
│ [Cancel] Edit Saved              [Done]  │
├──────────────────────────────────────────┤
│ Select items to manage                   │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ [✓] Halal Ramen Ichiban              │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ [ ] Halal Beef Wagyu 500g            │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ [✓] Muslim Grocers                   │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ─────────────────────────────────────── │
│ 2 selected                               │
│ [Move to Collection] [Remove]            │
└──────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                       SavedItem                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User                                 │
│  item_type       ENUM(place, product, menu_item)                │
│  item_id         UUID NOT NULL                                  │
│  collection_id   UUID FK → Collection (nullable)                │
│  notes           TEXT                                           │
│  created_at      TIMESTAMP NOT NULL                             │
│  UNIQUE(user_id, item_type, item_id)                            │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       Collection                                 │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User                                 │
│  name            VARCHAR(100) NOT NULL                          │
│  icon            VARCHAR(10)                                    │
│  description     TEXT                                           │
│  is_public       BOOLEAN DEFAULT false                          │
│  share_token     VARCHAR(32) UNIQUE                             │
│  item_count      INT DEFAULT 0                                  │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `saved_item` | `user_id, item_type, item_id` (unique) | Prevent duplicates |
| `saved_item` | `user_id, created_at DESC` | Recent saves |
| `saved_item` | `user_id, collection_id` | Collection contents |
| `collection` | `user_id` | User's collections |
| `collection` | `share_token` (unique) | Public sharing |

---

## API Endpoints

> Full API index: [[api-spec#5.2 Saved Items]]

### GET /v1/consumer/saved

List all saved items.

```
Query Parameters:
  type        string    Filter: place, product (optional)
  limit       int       Results per page (default: 20)
  offset      int       Pagination offset
```

```json
// Response
{
  "items": [
    { "id": "uuid", "item_type": "place", "item": {...}, "saved_at": "..." }
  ],
  "total": 24
}
```

### GET /v1/consumer/saved/places

List saved places only.

```json
// Response
{
  "places": [...],
  "total": 12
}
```

### GET /v1/consumer/saved/products

List saved products only.

```json
// Response
{
  "products": [...],
  "total": 12
}
```

### POST /v1/consumer/saved

Save an item.

```json
// Request
{
  "item_type": "place",
  "item_id": "uuid-of-place",
  "collection_id": "uuid-of-collection"  // optional
}

// Response
{
  "id": "uuid",
  "item_type": "place",
  "saved_at": "2026-01-28T10:00:00Z"
}
```

### DELETE /v1/consumer/saved/{id}

Remove saved item.

```json
// Response
{
  "message": "Item removed"
}
```

### GET /v1/consumer/collections

List user's collections.

```json
// Response
{
  "collections": [
    { "id": "uuid", "name": "Weekly Groceries", "icon": "🛒", "item_count": 12 }
  ]
}
```

### POST /v1/consumer/collections

Create a new collection.

```json
// Request
{
  "name": "Weekly Groceries",
  "icon": "🛒",
  "is_public": false
}

// Response
{
  "id": "uuid",
  "name": "Weekly Groceries",
  "share_token": null
}
```

### PUT /v1/consumer/collections/{id}

Update collection details.

```json
// Request
{
  "name": "Updated Name",
  "is_public": true
}

// Response
{
  "id": "uuid",
  "share_token": "abc123"  // generated when is_public=true
}
```

### DELETE /v1/consumer/collections/{id}

Delete a collection (items are not deleted, just unassigned).

```json
// Response
{
  "message": "Collection deleted"
}
```

### POST /v1/consumer/collections/{id}/items

Add saved item to collection.

```json
// Request
{
  "saved_item_id": "uuid"
}

// Response
{
  "message": "Item added to collection"
}
```

### DELETE /v1/consumer/collections/{id}/items/{item_id}

Remove item from collection.

```json
// Response
{
  "message": "Item removed from collection"
}
```

### GET /v1/consumer/shared/{share_token}

View a shared collection (public, no auth required).

```json
// Response
{
  "name": "Weekly Groceries",
  "owner": "Ahmad K.",
  "items": [...],
  "item_count": 12
}
```

---

## Sync & Offline

- Saved items sync across devices via user account
- Offline access to saved items list (cached)
- Save action queued when offline, syncs when online
- Conflict resolution: last-write-wins

---

## Smart Features (Future)

| Feature | Description |
|---------|-------------|
| **Near Me Now** | Show saved places within 1km |
| **Price Drop Alert** | Notify when saved product price drops |
| **Restock Reminder** | "You saved this 30 days ago, time to restock?" |
| **Similar Suggestions** | "You might also like..." based on saves |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Users with saved items | > 40% of active users |
| Average saved items per user | > 8 |
| Save-to-visit/purchase rate | > 25% |
| Collection creation rate | > 15% of savers |
| Shared collection engagement | > 5% of collections |

---

## Dependencies

- [[directory]] — Place data for saved places
- [[marketplace]] — Product data for saved products
- [[notifications]] — Price drop alerts (future)

---

#halava #feature #saved-items #bookmarks #consumer
