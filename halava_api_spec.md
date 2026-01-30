# Halava API Specification

> **Last updated:** January 2026
> **Status:** Active specification
> **API Version:** v1
>
> **Related documents:**
> - `halava_web_app_spec_canvas.md` — Detailed product specification
> - `halava_technical_architecture.md` — System design overview
> - `halava_data_model.md` — Database schema documentation

---

## 1. API Overview

### 1.1 Base URL

```
Production:  https://api.halava.app/v1
Staging:     https://api-staging.halava.app/v1
Development: http://localhost:3001/v1
```

### 1.2 API Versioning Strategy

- **URL-based versioning:** Major version in path (`/v1/`, `/v2/`)
- **Breaking changes:** New major version; old version supported for 12 months minimum
- **Non-breaking additions:** Added to current version without notice
- **Deprecation:** Deprecated endpoints return `Deprecation` header with sunset date

### 1.3 Content Type

All requests and responses use JSON:

```
Content-Type: application/json
Accept: application/json
```

---

## 2. Authentication

### 2.1 Authentication Flow (Magic Link)

**Step 1: Request Magic Link**

```http
POST /v1/auth/magic-link
Content-Type: application/json

{
  "email": "user@example.com"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Magic link sent to email"
}
```

**Step 2: Verify Magic Link Token**

```http
POST /v1/auth/verify
Content-Type: application/json

{
  "token": "abc123..."
}
```

**Response (200 OK):**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIs...",
  "expires_in": 900,
  "token_type": "Bearer",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "name": "User Name",
    "role": "consumer"
  }
}
```

### 2.2 Token Refresh

```http
POST /v1/auth/refresh
Content-Type: application/json

{
  "refresh_token": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Response (200 OK):**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "expires_in": 900,
  "token_type": "Bearer"
}
```

### 2.3 Authorization Header

All authenticated requests include:

```http
Authorization: Bearer <access_token>
```

### 2.4 Token Structure (JWT)

**Access Token Claims:**
```json
{
  "sub": "user-uuid",
  "email": "user@example.com",
  "role": "consumer",
  "merchant_id": "merchant-uuid",  // if merchant user
  "iat": 1704067200,
  "exp": 1704068100
}
```

**Token Lifetimes:**
- Access token: 15 minutes
- Refresh token: 7 days

---

## 3. Consumer APIs

### 3.1 Directory & Discovery

#### Search Places

```http
GET /v1/places/search
Authorization: Bearer <token>  (optional)

Query Parameters:
  q           string    Search query (optional)
  lat         float     Latitude for geo-search
  lng         float     Longitude for geo-search
  radius      int       Search radius in meters (default: 5000, max: 50000)
  category    string    Filter by category
  amenities   string[]  Filter by amenities (comma-separated)
  open_now    boolean   Filter to currently open places
  page        int       Page number (default: 1)
  per_page    int       Results per page (default: 20, max: 100)
```

**Response (200 OK):**
```json
{
  "data": [
    {
      "id": "uuid",
      "name": "Halal Kitchen",
      "slug": "halal-kitchen",
      "description": "Authentic halal restaurant",
      "address": "1-2-3 Shibuya, Tokyo",
      "location": {
        "lat": 35.6581,
        "lng": 139.7015
      },
      "distance_meters": 450,
      "halal_status": "evidence_published",
      "opening_hours": {
        "monday": { "open": "11:00", "close": "21:00" },
        "tuesday": { "open": "11:00", "close": "21:00" }
      },
      "is_open_now": true,
      "amenities": ["prayer_space", "parking"],
      "rating": 4.5,
      "review_count": 28,
      "photos": [
        { "url": "https://...", "alt": "Storefront" }
      ],
      "merchant": {
        "id": "uuid",
        "name": "Halal Kitchen Co.",
        "slug": "halal-kitchen"
      }
    }
  ],
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total": 156,
    "total_pages": 8
  }
}
```

#### Get Place Details

```http
GET /v1/places/{place_id}
Authorization: Bearer <token>  (optional)
```

**Response (200 OK):**
```json
{
  "data": {
    "id": "uuid",
    "name": "Halal Kitchen",
    "slug": "halal-kitchen",
    "description": "Authentic halal restaurant serving...",
    "address": "1-2-3 Shibuya, Tokyo",
    "location": {
      "lat": 35.6581,
      "lng": 139.7015
    },
    "halal_status": "evidence_published",
    "halal_disclosure": "All our meat is certified halal...",
    "halal_evidence_url": "https://...",
    "opening_hours": { ... },
    "amenities": ["prayer_space", "parking", "wifi"],
    "rating": 4.5,
    "review_count": 28,
    "photos": [ ... ],
    "merchant": {
      "id": "uuid",
      "name": "Halal Kitchen Co.",
      "slug": "halal-kitchen",
      "capabilities": ["directory_listing", "restaurant_ops"]
    },
    "created_at": "2025-06-15T10:00:00Z",
    "updated_at": "2026-01-10T15:30:00Z"
  }
}
```

### 3.2 Product Catalog

#### Search Products

```http
GET /v1/products/search
Authorization: Bearer <token>  (optional)

