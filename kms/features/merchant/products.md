# Products (Catalog Management)

> **Capability:** Part of Shop / Marketplace
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[inventory]] · [[pos]] · [[data-model]]

---

## Definition

**Products** is Halava's catalog management system for merchants. It enables merchants to create, organize, and maintain their product listings across online shop and POS channels.

**Core value proposition:**
- Unified product catalog across all sales channels
- Rich product information with photos and variants
- Category organization for easy browsing
- Halal status declaration per product

---

## Unified Item Model

Halava uses a **unified item model** where products and menu items share a common base. This enables:

- Single catalog for hybrid businesses (shop + restaurant)
- Shared inventory across channels
- Consistent pricing management

### Item Types

| Type | Description | Use Case |
|------|-------------|----------|
| **product** | Physical goods | Groceries, packaged goods, retail items |
| **menu_item** | Made-to-order food | Restaurant dishes, cafe drinks |
| **hybrid** | Both product and menu item | Fresh bread (sold as product, also served in-house) |

### Channel Visibility

| Channel | Description |
|---------|-------------|
| **shop** | Available in online marketplace |
| **pos** | Available in POS interface |
| **restaurant** | Available in restaurant menu |

---

## How It Works

### Merchant Flow

1. **Add product** — Enter name, description, price, photos
2. **Set channels** — Enable for shop, POS, or both
3. **Configure inventory** — Set stock count, low-stock threshold
4. **Categorize** — Assign to categories for organization
5. **Publish** — Product appears in enabled channels
6. **Manage** — Update details, adjust stock, archive when needed

### Product Information

| Field | Required | Description |
|-------|----------|-------------|
| Name | Yes | Product title |
| Description | No | Detailed description |
| Base price | Yes | Selling price (tax-inclusive or exclusive) |
| Photos | Recommended | Up to 5 product images |
| SKU | No | Internal reference code |
| Barcode | No | For POS scanning |
| Category | Recommended | For organization and filtering |
| Halal status | Yes | Declared or Certified |
| Weight/Size | No | For shipping calculations |

---

## User Journey

### Merchant: Add New Product

```
Dashboard → Products → [Add Product]
  → Basic Info:
    - Product name: "Halal Beef 500g"
    - Description: "Premium Australian halal beef..."
    - Base price: ¥1,200
  → Photos:
    - [Upload] main photo
    - [Upload] additional photos (up to 5)
  → Inventory:
    - Stock count: 50
    - Low stock threshold: 10
    - SKU: BEEF-500G-AU
    - Barcode: 4901234567890
  → Channels:
    ☑ Online Shop
    ☑ POS
  → Category:
    - Meat & Poultry > Beef
  → Halal Status:
    ● Certified (upload certificate)
    ○ Declared
  → [Save as Draft] or [Publish]
```

### Merchant: Edit Product

```
Products → Search/Filter → Select Product
  → Edit any field
  → [Save Changes]
  → Changes reflected across all channels
```

### Merchant: Manage Variants (Future)

```
Product Page → Variants
  → Add Variant:
    - Option: Size
    - Values: 250g, 500g, 1kg
  → Set prices per variant:
    - 250g: ¥650
    - 500g: ¥1,200
    - 1kg: ¥2,200
  → Set stock per variant
  → [Save]
```

### Merchant: Bulk Actions

