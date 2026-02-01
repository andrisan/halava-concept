# Saved Items (Bookmarks)

> **Feature Type:** Consumer (Always Available)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[directory]] · [[marketplace]] · [[purchase-history]]

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

```
SavedItem
├── id: UUID
├── user_id: FK → User
├── item_type: enum (place, product, menu_item)
├── item_id: UUID (FK to Place, Product, or MenuItem)
├── collection_id: UUID (nullable, FK → Collection)
├── notes: text (nullable)
├── created_at: timestamp

Collection
├── id: UUID
├── user_id: FK → User
├── name: string
├── icon: string (emoji, nullable)
├── description: text (nullable)
├── is_public: boolean (default: false)
├── share_token: string (nullable, for sharing)
├── item_count: int (computed)
├── created_at: timestamp
├── updated_at: timestamp

CollectionShare (for collaborative collections - future)
├── id: UUID
├── collection_id: FK → Collection
├── shared_with_user_id: FK → User
├── permission: enum (view, edit)
├── created_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/saved` | List all saved items |
| `GET` | `/api/v1/saved/places` | List saved places |
| `GET` | `/api/v1/saved/products` | List saved products |
| `POST` | `/api/v1/saved` | Save an item |
| `DELETE` | `/api/v1/saved/{id}` | Remove saved item |
| `GET` | `/api/v1/collections` | List collections |
| `POST` | `/api/v1/collections` | Create collection |
| `PUT` | `/api/v1/collections/{id}` | Update collection |
| `DELETE` | `/api/v1/collections/{id}` | Delete collection |
| `POST` | `/api/v1/collections/{id}/items` | Add item to collection |
| `DELETE` | `/api/v1/collections/{id}/items/{item_id}` | Remove from collection |
| `GET` | `/api/v1/shared/{share_token}` | View shared collection |

### Request Examples

```json
// Save a place
POST /api/v1/saved
{
  "item_type": "place",
  "item_id": "uuid-of-place",
  "collection_id": "uuid-of-collection" // optional
}

// Create collection
POST /api/v1/collections
{
  "name": "Weekly Groceries",
  "icon": "🛒",
  "is_public": false
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