Query Parameters:
  q           string    Search query
  merchant_id uuid      Filter by merchant (optional)
  category    string    Filter by category
  min_price   int       Minimum price in yen
  max_price   int       Maximum price in yen
  sort        string    Sort by: relevance, price_asc, price_desc, newest
  page        int       Page number
  per_page    int       Results per page
```

**Response (200 OK):**
```json
{
  "data": [
    {
      "id": "uuid",
      "name": "Halal Chicken Breast 1kg",
      "description": "Fresh halal chicken breast...",
      "price": 1200,
      "compare_at_price": 1500,
      "currency": "JPY",
      "in_stock": true,
      "stock_quantity": 45,
      "category": "meat",
      "tags": ["chicken", "fresh", "halal"],
      "photos": [
        { "url": "https://...", "alt": "Product photo" }
      ],
      "merchant": {
        "id": "uuid",
        "name": "Halal Mart",
        "slug": "halal-mart"
      }
    }
  ],
  "pagination": { ... }
}
```

#### Get Product Details

```http
GET /v1/products/{product_id}
Authorization: Bearer <token>  (optional)
```

### 3.3 Cart & Checkout

#### Get Cart

```http
GET /v1/cart
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "data": {
    "id": "uuid",
    "merchant": {
      "id": "uuid",
      "name": "Halal Mart",
      "slug": "halal-mart"
    },
    "items": [
      {
        "id": "uuid",
        "product": {
          "id": "uuid",
          "name": "Halal Chicken Breast 1kg",
          "price": 1200,
          "photos": [ ... ]
        },
        "quantity": 2,
        "unit_price": 1200,
        "subtotal": 2400
      }
    ],
    "subtotal": 2400,
    "item_count": 2,
    "created_at": "2026-01-20T10:00:00Z",
    "updated_at": "2026-01-20T10:15:00Z"
  }
}
```

#### Add to Cart

```http
POST /v1/cart/items
Authorization: Bearer <token>
Content-Type: application/json

{
  "product_id": "uuid",
  "quantity": 2
}
```

**Response (200 OK):**
```json
{
  "data": {
    "cart": { ... },
    "added_item": {
      "id": "uuid",
      "product_id": "uuid",
      "quantity": 2
    }
  }
}
```

**Response (409 Conflict) - Different merchant:**
```json
{
  "error": {
    "code": "CART_MERCHANT_CONFLICT",
    "message": "Cart contains items from a different merchant",
    "current_merchant": {
      "id": "uuid",
      "name": "Halal Mart"
    },
    "new_merchant": {
      "id": "uuid",
      "name": "Tokyo Halal"
    }
  }
}
```

#### Update Cart Item

```http
PATCH /v1/cart/items/{item_id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "quantity": 3
}
```

#### Remove Cart Item

```http
DELETE /v1/cart/items/{item_id}
Authorization: Bearer <token>
```

#### Clear Cart

```http
DELETE /v1/cart
Authorization: Bearer <token>
```

#### Checkout (Create Order)

```http
POST /v1/orders
Authorization: Bearer <token>
Content-Type: application/json

{
  "fulfillment_type": "delivery",
  "shipping_address": {
    "name": "John Doe",
    "phone": "090-1234-5678",
    "postal_code": "150-0001",
    "prefecture": "Tokyo",
    "city": "Shibuya",
    "address_line1": "1-2-3 Shibuya",
    "address_line2": "Apt 101"
  },
  "notes": "Please call before delivery",
  "coupon_code": "WELCOME10"
}
```

**Response (201 Created):**
```json
{
  "data": {
    "id": "uuid",
    "order_number": "HL-20260120-001",
    "status": "pending",
    "type": "online",
    "subtotal": 2400,
    "shipping_fee": 500,
    "discount_amount": 240,
    "total": 2660,
    "currency": "JPY",
    "payment_method": "bank_transfer",
    "payment_status": "pending",
    "payment_instructions": {
      "bank_name": "MUFG Bank",
      "branch_name": "Shibuya Branch",
      "account_type": "普通",
      "account_number": "1234567",
      "account_holder": "ハラバ株式会社"
    },
    "fulfillment_type": "delivery",
    "shipping_address": { ... },
    "items": [ ... ],
    "merchant": { ... },
    "created_at": "2026-01-20T10:30:00Z"
  }
}
```

### 3.4 Orders & History

#### List Orders

```http
GET /v1/orders
Authorization: Bearer <token>

