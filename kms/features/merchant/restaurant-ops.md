# Restaurant Operations

> **Capability:** Restaurant Operations
> **Version:** v1.1
> **Status:** Planned
>
> **Related:** [[pos]] · [[marketplace]] · [[directory]] · [[onboarding]]

**Sub-features:**
- **Menu Management** — Menu items with modifiers, categories, pricing
- **QR Menu** — Contactless ordering via table QR codes
- **Kitchen Queue** — Order preparation workflow
- **Reservations** — Table booking system

---

## Definition

**Restaurant Operations** enables food service businesses to manage menus, accept dine-in/takeaway orders, process payments (online or at counter), and coordinate kitchen workflow.

**Core value proposition:**
- Unified ordering flow for dine-in and takeaway
- Flexible payment: online or at counter
- Real-time kitchen queue and order tracking
- QR menu for contactless ordering

---

## How It Works

The core logic for determining order type is based on the unified principles for all Halava operations.

> See core principles in [[order-concepts]]

### For Consumers

1. **Access menu** via QR code, storefront, or app
2. **Browse and add** items to cart
3. **Select fulfillment:** Dine-in or Takeaway
4. **Choose payment:**
   - Pay Online → Bank transfer (Phase 1) or Card (Phase 2)
   - Pay at Counter → Cash/Card at pickup
5. **Track preparation** in real-time
6. **Receive notification** when ready
7. **Collect food** at counter or table

### For Merchants

1. **Enable** Restaurant Operations capability
2. **Add menu items** with modifiers, prices, photos
3. **Configure** ordering settings (QR menu, time slots)
4. **Receive orders** in kitchen queue
5. **Mark status:** Received → Preparing → Ready
6. **Notify customer** when food is ready
7. **Complete** (hand off food, mark fulfilled)

---

## User Journey

### Consumer: Order Food (Pay Online)

```
Scan QR at Table → Menu Page
  → Browse categories
  → Add "Beef Rendang" × 1
  → Add "Nasi Goreng" × 2
  → [View Cart]
  → Fulfillment: ● Dine-in (Table 5) ○ Takeaway
  → [Checkout]
  → Payment: [Pay Online]
  → Transfer to merchant bank / Pay by card
  → Order Confirmed
  → Track: Received → Preparing → Ready
  → Notification: "Your order is ready!"
  → Served at table
```

### Consumer: Order Food (Pay at Counter)

```
Scan QR at Table → Menu Page
  → Add items to cart
  → Fulfillment: ● Dine-in (Table 5)
  → [Checkout]
  → Payment: [Pay at Counter]
  → "Proceed to counter to pay"
  → Show order QR/number at counter
  → Cashier opens Prepared Order in POS
  → Pay cash/card
  → Order Confirmed → Kitchen starts
  → Track: Preparing → Ready
  → Food served
```

### Merchant: Kitchen Workflow

```
Kitchen Queue → New Order Alert 🔔
  → View Order #0087:
      Table 5 / Dine-in
      • Beef Rendang × 1
      • Nasi Goreng × 2
  → [Start Preparing]
  → Status → Preparing (customer notified)
  → Cook food...
  → [Mark Ready]
  → Status → Ready (customer notified)
  → Server delivers to table
  → [Mark Fulfilled]
```

---

## UI/UX Specification

