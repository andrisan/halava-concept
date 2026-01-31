# Halava API Specification

> **Last updated:** February 2026
> **Status:** Active specification
> **API Version:** v1
>
> **Related documents:**
> - [[web-app-spec]] — Detailed product specification
> - [[architecture]] — System design overview
> - [[data-model]] — Database schema documentation

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

**Step 2: Verify Magic Link Token**

```http
POST /v1/auth/verify
Content-Type: application/json

{
  "token": "abc123..."
}
```

### 2.2 Token Structure (JWT)

**Access Token Claims:**
```json
{
  "sub": "user-uuid",
  "email": "user@example.com",
  "role": "consumer",
  "merchant_id": "merchant-uuid",
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

> See [[pages-navigation-ux#Search Results Page]] for UI context.

#### Search Places

```http
GET /v1/places/search
Authorization: Bearer <token>  (optional)

Query Parameters:
  q           string    Search query (optional)
  lat         float     Latitude for geo-search
  lng         float     Longitude for geo-search
  radius      int       Search radius in meters (default: 5000)
  category    string    Filter by category
  open_now    boolean   Filter to currently open places
  page        int       Page number (default: 1)
  per_page    int       Results per page (default: 20)
```

### 3.2 Cart & Checkout

> See [[web-app-spec#6.3 Marketplace]] for business logic.

#### Get Cart

```http
GET /v1/cart
Authorization: Bearer <token>
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

### 3.3 Group Purchases

> See [[web-app-spec#6.3.2 Group Purchase Flow]] for flow details.

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

---

## 4. Merchant APIs

### 4.1 Capabilities

> See [[web-app-spec#Capability-based approach]] for capability model.

#### List Capabilities

```http
GET /v1/merchant/capabilities
Authorization: Bearer <token>
```

### 4.2 POS

> See [[monetization#POS Transaction Top-ups]] for quota details.

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
    }
  ],
  "payment_method": "cash",
  "consumer_qr_token": "optional-qr-token"
}
```

#### Get POS Quota Status

```http
GET /v1/merchant/pos/quota
Authorization: Bearer <token>
```

---

## 5. Error Handling

### 5.1 Common Error Codes

| Code | Description |
|------|-------------|
| `VALIDATION_ERROR` | Request body validation failed |
| `UNAUTHORIZED` | Authentication required |
| `CART_MERCHANT_CONFLICT` | Cart contains items from different merchant |
| `POS_QUOTA_EXCEEDED` | POS transaction quota exhausted |
| `CAPABILITY_NOT_ACTIVE` | Required capability not enabled |

---

## 6. Rate Limiting

| Endpoint Category | Limit | Window |
|-------------------|-------|--------|
| Authentication | 10 | 1 minute |
| Search | 60 | 1 minute |
| General API | 120 | 1 minute |
| POS Transactions | 300 | 1 minute |

---

#halava #spec #api