Query Parameters:
  status      string    Filter by status
  page        int       Page number
  per_page    int       Results per page
```

**Response (200 OK):**
```json
{
  "data": [
    {
      "id": "uuid",
      "order_number": "HL-20260120-001",
      "status": "fulfilled",
      "total": 2660,
      "currency": "JPY",
      "item_count": 2,
      "merchant": {
        "id": "uuid",
        "name": "Halal Mart"
      },
      "created_at": "2026-01-20T10:30:00Z",
      "fulfilled_at": "2026-01-21T14:00:00Z"
    }
  ],
  "pagination": { ... }
}
```

#### Get Order Details

```http
GET /v1/orders/{order_id}
Authorization: Bearer <token>
```

#### Get Unified Purchase History

```http
GET /v1/me/purchase-history
Authorization: Bearer <token>

Query Parameters:
  type        string    Filter: online, pos, all (default: all)
  merchant_id uuid      Filter by merchant
  start_date  date      Start date
  end_date    date      End date
  page        int       Page number
  per_page    int       Results per page
```

**Response (200 OK):**
```json
{
  "data": [
    {
      "id": "uuid",
      "type": "online",
      "order_number": "HL-20260120-001",
      "total": 2660,
      "currency": "JPY",
      "merchant": {
        "id": "uuid",
        "name": "Halal Mart"
      },
      "items": [
        {
          "name": "Halal Chicken Breast 1kg",
          "quantity": 2,
          "unit_price": 1200
        }
      ],
      "created_at": "2026-01-20T10:30:00Z"
    },
    {
      "id": "uuid",
      "type": "pos",
      "transaction_number": "POS-001234",
      "total": 850,
      "currency": "JPY",
      "merchant": {
        "id": "uuid",
        "name": "Halal Kitchen"
      },
      "items": [
        {
          "name": "Chicken Biryani",
          "quantity": 1,
          "unit_price": 850
        }
      ],
      "created_at": "2026-01-19T12:30:00Z"
    }
  ],
  "pagination": { ... }
}
```

### 3.5 Group Purchases

#### Create Group Purchase

```http
POST /v1/group-purchases
Authorization: Bearer <token>
Content-Type: application/json

{
  "merchant_id": "uuid",
  "deadline": "2026-01-25T18:00:00Z"
}
```

**Response (201 Created):**
```json
{
  "data": {
    "id": "uuid",
    "invite_code": "GP-ABC123",
    "invite_link": "https://halava.app/g/GP-ABC123",
    "merchant": {
      "id": "uuid",
      "name": "Halal Mart"
    },
    "status": "open",
    "deadline": "2026-01-25T18:00:00Z",
    "participants": [
      {
        "user": {
          "id": "uuid",
          "name": "John Doe"
        },
        "items": [],
        "subtotal": 0,
        "is_initiator": true
      }
    ],
    "total": 0,
    "created_at": "2026-01-20T10:00:00Z"
  }
}
```

#### Join Group Purchase

```http
POST /v1/group-purchases/{invite_code}/join
Authorization: Bearer <token>
```

#### Add Items to Group Purchase

```http
POST /v1/group-purchases/{id}/items
Authorization: Bearer <token>
Content-Type: application/json

{
  "product_id": "uuid",
  "quantity": 2
}
```

#### Finalize Group Purchase

```http
POST /v1/group-purchases/{id}/finalize
Authorization: Bearer <token>
Content-Type: application/json

{
  "fulfillment_type": "delivery",
  "shipping_address": { ... }
}
```

### 3.6 Reviews

#### Create Review

```http
POST /v1/reviews
Authorization: Bearer <token>
Content-Type: application/json

{
  "target_type": "place",
  "target_id": "uuid",
  "rating": 5,
  "title": "Great food!",
  "body": "The biryani was amazing..."
}
```

#### List Reviews

```http
GET /v1/{target_type}s/{target_id}/reviews