> **Template Support:**
> - Consumer screens (QR Menu): Mobile + Desktop
> - Merchant screens (Kitchen, Menu Management): Desktop only
>
> See [[pages-navigation-ux-spec#1. Dual-Template Architecture]]

### Consumer Screens (Mobile + Desktop)

| Screen | Path | Mobile | Desktop |
|--------|------|--------|---------|
| **QR Menu** | `/m/{merchant}/menu` | Full-screen list | Side panel or page |
| **Menu Item** | `/m/{merchant}/menu/{item}` | Full-screen | Modal |
| **Cart** | Drawer | Bottom sheet | Side drawer |
| **Checkout** | `/m/{merchant}/checkout` | Full-screen steps | Modal |
| **Order Status** | `/orders/{id}` | Full-screen | Page or modal |

### Menu Page Layout

```
┌──────────────────────────────────────────┐
│ [←] Halal Bistro Menu           [🛒 3]  │
├──────────────────────────────────────────┤
│ ┌──────────────────────────────────────┐ │
│ │ 🔍 Search menu                       │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Categories:                              │
│ [All] [Mains] [Sides] [Drinks] [Dessert]│
│                                          │
│ ┌─────────────┐ ┌─────────────┐          │
│ │ 📷          │ │ 📷          │          │
│ │ Beef Rendang│ │ Nasi Goreng │          │
│ │ ¥1,500      │ │ ¥1,200      │          │
│ │ [+ Add]     │ │ [+ Add]     │          │
│ └─────────────┘ └─────────────┘          │
│                                          │
│ ┌─────────────┐ ┌─────────────┐          │
│ │ 📷          │ │ 📷          │          │
│ │ Satay (6pc) │ │ Mango Lassi │          │
│ │ ¥800        │ │ ¥500        │          │
│ │ [+ Add]     │ │ [+ Add]     │          │
│ └─────────────┘ └─────────────┘          │
└──────────────────────────────────────────┘
```

### Order Tracking (Consumer)

```
┌──────────────────────────────────────────┐
│ Order #ORD-0087                          │
│ Halal Bistro · Dine-in · Table 5         │
├──────────────────────────────────────────┤
│                                          │
│    ●──────────●──────────○──────────○    │
│ Confirmed  Preparing    Ready    Served  │
│                                          │
│ Estimated: 15 minutes                    │
│                                          │
├──────────────────────────────────────────┤
│ Your Order:                              │
│ • Beef Rendang × 1            ¥1,500    │
│ • Nasi Goreng × 2             ¥2,400    │
│ ─────────────────────────────────────── │
│ Total:                        ¥3,900    │
└──────────────────────────────────────────┘
```

### Merchant Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Kitchen Queue** | `/merchant/kitchen` | Incoming orders |
| **Menu Management** | `/merchant/menu` | Add/edit items |
| **Order History** | `/merchant/orders` | Past orders |

### Kitchen Queue Layout

```
┌──────────────────────────────────────────────────────────────┐
│ Kitchen Queue                        [🔔 Sound: On] [⚙️]    │
├──────────────────────────────────────────────────────────────┤
│ New (2)          │ Preparing (3)      │ Ready (1)           │
│ ──────────────── │ ────────────────── │ ─────────────────── │
│ ┌──────────────┐ │ ┌────────────────┐ │ ┌─────────────────┐ │
│ │ #0089        │ │ │ #0087          │ │ │ #0085           │ │
│ │ Table 7      │ │ │ Table 5        │ │ │ Takeaway        │ │
│ │ Dine-in      │ │ │ Dine-in        │ │ │                 │ │
│ │ ──────────── │ │ │ ────────────── │ │ │ Waiting for     │ │
│ │ Satay × 2    │ │ │ Rendang × 1    │ │ │ pickup          │ │
│ │ Mango Lassi  │ │ │ Nasi Goreng ×2 │ │ │                 │ │
│ │              │ │ │                │ │ │ [Fulfilled]     │ │
│ │ [Accept]     │ │ │ [Ready]        │ │ └─────────────────┘ │
│ └──────────────┘ │ └────────────────┘ │                     │
│ ┌──────────────┐ │ ┌────────────────┐ │                     │
│ │ #0090        │ │ │ #0086          │ │                     │
│ │ Takeaway     │ │ │ Table 3        │ │                     │
│ │ [Accept]     │ │ │ [Ready]        │ │                     │
│ └──────────────┘ │ └────────────────┘ │                     │
└──────────────────────────────────────────────────────────────┘
```

---

## Data Model

### Entities

Restaurant operations use the unified Item model with `menu_item` type and the `MenuItemExtension`.

```
┌─────────────────────────────────────────────────────────────────┐
│                   MenuItemExtension                              │
│                   (for menu items)                               │
├─────────────────────────────────────────────────────────────────┤
│  item_id         UUID FK → Item PRIMARY KEY                     │
│  modifiers       JSONB (size, extras, customizations)           │
│  prep_time_minutes  INT                                         │
│  dietary_tags    TEXT[] (vegetarian, vegan, spicy, etc.)        │
│  allergens       TEXT[] (peanuts, gluten, dairy, etc.)          │
│  is_featured     BOOLEAN DEFAULT false                          │
│  course_type     ENUM(appetizer, main, dessert, drink, side)    │
└─────────────────────────────────────────────────────────────────┘
```

### Modifiers JSONB Structure

```json
{
  "groups": [
    {
      "name": "Size",
      "required": true,
      "max_selections": 1,
      "options": [
        { "name": "Regular", "price_modifier": 0 },
        { "name": "Large", "price_modifier": 200 }
      ]
    },
    {
      "name": "Extras",
      "required": false,
      "max_selections": 3,
      "options": [
        { "name": "Extra Egg", "price_modifier": 100 },
        { "name": "Extra Noodles", "price_modifier": 150 }
      ]
    }
  ]
}
```

### Restaurant Order Fields

Orders with `order_type = 'restaurant'` use additional fields:

| Field | Type | Description |
|-------|------|-------------|
| `table_number` | VARCHAR(20) | Table assignment |
| `dine_in_at` | TIMESTAMP | When customer seated |
| `ready_at` | TIMESTAMP | When food ready |

### Related Entities

- **Item** — See [[products#Data Model]] for base Item entity
- **Order** — See [[order-management#Data Model]] for Order entity

---

## API Endpoints

> Full API index: [[api-spec#10. Restaurant Module]]

### GET /v1/restaurant/{merchant}/menu

Get public menu for a restaurant.

```
Query Parameters:
  category      string    Filter by category (mains, sides, drinks, dessert)
  availability  string    Filter: breakfast, lunch, dinner
```

```json
// Response
{
  "merchant_id": "uuid",
  "name": "Salam Kitchen",
  "categories": [
    {
      "name": "Mains",
      "items": [
        {
          "id": "uuid",
          "name": "Beef Rendang",
          "description": "Slow-cooked beef in rich coconut curry",
          "price": 1500,
          "photo_url": "https://cdn.halava.app/...",
          "prep_time_minutes": 15,
          "dietary_tags": ["halal"],
          "modifiers": [
            {
              "name": "Spice Level",
              "required": true,
              "options": [
                { "name": "Mild", "price_adjust": 0, "default": true },
                { "name": "Medium", "price_adjust": 0 },
                { "name": "Hot", "price_adjust": 100 }
              ]
            }
          ],
          "is_available": true
        }
      ]
    }
  ]
}
```

### GET /v1/restaurant/{merchant}/menu/{item}

Get detailed item info.

```json
// Response
{
  "id": "uuid",
  "name": "Beef Rendang",
  "description": "Slow-cooked beef in rich coconut curry",
  "price": 1500,
  "photo_url": "https://cdn.halava.app/...",
  "prep_time_minutes": 15,
  "dietary_tags": ["halal"],
  "allergens": ["coconut"],
  "nutrition": {
    "calories": 450,
    "protein": 35
  },
  "modifiers": [...],
  "is_available": true,
  "availability_times": ["lunch", "dinner"]
}
```

### POST /v1/merchant/menu

Add menu item.

```json
// Request
{
  "name": "Chicken Satay",
  "description": "Grilled chicken skewers with peanut sauce",
  "price": 800,
  "category": "mains",
  "prep_time_minutes": 10,
  "dietary_tags": ["halal"],
  "availability_times": ["lunch", "dinner"],
  "modifiers": [
    {
      "name": "Quantity",
      "required": true,
      "options": [
        { "name": "3 sticks", "price_adjust": 0, "default": true },
        { "name": "6 sticks", "price_adjust": 500 }
      ]
    }
  ]
}

// Response
{
  "id": "uuid",
  "name": "Chicken Satay",
  "created_at": "2026-02-01T10:00:00Z"
}
```

### PUT /v1/merchant/menu/{id}

Update menu item.

```json
// Request
{
  "price": 850,
  "is_available": true
}

// Response
{
  "id": "uuid",
  "updated_at": "2026-02-01T12:00:00Z"
}
```

### DELETE /v1/merchant/menu/{id}

Remove menu item.

```json
// Response
{
  "message": "Menu item deleted"
}
```

### PATCH /v1/merchant/menu/{id}/availability

Toggle item availability.

```json
// Request
{
  "is_available": false,
  "reason": "Sold out today"
}

// Response
{
  "id": "uuid",
  "is_available": false
}
```

### GET /v1/merchant/kitchen/queue

Get kitchen order queue.

```
Query Parameters:
  status        string    Filter: pending, preparing, ready
```

```json
// Response
{
  "queue": [
    {
      "order_id": "uuid",
      "order_number": "A-042",
      "status": "preparing",
      "order_type": "dine_in",
      "table_number": "5",
      "items": [
        {
          "name": "Beef Rendang",
          "quantity": 2,
          "modifiers": ["Hot"],
          "notes": "No onions please"
        }
      ],
      "placed_at": "2026-02-01T12:30:00Z",
      "estimated_ready": "2026-02-01T12:45:00Z"
    }
  ],
  "summary": {
    "pending": 3,
    "preparing": 2,
    "ready": 1
  }
}
```

### PUT /v1/merchant/orders/{id}/status

Update order status.

```json
// Request
{
  "status": "preparing",
  "estimated_ready_minutes": 15
}

// Response
{
  "order_id": "uuid",
  "status": "preparing",
  "estimated_ready": "2026-02-01T12:45:00Z",
  "updated_at": "2026-02-01T12:30:00Z"
}
```

### POST /v1/restaurant/{merchant}/qr-order

Submit order via QR code (consumer at table).

```json
// Request
{
  "table_number": "5",
  "items": [
    {
      "item_id": "uuid",
      "quantity": 2,
      "modifiers": [
        { "modifier_id": "uuid", "option": "Hot" }
      ],
      "notes": "No onions please"
    }
  ],
  "payment_method": "online"
}

// Response
{
  "order_id": "uuid",
  "order_number": "A-042",
  "status": "placed",
  "estimated_ready_minutes": 20,
  "total": 3200
}
```

### GET /v1/restaurant/{merchant}/qr-order/{id}

Check order status (consumer).

```json
// Response
{
  "order_id": "uuid",
  "order_number": "A-042",
  "status": "preparing",
  "estimated_ready": "2026-02-01T12:45:00Z",
  "items": [...]
}
```

---

## Order Status Flow

### Online Payment Orders

```
placed → confirmed → preparing → ready → fulfilled
```

### Pay at Counter Orders

```
prepared → (payment at POS) → confirmed → preparing → ready → fulfilled
```

---

## Menu Management

Menu Management enables merchants to create and organize their food offerings with rich details.

### Menu Item Structure

| Field | Description |
|-------|-------------|
| Name | Item name (e.g., "Beef Rendang") |
| Description | Detailed description |
| Price | Base price |
| Photo | Item image |
| Category | Mains, Sides, Drinks, Dessert |
| Modifiers | Customization options (spice level, size, add-ons) |
| Prep time | Estimated preparation time |
| Availability | Available times (breakfast, lunch, dinner) |
| Dietary tags | Vegetarian, vegan, gluten-free |

### Modifiers System

```
Modifier Group: "Spice Level"
├── Required: Yes
├── Options:
│   ├── Mild (default)
│   ├── Medium
│   └── Hot (+¥100)
```

### Menu Organization

```
Dashboard → Menu Management
  → Categories (drag to reorder):
    ├── Mains (8 items)
    ├── Sides (5 items)
    ├── Drinks (6 items)
    └── Desserts (3 items)
  → [+ Add Item] [+ Add Category]
```

---

## QR Menu

QR Menu enables contactless ordering where customers scan a code to view the menu and place orders from their phone.

### QR Code Types

| Type | URL | Use Case |
|------|-----|----------|
| General menu | `/m/{merchant}/menu` | Counter display, flyers |
| Table-specific | `/m/{merchant}/menu?table=5` | Table tents, stickers |

### Table Detection Flow

1. Customer scans table QR code
2. Table number auto-fills in checkout
3. "Dine-in at Table 5" shown in cart
4. Order tagged with table for kitchen

### QR Code Generation

```
Dashboard → QR Codes
  → [Generate General QR]
  → [Generate Table QRs]
    - Enter number of tables: 10
    - [Download All] → ZIP with labeled QRs
    - [Print Layout] → Printable sheet
```

### QR Code Design

```
┌─────────────────────────┐
│ ┌─────────────────────┐ │
│ │                     │ │
│ │     [QR CODE]       │ │
│ │                     │ │
│ └─────────────────────┘ │
│                         │
│    Scan to Order        │
│    Table 5              │
│                         │
│    🍽️ Halal Bistro      │
└─────────────────────────┘
```

---

## Kitchen Queue

Kitchen Queue is the order management interface for kitchen staff to receive, prepare, and complete orders.

### Queue Columns

| Column | Orders | Actions |
|--------|--------|---------|
| **New** | Just received | [Accept] |
| **Preparing** | Being cooked | [Ready] |
| **Ready** | Waiting for pickup/serve | [Fulfilled] |

### Order Card Details

```
┌──────────────────────────┐
│ #0087 · 2 min ago        │
│ Table 5 · Dine-in        │
├──────────────────────────┤
│ • Beef Rendang × 1       │
│   → Spice: Hot           │
│ • Nasi Goreng × 2        │
│ • Mango Lassi × 2        │
├──────────────────────────┤
│ Notes: No peanuts please │
├──────────────────────────┤
│ [Start Preparing]        │
└──────────────────────────┘
```

### Kitchen Display Mode

Full-screen mode optimized for kitchen monitors:
- Large text for visibility
- Auto-refresh every 5 seconds
- Audio alerts for new orders
- Color-coded priority (oldest = red)

---

## Reservations

Reservations enables customers to book tables in advance.

> **Note:** This is a v1.1 feature. Implementation details subject to refinement.

### Reservation Flow (Consumer)

```
Place Page → [Reserve a Table]
  → Select date: [Jan 30, 2026]
  → Select time: [19:00]
  → Party size: [4 people]
  → Special requests: "Birthday celebration"
  → [Confirm Reservation]
  → Confirmation sent via email/notification
```

### Reservation Management (Merchant)

```
Dashboard → Reservations
  → Calendar view:
    ┌─────────────────────────────────────┐
    │ January 30, 2026                    │
    ├─────────────────────────────────────┤
    │ 18:00  │ Ahmad K. · 2 pax · Table 3 │
    │ 18:30  │ Fatima S. · 4 pax · Table 5│
    │ 19:00  │ Yusuf M. · 6 pax · Table 7 │
    │ 19:30  │ (Available)                │
    └─────────────────────────────────────┘
  → [+ Manual Booking] [Settings]
```

### Reservation Settings

| Setting | Options |
|---------|---------|
| Time slots | 30 min / 1 hour intervals |
| Max party size | Per table configuration |
| Booking window | How far ahead (e.g., 30 days) |
| Auto-confirm | Yes / Requires approval |
| Cancellation policy | Hours before, penalties |

### No-Show Handling

- Reminder notification 2 hours before
- Table held for 15 minutes past reservation
- No-show marked, affects future bookings (future feature)

---

## Notifications

| Event | Consumer Notification | Merchant Notification |
|-------|----------------------|----------------------|
| Order placed | "Order confirmed!" | 🔔 New order sound |
| Preparing | "Your order is being prepared" | — |
| Ready | "Your order is ready!" | — |
| Ready (Takeaway) | "Pickup at counter" | — |

---

## Future Enhancements (v1.2+)

- **Split bills:** Divide check among diners
- **Complex modifiers:** Nested modifier groups, conditional pricing
- **Scheduled orders:** Order ahead for specific time
- **Waitlist:** Walk-in queue management
- **Table management:** Visual floor plan, table status

---

## Success Metrics

| Metric | Target (v1.1) |
|--------|---------------|
| Order placement to ready | < 20 min avg |
| Kitchen queue adoption | 80% of restaurants |
| QR menu usage | 60% of dine-in orders |
| Customer notification open rate | > 70% |

---

## Dependencies

- [[web-app-spec#Capability Lifecycle]] — Restaurant Operations must be enabled
- [[pos]] — Prepared Orders queue integration
- [[directory]] — Place page for discovery

---

#halava #feature #restaurant #merchant #v1.1