```
Products → Select multiple products
  → Bulk Actions:
    - Update category
    - Adjust prices (% or fixed)
    - Enable/disable channels
    - Archive selected
  → [Apply]
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Product List** | `/merchant/products` | View all products |
| **Add Product** | `/merchant/products/new` | Create new product |
| **Edit Product** | `/merchant/products/{id}` | Edit product details |
| **Categories** | `/merchant/products/categories` | Manage categories |
| **Import/Export** | `/merchant/products/import` | Bulk operations |

### Product List Layout

```
┌──────────────────────────────────────────────────────────────┐
│ Products                              [+ Add Product]         │
├──────────────────────────────────────────────────────────────┤
│ 🔍 Search products...                                        │
│                                                              │
│ [All] [In Stock] [Low Stock] [Out of Stock] [Archived]      │
│ Category: [All ▼]  Channel: [All ▼]                         │
├──────────────────────────────────────────────────────────────┤
│ ☐ │ Photo │ Name              │ Price  │ Stock │ Channels   │
│───┼───────┼───────────────────┼────────┼───────┼────────────│
│ ☐ │ 📷    │ Halal Beef 500g   │ ¥1,200 │ 45    │ 🛒 💳      │
│ ☐ │ 📷    │ Lamb Chops 300g   │ ¥980   │ 23    │ 🛒 💳      │
│ ☐ │ 📷    │ Chicken Breast    │ ¥650   │ ⚠️ 8  │ 🛒 💳      │
│ ☐ │ 📷    │ Sambal Sauce      │ ¥350   │ 67    │ 🛒         │
│ ☐ │ 📷    │ Basmati Rice 5kg  │ ¥1,800 │ 0 ❌  │ 🛒 💳      │
├──────────────────────────────────────────────────────────────┤
│ Showing 1-20 of 156 products              [< Prev] [Next >] │
└──────────────────────────────────────────────────────────────┘

Legend: 🛒 = Shop, 💳 = POS, ⚠️ = Low stock, ❌ = Out of stock
```

### Add/Edit Product Form

```
┌──────────────────────────────────────────────────────────────┐
│ [←] Add Product                              [Save Draft]     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ Basic Information                                            │
│ ─────────────────                                            │
│ ┌──────────────────────────────────────────────────────────┐│
│ │ Product Name *                                           ││
│ │ Halal Beef 500g                                          ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐│
│ │ Description                                              ││
│ │ Premium Australian halal beef, grass-fed and certified  ││
│ │ by JAKIM. Perfect for stir-fry, curry, or grilling.     ││
│ └──────────────────────────────────────────────────────────┘│
│                                                              │
│ ┌────────────────────┐  Tax:                                │
│ │ Price *    ¥1,200  │  ○ Tax inclusive                    │
│ └────────────────────┘  ● Tax exclusive (10% added)        │
│                                                              │
│ Photos                                                       │
│ ──────                                                       │
│ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐│
│ │         │ │         │ │         │ │         │ │    +    ││
│ │  Main   │ │ Photo 2 │ │ Photo 3 │ │         │ │   Add   ││
│ │  Photo  │ │         │ │         │ │         │ │         ││
│ └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘│
│                                                              │
│ Inventory                                                    │
│ ─────────                                                    │
│ ┌──────────────┐  ┌──────────────────┐                      │
│ │ Stock    50  │  │ Low Stock Alert  │                      │
│ └──────────────┘  │ When below: 10   │                      │
│                   └──────────────────┘                      │
│ ┌──────────────────┐  ┌────────────────────────────────────┐│
│ │ SKU              │  │ Barcode                            ││
│ │ BEEF-500G-AU     │  │ 4901234567890                      ││
│ └──────────────────┘  └────────────────────────────────────┘│
│                                                              │
│ Sales Channels                                               │
│ ──────────────                                               │
│ ☑ Online Shop — Available in marketplace                    │
│ ☑ POS — Available for in-store sales                        │
│                                                              │
│ Category                                                     │
│ ────────                                                     │
│ [Meat & Poultry ▼] > [Beef ▼]                               │
│                                                              │
│ Halal Status                                                 │
│ ────────────                                                 │
│ ● Certified Halal                                           │
│   Certifying body: [JAKIM ▼]                                │
│   [Upload Certificate]                                      │
│ ○ Halal Declared                                            │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│ [Cancel]                                    [Publish Product]│
└──────────────────────────────────────────────────────────────┘
```

### Category Management

```
┌──────────────────────────────────────────────────────────────┐
│ Categories                               [+ Add Category]     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│ ▼ Meat & Poultry (45 products)                              │
│   ├── Beef (18)                                             │
│   ├── Lamb (12)                                             │
│   ├── Chicken (10)                                          │
│   └── Other (5)                                             │
│                                                              │
│ ▼ Groceries (67 products)                                   │
│   ├── Rice & Grains (15)                                    │
│   ├── Spices & Sauces (28)                                  │
│   ├── Canned Goods (14)                                     │
│   └── Snacks (10)                                           │
│                                                              │
│ ▶ Beverages (22 products)                                   │
│ ▶ Prepared Foods (18 products)                              │
│ ▶ Frozen (4 products)                                       │
│                                                              │
│ [Drag to reorder]                                           │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Data Model