Query Parameters:
  sort        string    Sort by: newest, highest, lowest
  page        int       Page number
  per_page    int       Results per page
```

### 3.7 Saved Items

#### Save Item

```http
POST /v1/saved-items
Authorization: Bearer <token>
Content-Type: application/json

{
  "target_type": "product",
  "target_id": "uuid"
}
```

#### List Saved Items

```http
GET /v1/saved-items
Authorization: Bearer <token>

Query Parameters:
  target_type string    Filter by type
```

#### Remove Saved Item

```http
DELETE /v1/saved-items/{id}
Authorization: Bearer <token>
```

### 3.8 Link POS Transaction

```http
POST /v1/me/link-pos-transaction
Authorization: Bearer <token>
Content-Type: application/json

{
  "claim_code": "ABC12345"
}
```

**Response (200 OK):**
```json
{
  "data": {
    "transaction": {
      "id": "uuid",
      "transaction_number": "POS-001234",
      "total": 850,
      "merchant": {
        "id": "uuid",
        "name": "Halal Kitchen"
      },
      "items": [ ... ],
      "created_at": "2026-01-19T12:30:00Z"
    },
    "linked_at": "2026-01-20T15:00:00Z"
  }
}
```

---

## 4. Merchant APIs

### 4.1 Merchant Profile

#### Get Merchant Profile

```http
GET /v1/merchant
Authorization: Bearer <token>
```

#### Update Merchant Profile

```http
PATCH /v1/merchant
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Halal Mart",
  "description": "Your trusted halal grocery store",
  "contact_email": "contact@halalmart.jp",
  "contact_phone": "03-1234-5678"
}
```

### 4.2 Capabilities

#### List Capabilities

```http
GET /v1/merchant/capabilities
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "data": [
    {
      "type": "directory_listing",
      "status": "active",
      "enabled_at": "2025-12-01T10:00:00Z",
      "activated_at": "2025-12-01T10:30:00Z"
    },
    {
      "type": "shop_selling",
      "status": "active",
      "enabled_at": "2025-12-15T10:00:00Z",
      "activated_at": "2025-12-15T11:00:00Z"
    },
    {
      "type": "pos",
      "status": "enabled_needs_setup",
      "enabled_at": "2026-01-10T10:00:00Z",
      "activated_at": null,
      "setup_requirements": [
        { "key": "tax_settings", "label": "Configure tax settings", "completed": false },
        { "key": "receipt_header", "label": "Set receipt header", "completed": true }
      ]
    },
    {
      "type": "restaurant_ops",
      "status": "disabled"
    }
  ]
}
```

#### Enable Capability

```http
POST /v1/merchant/capabilities/{capability_type}/enable
Authorization: Bearer <token>
```

#### Complete Capability Setup

```http
POST /v1/merchant/capabilities/{capability_type}/setup
Authorization: Bearer <token>
Content-Type: application/json

{
  "tax_settings": {
    "tax_rate": 10,
    "tax_included": true
  }
}
```

### 4.3 Products

#### List Products

```http
GET /v1/merchant/products
Authorization: Bearer <token>

Query Parameters:
  search      string    Search query
  category    string    Filter by category
  in_stock    boolean   Filter by stock status
  page        int       Page number
  per_page    int       Results per page
```

#### Create Product

```http
POST /v1/merchant/products
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Halal Chicken Breast 1kg",
  "description": "Fresh halal chicken breast...",
  "price": 1200,
  "compare_at_price": 1500,
  "sku": "CHICKEN-001",
  "barcode": "4901234567890",
  "stock_quantity": 50,
  "track_inventory": true,
  "low_stock_threshold": 10,
  "category": "meat",
  "tags": ["chicken", "fresh"],
  "available_for_pos": true,
  "available_online": true
}
```

#### Update Product

```http
PATCH /v1/merchant/products/{product_id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "price": 1100,
  "stock_quantity": 45
}
```

#### Delete Product

```http
DELETE /v1/merchant/products/{product_id}
Authorization: Bearer <token>
```

#### Upload Product Photo

```http
POST /v1/merchant/products/{product_id}/photos
Authorization: Bearer <token>
Content-Type: multipart/form-data

photo: <file>
alt: "Product photo"
```

### 4.4 Orders

#### List Orders

```http
GET /v1/merchant/orders
Authorization: Bearer <token>

Query Parameters:
  status      string    Filter by status
  type        string    Filter: online, group
  date_from   date      Start date
  date_to     date      End date
  page        int       Page number
  per_page    int       Results per page
```

#### Get Order Details

```http
GET /v1/merchant/orders/{order_id}
Authorization: Bearer <token>
```

#### Update Order Status

```http
PATCH /v1/merchant/orders/{order_id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "status": "confirmed",
  "payment_status": "confirmed"
}
```

### 4.5 POS

#### Create POS Transaction

```http
POST /v1/merchant/pos/transactions
Authorization: Bearer <token>
Content-Type: application/json

{
  "items": [
    {
      "product_id": "uuid",
      "quantity": 2,
      "unit_price": 1200
    },
    {
      "name": "Custom Item",
      "quantity": 1,
      "unit_price": 500
    }
  ],
  "payment_method": "cash",
  "consumer_qr_token": "optional-qr-token"
}
```

**Response (201 Created):**
```json
{
  "data": {
    "id": "uuid",
    "transaction_number": "POS-20260120-001",
    "subtotal": 2900,
    "tax_amount": 290,
    "total": 3190,
    "currency": "JPY",
    "payment_method": "cash",
    "status": "completed",
    "items": [ ... ],
    "receipt": {
      "url": "https://api.halava.app/v1/receipts/uuid",
      "claim_code": "ABC12345"
    },
    "consumer_linked": true,
    "created_at": "2026-01-20T14:30:00Z"
  }
}
```

#### Sync Offline Transactions

```http
POST /v1/merchant/pos/sync
Authorization: Bearer <token>
Content-Type: application/json

{
  "transactions": [
    {
      "local_id": "local-uuid-1",
      "items": [ ... ],
      "payment_method": "cash",
      "created_at": "2026-01-20T14:30:00Z"
    }
  ]
}
```

**Response (200 OK):**
```json
{
  "data": {
    "synced": [
      {
        "local_id": "local-uuid-1",
        "server_id": "uuid",
        "transaction_number": "POS-20260120-001"
      }
    ],
    "conflicts": [
      {
        "local_id": "local-uuid-2",
        "error": "STOCK_CONFLICT",
        "details": {
          "product_id": "uuid",
          "product_name": "Halal Chicken",
          "expected_stock": 10,
          "actual_stock": 3,
          "sold_quantity": 5
        }
      }
    ]
  }
}
```

#### Get POS Quota Status

```http
GET /v1/merchant/pos/quota
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "data": {
    "plan": "growth",
    "monthly_quota": 3000,
    "used": 2450,
    "remaining": 550,
    "percentage_used": 81.67,
    "top_ups_purchased": 0,
    "auto_top_up_enabled": false,
    "period_start": "2026-01-01",
    "period_end": "2026-01-31"
  }
}
```

#### Purchase POS Top-up

```http
POST /v1/merchant/pos/top-up
Authorization: Bearer <token>
Content-Type: application/json

{
  "pack": "medium"
}
```

### 4.6 Inventory

#### Get Inventory Summary

```http
GET /v1/merchant/inventory
Authorization: Bearer <token>

Query Parameters:
  low_stock   boolean   Filter to low stock items
  out_of_stock boolean  Filter to out of stock items
```

#### Adjust Stock

```http
POST /v1/merchant/inventory/adjust
Authorization: Bearer <token>
Content-Type: application/json

{
  "product_id": "uuid",
  "adjustment": 10,
  "reason": "restock"
}
```

### 4.7 Staff Management

#### List Staff

```http
GET /v1/merchant/staff
Authorization: Bearer <token>
```

#### Invite Staff

```http
POST /v1/merchant/staff/invite
Authorization: Bearer <token>
Content-Type: application/json

{
  "email": "cashier@example.com",
  "role": "cashier"
}
```

#### Update Staff Role

```http
PATCH /v1/merchant/staff/{staff_id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "role": "manager"
}
```

#### Remove Staff

```http
DELETE /v1/merchant/staff/{staff_id}
Authorization: Bearer <token>
```

---

## 5. Admin/Moderator APIs

### 5.1 Moderation

#### List Reports

```http
GET /v1/admin/reports
Authorization: Bearer <token>

Query Parameters:
  status      string    Filter by status
  target_type string    Filter by target type
  page        int       Page number
  per_page    int       Results per page