```
Item
├── id: UUID
├── merchant_id: FK → Merchant
├── name: string
├── slug: string (unique per merchant)
├── description: text
├── base_price: decimal
├── tax_inclusive: boolean
│
├── item_type: enum (product, menu_item, hybrid)
├── enabled_channels: string[] (shop, pos, restaurant)
├── is_available: boolean
│
├── halal_status: enum (declared, certified)
├── halal_certificate_url: string (nullable)
│
├── photos: ItemPhoto[]
├── category_id: FK → Category
│
├── created_at, updated_at: timestamp
├── archived_at: timestamp (nullable)

ProductExtension (for product/hybrid items)
├── item_id: FK → Item
├── stock_count: int
├── low_stock_threshold: int
├── sku: string (nullable)
├── barcode: string (nullable)
├── weight_grams: int (nullable)

Category
├── id: UUID
├── merchant_id: FK → Merchant
├── name: string
├── slug: string
├── parent_id: FK → Category (nullable)
├── sort_order: int
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/merchant/products` | List products |
| `POST` | `/api/v1/merchant/products` | Create product |
| `GET` | `/api/v1/merchant/products/{id}` | Get product |
| `PUT` | `/api/v1/merchant/products/{id}` | Update product |
| `DELETE` | `/api/v1/merchant/products/{id}` | Archive product |
| `POST` | `/api/v1/merchant/products/{id}/photos` | Upload photo |
| `GET` | `/api/v1/merchant/categories` | List categories |
| `POST` | `/api/v1/merchant/categories` | Create category |
| `PUT` | `/api/v1/merchant/categories/{id}` | Update category |
| `POST` | `/api/v1/merchant/products/import` | Bulk import (CSV) |
| `GET` | `/api/v1/merchant/products/export` | Export catalog |

### Create Product Request

```json
{
  "name": "Halal Beef 500g",
  "description": "Premium Australian halal beef...",
  "base_price": 1200,
  "tax_inclusive": false,
  "item_type": "product",
  "enabled_channels": ["shop", "pos"],
  "halal_status": "certified",
  "category_id": "uuid",
  "product_extension": {
    "stock_count": 50,
    "low_stock_threshold": 10,
    "sku": "BEEF-500G-AU",
    "barcode": "4901234567890"
  }
}
```

---

## Bulk Import/Export

### CSV Import Format

```csv
name,description,price,stock,sku,barcode,category,halal_status
Halal Beef 500g,Premium beef,1200,50,BEEF-500G,490123456,Meat > Beef,certified
Lamb Chops 300g,Fresh lamb,980,30,LAMB-300G,490123457,Meat > Lamb,certified
```

### Import Flow

```
Products → Import → [Choose CSV File]
  → Preview import:
    - 45 new products
    - 12 updates (matched by SKU)
    - 3 errors (missing required fields)
  → [Fix Errors] or [Import Valid Only]
  → Import progress...
  → "Import complete: 57 products processed"
```

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Products per merchant | > 20 average |
| Photo upload rate | > 80% of products |
| Category usage | > 70% of products categorized |
| Catalog completeness | > 90% have description |

---

## Dependencies

- [[marketplace]] — Product display and search
- [[inventory]] — Stock management
- [[pos]] — In-store product lookup
- [[data-model]] — Unified Item schema

---

#halava #feature #products #catalog #merchant