```

#### Get Report Details

```http
GET /v1/admin/reports/{report_id}
Authorization: Bearer <token>
```

#### Resolve Report

```http
POST /v1/admin/reports/{report_id}/resolve
Authorization: Bearer <token>
Content-Type: application/json

{
  "action": "content_removed",
  "resolution": "Content removed due to misleading halal claims"
}
```

### 5.2 User Management

#### List Users

```http
GET /v1/admin/users
Authorization: Bearer <token>
```

#### Suspend User

```http
POST /v1/admin/users/{user_id}/suspend
Authorization: Bearer <token>
Content-Type: application/json

{
  "reason": "Repeated policy violations"
}
```

### 5.3 Merchant Management

#### List Merchants

```http
GET /v1/admin/merchants
Authorization: Bearer <token>
```

#### Suspend Merchant Capability

```http
POST /v1/admin/merchants/{merchant_id}/capabilities/{capability_type}/suspend
Authorization: Bearer <token>
Content-Type: application/json

{
  "reason": "Fraudulent halal evidence"
}
```

### 5.4 Audit Logs

```http
GET /v1/admin/audit-logs
Authorization: Bearer <token>

Query Parameters:
  actor_id    uuid      Filter by actor
  action      string    Filter by action
  target_type string    Filter by target type
  date_from   date      Start date
  date_to     date      End date
  page        int       Page number
  per_page    int       Results per page
```

---

## 6. Error Handling

### 6.1 Error Response Format

All errors follow a consistent format:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": {
      // Optional additional context
    }
  }
}
```

### 6.2 HTTP Status Codes

| Status | Usage |
|--------|-------|
| 200 | Success |
| 201 | Created |
| 204 | No Content (successful delete) |
| 400 | Bad Request (validation error) |
| 401 | Unauthorized (missing/invalid token) |
| 403 | Forbidden (insufficient permissions) |
| 404 | Not Found |
| 409 | Conflict (e.g., cart merchant conflict) |
| 422 | Unprocessable Entity (business logic error) |
| 429 | Too Many Requests (rate limited) |
| 500 | Internal Server Error |

### 6.3 Common Error Codes

| Code | Description |
|------|-------------|
| `VALIDATION_ERROR` | Request body validation failed |
| `UNAUTHORIZED` | Authentication required |
| `FORBIDDEN` | Permission denied |
| `NOT_FOUND` | Resource not found |
| `CART_MERCHANT_CONFLICT` | Cart contains items from different merchant |
| `INSUFFICIENT_STOCK` | Product out of stock |
| `POS_QUOTA_EXCEEDED` | POS transaction quota exhausted |
| `CAPABILITY_NOT_ACTIVE` | Required capability not enabled |
| `GROUP_PURCHASE_CLOSED` | Group purchase deadline passed |
| `RATE_LIMITED` | Too many requests |

### 6.4 Validation Error Details

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": {
      "fields": [
        {
          "field": "email",
          "message": "Invalid email format"
        },
        {
          "field": "quantity",
          "message": "Must be greater than 0"
        }
      ]
    }
  }
}
```

---

## 7. Rate Limiting

### 7.1 Rate Limits

| Endpoint Category | Limit | Window |
|-------------------|-------|--------|
| Authentication | 10 | 1 minute |
| Search | 60 | 1 minute |
| General API | 120 | 1 minute |
| POS Transactions | 300 | 1 minute |

### 7.2 Rate Limit Headers

```http
X-RateLimit-Limit: 120
X-RateLimit-Remaining: 45
X-RateLimit-Reset: 1704067260
```

### 7.3 Rate Limit Exceeded Response

```http
HTTP/1.1 429 Too Many Requests
Retry-After: 30

{
  "error": {
    "code": "RATE_LIMITED",
    "message": "Too many requests. Please retry after 30 seconds."
  }
}
```

---

## 8. Webhooks (Phase 2+)

### 8.1 Webhook Events

| Event | Description |
|-------|-------------|
| `order.created` | New order placed |
| `order.confirmed` | Order payment confirmed |
| `order.fulfilled` | Order fulfilled |
| `order.cancelled` | Order cancelled |
| `merchant.capability.activated` | Capability activated |
| `pos.quota.warning` | POS quota at 80% |

### 8.2 Webhook Payload

```json
{
  "id": "webhook-event-uuid",
  "type": "order.created",
  "created_at": "2026-01-20T10:30:00Z",
  "data": {
    "order": { ... }
  }
}
```

---

*This document should be updated when API changes are made. Full OpenAPI specification to be generated from code.*

*Last updated: January 2026*
