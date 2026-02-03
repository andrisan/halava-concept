# Halava API Specification

> **Last updated:** February 2026
> **Status:** Index (detailed specs in feature docs)
> **API Version:** v1
>
> **Related documents:**
> - [[web-app-spec]] — Product specification
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

### 1.4 Module-Based Organization

> See [[architecture#8.3 Modular Monolith Architecture]] for module boundaries.

API endpoints are organized by **module ownership**, not user type. This supports future microservices migration.

| Module | Base Path | Responsibility |
|--------|-----------|----------------|
| Auth | `/v1/auth` | Authentication, sessions, tokens |
| Directory | `/v1/directory` | Place discovery, geo-search, reviews |
| Marketplace | `/v1/marketplace` | Products, cart, orders, group purchases |
| Consumer | `/v1/consumer` | User profile, saved items, expense tracking |
| Merchant | `/v1/merchant` | Business profile, capabilities, staff, products, inventory |
| POS | `/v1/pos` | In-store transactions, offline sync |
| Notification | `/v1/notifications` | User notifications, preferences |

---

## 2. Auth Module

> **Base Path:** `/v1/auth`
> **Details:** [[authentication]]

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[authentication]] | `POST` | [[authentication#POST /v1/auth/magic-link\|/v1/auth/magic-link]] | Request magic link login |
| [[authentication]] | `POST` | [[authentication#POST /v1/auth/otp\|/v1/auth/otp]] | Request OTP login |
| [[authentication]] | `POST` | [[authentication#POST /v1/auth/verify\|/v1/auth/verify]] | Verify OTP or magic link token |
| [[authentication]] | `POST` | [[authentication#POST /v1/auth/refresh\|/v1/auth/refresh]] | Refresh access token |
| [[authentication]] | `POST` | [[authentication#POST /v1/auth/logout\|/v1/auth/logout]] | Logout (revoke session) |
| [[authentication]] | `GET` | [[authentication#GET /v1/auth/sessions\|/v1/auth/sessions]] | List active sessions |
| [[authentication]] | `DELETE` | [[authentication#DELETE /v1/auth/sessions/{id}\|/v1/auth/sessions/{id}]] | Revoke specific session |
| [[authentication]] | `POST` | [[authentication#POST /v1/auth/oauth/google\|/v1/auth/oauth/google]] | Google OAuth callback |
| [[authentication]] | `POST` | [[authentication#POST /v1/auth/oauth/apple\|/v1/auth/oauth/apple]] | Apple Sign-In callback |
| [[onboarding]] | `POST` | [[onboarding#POST /v1/auth/register\|/v1/auth/register]] | Register new user |

---

## 3. Directory Module

> **Base Path:** `/v1/directory`
> **Details:** [[directory]], [[reviews-ratings]]

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[directory]] | `GET` | [[directory#GET /v1/directory/search\|/v1/directory/search]] | Universal search (places + products) |
| [[directory]] | `GET` | [[directory#GET /v1/directory/search/suggestions\|/v1/directory/search/suggestions]] | Autocomplete suggestions |
| [[directory]] | `GET` | [[directory#GET /v1/directory/places\|/v1/directory/places]] | Search/list places with geo-filter |
| [[directory]] | `GET` | [[directory#GET /v1/directory/places/{slug}\|/v1/directory/places/{slug}]] | Get place details |
| [[directory]] | `GET` | [[directory#GET /v1/directory/places/{slug}/photos\|/v1/directory/places/{slug}/photos]] | Get place photo gallery |
| [[reviews-ratings]] | `GET` | [[reviews-ratings#GET /v1/directory/places/{slug}/reviews\|/v1/directory/places/{slug}/reviews]] | List place reviews |
| [[reviews-ratings]] | `POST` | [[reviews-ratings#POST /v1/directory/places/{slug}/reviews\|/v1/directory/places/{slug}/reviews]] | Add place review |

---

## 4. Marketplace Module

> **Base Path:** `/v1/marketplace`
> **Details:** [[marketplace]], [[group-purchase]], [[reviews-ratings]]

### 4.1 Products

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[marketplace]] | `GET` | [[marketplace#GET /v1/marketplace/products\|/v1/marketplace/products]] | Search/list products |
| [[marketplace]] | `GET` | [[marketplace#GET /v1/marketplace/products/{id}\|/v1/marketplace/products/{id}]] | Get product details |
| [[reviews-ratings]] | `GET` | [[reviews-ratings#GET /v1/marketplace/products/{id}/reviews\|/v1/marketplace/products/{id}/reviews]] | List product reviews |
| [[reviews-ratings]] | `POST` | [[reviews-ratings#POST /v1/marketplace/products/{id}/reviews\|/v1/marketplace/products/{id}/reviews]] | Add product review |

### 4.2 Cart

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[marketplace]] | `GET` | [[marketplace#GET /v1/marketplace/cart\|/v1/marketplace/cart]] | Get current cart |
| [[marketplace]] | `POST` | [[marketplace#POST /v1/marketplace/cart/items\|/v1/marketplace/cart/items]] | Add item to cart |
| [[marketplace]] | `PATCH` | [[marketplace#PATCH /v1/marketplace/cart/items/{id}\|/v1/marketplace/cart/items/{id}]] | Update cart item quantity |
| [[marketplace]] | `DELETE` | [[marketplace#DELETE /v1/marketplace/cart/items/{id}\|/v1/marketplace/cart/items/{id}]] | Remove item from cart |

### 4.3 Orders

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[marketplace]] | `POST` | [[marketplace#POST /v1/marketplace/orders\|/v1/marketplace/orders]] | Create order (checkout) |
| [[marketplace]] | `GET` | [[marketplace#GET /v1/marketplace/orders/{id}\|/v1/marketplace/orders/{id}]] | Get order details |
| [[marketplace]] | `GET` | [[marketplace#GET /v1/marketplace/orders\|/v1/marketplace/orders]] | List user's orders |

### 4.4 Group Purchases

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[group-purchase]] | `POST` | [[group-purchase#POST /v1/marketplace/group-purchases\|/v1/marketplace/group-purchases]] | Create group purchase |
| [[group-purchase]] | `GET` | [[group-purchase#GET /v1/marketplace/group-purchases/{code}\|/v1/marketplace/group-purchases/{code}]] | Get group details |
| [[group-purchase]] | `POST` | [[group-purchase#POST /v1/marketplace/group-purchases/{code}/join\|/v1/marketplace/group-purchases/{code}/join]] | Join as participant |
| [[group-purchase]] | `POST` | [[group-purchase#POST /v1/marketplace/group-purchases/{code}/items\|/v1/marketplace/group-purchases/{code}/items]] | Add item (participant) |
| [[group-purchase]] | `DELETE` | [[group-purchase#DELETE /v1/marketplace/group-purchases/{code}/items/{id}\|/v1/marketplace/group-purchases/{code}/items/{id}]] | Remove item |
| [[group-purchase]] | `POST` | [[group-purchase#POST /v1/marketplace/group-purchases/{code}/submit\|/v1/marketplace/group-purchases/{code}/submit]] | Submit order (initiator) |
| [[group-purchase]] | `GET` | [[group-purchase#GET /v1/marketplace/group-purchases/{code}/breakdown\|/v1/marketplace/group-purchases/{code}/breakdown]] | Get participant breakdown |

---

## 5. Consumer Module

> **Base Path:** `/v1/consumer`
> **Details:** [[saved-items]], [[expense-tracker]], [[reviews-ratings]]

### 5.1 Profile

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[onboarding]] | `GET` | [[onboarding#GET /v1/consumer/profile\|/v1/consumer/profile]] | Get user profile |
| [[onboarding]] | `PATCH` | [[onboarding#PATCH /v1/consumer/profile\|/v1/consumer/profile]] | Update user profile |
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/qr\|/v1/consumer/qr]] | Get user's linking QR code |

### 5.2 Saved Items

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[saved-items]] | `GET` | [[saved-items#GET /v1/consumer/saved\|/v1/consumer/saved]] | List all saved items |
| [[saved-items]] | `GET` | [[saved-items#GET /v1/consumer/saved/places\|/v1/consumer/saved/places]] | List saved places |
| [[saved-items]] | `GET` | [[saved-items#GET /v1/consumer/saved/products\|/v1/consumer/saved/products]] | List saved products |
| [[saved-items]] | `POST` | [[saved-items#POST /v1/consumer/saved\|/v1/consumer/saved]] | Save an item |
| [[saved-items]] | `DELETE` | [[saved-items#DELETE /v1/consumer/saved/{id}\|/v1/consumer/saved/{id}]] | Remove saved item |
| [[saved-items]] | `GET` | [[saved-items#GET /v1/consumer/collections\|/v1/consumer/collections]] | List collections |
| [[saved-items]] | `POST` | [[saved-items#POST /v1/consumer/collections\|/v1/consumer/collections]] | Create collection |
| [[saved-items]] | `PUT` | [[saved-items#PUT /v1/consumer/collections/{id}\|/v1/consumer/collections/{id}]] | Update collection |
| [[saved-items]] | `DELETE` | [[saved-items#DELETE /v1/consumer/collections/{id}\|/v1/consumer/collections/{id}]] | Delete collection |
| [[saved-items]] | `POST` | [[saved-items#POST /v1/consumer/collections/{id}/items\|/v1/consumer/collections/{id}/items]] | Add item to collection |
| [[saved-items]] | `DELETE` | [[saved-items#DELETE /v1/consumer/collections/{id}/items/{item_id}\|/v1/consumer/collections/{id}/items/{item_id}]] | Remove from collection |
| [[saved-items]] | `GET` | [[saved-items#GET /v1/consumer/shared/{share_token}\|/v1/consumer/shared/{token}]] | View shared collection |

### 5.3 Expense Tracker

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/expenses/purchases\|/v1/consumer/expenses/purchases]] | List user's purchases |
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/expenses/purchases/{id}\|/v1/consumer/expenses/purchases/{id}]] | Get purchase details |
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/expenses/purchases/export\|/v1/consumer/expenses/purchases/export]] | Export purchases (CSV/JSON) |
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/expenses/insights\|/v1/consumer/expenses/insights]] | Get spending analytics |
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/expenses/prices/{item_id}\|/v1/consumer/expenses/prices/{item_id}]] | Get item price history |
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/expenses/frequent\|/v1/consumer/expenses/frequent]] | Get frequently bought items |
| [[expense-tracker]] | `GET` | [[expense-tracker#GET /v1/consumer/expenses/budgets\|/v1/consumer/expenses/budgets]] | Get budget goals |
| [[expense-tracker]] | `PUT` | [[expense-tracker#PUT /v1/consumer/expenses/budgets\|/v1/consumer/expenses/budgets]] | Create/update budget |
| [[expense-tracker]] | `DELETE` | [[expense-tracker#DELETE /v1/consumer/expenses/budgets/{id}\|/v1/consumer/expenses/budgets/{id}]] | Delete budget |

### 5.4 Reviews

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[reviews-ratings]] | `GET` | [[reviews-ratings#GET /v1/consumer/reviews\|/v1/consumer/reviews]] | Get user's reviews |
| [[reviews-ratings]] | `POST` | [[reviews-ratings#POST /v1/consumer/reviews\|/v1/consumer/reviews]] | Create review |
| [[reviews-ratings]] | `PUT` | [[reviews-ratings#PUT /v1/consumer/reviews/{id}\|/v1/consumer/reviews/{id}]] | Update own review |
| [[reviews-ratings]] | `DELETE` | [[reviews-ratings#DELETE /v1/consumer/reviews/{id}\|/v1/consumer/reviews/{id}]] | Delete own review |
| [[reviews-ratings]] | `POST` | [[reviews-ratings#POST /v1/consumer/reviews/{id}/helpful\|/v1/consumer/reviews/{id}/helpful]] | Mark as helpful |
| [[reviews-ratings]] | `DELETE` | [[reviews-ratings#DELETE /v1/consumer/reviews/{id}/helpful\|/v1/consumer/reviews/{id}/helpful]] | Remove helpful vote |
| [[reviews-ratings]] | `POST` | [[reviews-ratings#POST /v1/consumer/reviews/{id}/report\|/v1/consumer/reviews/{id}/report]] | Report review |

---

## 6. Merchant Module

> **Base Path:** `/v1/merchant`
> **Details:** [[onboarding]], [[products]], [[inventory]], [[order-management]]

### 6.1 Profile & Capabilities

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[onboarding]] | `POST` | [[onboarding#POST /v1/merchant/register\|/v1/merchant/register]] | Register merchant |
| [[onboarding]] | `GET` | [[onboarding#GET /v1/merchant/profile\|/v1/merchant/profile]] | Get merchant profile |
| [[onboarding]] | `PATCH` | [[onboarding#PATCH /v1/merchant/profile\|/v1/merchant/profile]] | Update merchant profile |
| [[onboarding]] | `GET` | [[onboarding#GET /v1/merchant/capabilities\|/v1/merchant/capabilities]] | List capabilities |
| [[onboarding]] | `POST` | [[onboarding#POST /v1/merchant/capabilities/{type}/enable\|/v1/merchant/capabilities/{type}/enable]] | Enable capability |

### 6.2 Staff Management

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[roles-permissions]] | `GET` | [[roles-permissions#GET /v1/merchant/staff\|/v1/merchant/staff]] | List staff members |
| [[roles-permissions]] | `POST` | [[roles-permissions#POST /v1/merchant/staff\|/v1/merchant/staff]] | Invite staff member |
| [[roles-permissions]] | `DELETE` | [[roles-permissions#DELETE /v1/merchant/staff/{id}\|/v1/merchant/staff/{id}]] | Remove staff member |
| [[roles-permissions]] | `PUT` | [[roles-permissions#PUT /v1/merchant/staff/{id}\|/v1/merchant/staff/{id}]] | Update staff (role, status) |
| [[roles-permissions]] | `GET` | [[roles-permissions#GET /v1/merchant/roles\|/v1/merchant/roles]] | List staff roles |
| [[roles-permissions]] | `POST` | [[roles-permissions#POST /v1/merchant/roles\|/v1/merchant/roles]] | Create custom role |
| [[roles-permissions]] | `PUT` | [[roles-permissions#PUT /v1/merchant/roles/{id}\|/v1/merchant/roles/{id}]] | Update role |
| [[roles-permissions]] | `DELETE` | [[roles-permissions#DELETE /v1/merchant/roles/{id}\|/v1/merchant/roles/{id}]] | Delete role |

### 6.3 Products & Catalog

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[products]] | `GET` | [[products#GET /v1/merchant/products\|/v1/merchant/products]] | List products |
| [[products]] | `POST` | [[products#POST /v1/merchant/products\|/v1/merchant/products]] | Create product |
| [[products]] | `GET` | [[products#GET /v1/merchant/products/{id}\|/v1/merchant/products/{id}]] | Get product |
| [[products]] | `PUT` | [[products#PUT /v1/merchant/products/{id}\|/v1/merchant/products/{id}]] | Update product |
| [[products]] | `DELETE` | [[products#DELETE /v1/merchant/products/{id}\|/v1/merchant/products/{id}]] | Archive product |
| [[products]] | `POST` | [[products#POST /v1/merchant/products/{id}/photos\|/v1/merchant/products/{id}/photos]] | Upload photo |
| [[products]] | `GET` | [[products#GET /v1/merchant/categories\|/v1/merchant/categories]] | List categories |
| [[products]] | `POST` | [[products#POST /v1/merchant/categories\|/v1/merchant/categories]] | Create category |
| [[products]] | `PUT` | [[products#PUT /v1/merchant/categories/{id}\|/v1/merchant/categories/{id}]] | Update category |
| [[products]] | `POST` | [[products#POST /v1/merchant/products/import\|/v1/merchant/products/import]] | Bulk import (CSV) |
| [[products]] | `GET` | [[products#GET /v1/merchant/products/export\|/v1/merchant/products/export]] | Export catalog |

### 6.4 Inventory

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[inventory]] | `GET` | [[inventory#GET /v1/merchant/inventory\|/v1/merchant/inventory]] | List inventory status |
| [[inventory]] | `GET` | [[inventory#GET /v1/merchant/inventory/{item_id}\|/v1/merchant/inventory/{item_id}]] | Get item stock |
| [[inventory]] | `POST` | [[inventory#POST /v1/merchant/inventory/{item_id}/adjust\|/v1/merchant/inventory/{item_id}/adjust]] | Adjust stock |
| [[inventory]] | `GET` | [[inventory#GET /v1/merchant/inventory/{item_id}/history\|/v1/merchant/inventory/{item_id}/history]] | Stock history |
| [[inventory]] | `GET` | [[inventory#GET /v1/merchant/inventory/alerts\|/v1/merchant/inventory/alerts]] | Get low stock alerts |
| [[inventory]] | `PUT` | [[inventory#PUT /v1/merchant/inventory/settings\|/v1/merchant/inventory/settings]] | Update alert settings |
| [[inventory]] | `POST` | [[inventory#POST /v1/merchant/stocktake\|/v1/merchant/stocktake]] | Start stocktake |
| [[inventory]] | `PUT` | [[inventory#PUT /v1/merchant/stocktake/{id}\|/v1/merchant/stocktake/{id}]] | Update stocktake |
| [[inventory]] | `POST` | [[inventory#POST /v1/merchant/stocktake/{id}/complete\|/v1/merchant/stocktake/{id}/complete]] | Complete stocktake |

### 6.5 Orders

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[order-management]] | `GET` | [[order-management#GET /v1/merchant/orders\|/v1/merchant/orders]] | List orders (with filters) |
| [[order-management]] | `GET` | [[order-management#GET /v1/merchant/orders/{id}\|/v1/merchant/orders/{id}]] | Get order details |
| [[order-management]] | `PUT` | [[order-management#PUT /v1/merchant/orders/{id}/status\|/v1/merchant/orders/{id}/status]] | Update order status |
| [[order-management]] | `POST` | [[order-management#POST /v1/merchant/orders/{id}/confirm-payment\|/v1/merchant/orders/{id}/confirm-payment]] | Confirm payment received |
| [[order-management]] | `POST` | [[order-management#POST /v1/merchant/orders/{id}/cancel\|/v1/merchant/orders/{id}/cancel]] | Cancel order |
| [[order-management]] | `POST` | [[order-management#POST /v1/merchant/orders/{id}/refund\|/v1/merchant/orders/{id}/refund]] | Initiate refund |
| [[order-management]] | `PUT` | [[order-management#PUT /v1/merchant/orders/{id}/tracking\|/v1/merchant/orders/{id}/tracking]] | Add tracking info |
| [[order-management]] | `GET` | [[order-management#GET /v1/merchant/orders/stats\|/v1/merchant/orders/stats]] | Order statistics |

### 6.6 Directory (Place Management)

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[directory]] | `POST` | [[directory#POST /v1/merchant/places\|/v1/merchant/places]] | Create place listing |
| [[directory]] | `PUT` | [[directory#PUT /v1/merchant/places/{id}\|/v1/merchant/places/{id}]] | Update place listing |

---

## 7. POS Module

> **Base Path:** `/v1/pos`
> **Details:** [[pos]]

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[pos]] | `POST` | [[pos#POST /v1/pos/transactions\|/v1/pos/transactions]] | Create transaction |
| [[pos]] | `GET` | [[pos#GET /v1/pos/transactions\|/v1/pos/transactions]] | List transactions |
| [[pos]] | `GET` | [[pos#GET /v1/pos/transactions/{id}\|/v1/pos/transactions/{id}]] | Get transaction |
| [[pos]] | `GET` | [[pos#GET /v1/pos/quota\|/v1/pos/quota]] | Get quota status |
| [[pos]] | `POST` | [[pos#POST /v1/pos/quota/topup\|/v1/pos/quota/topup]] | Purchase top-up |
| [[pos]] | `POST` | [[pos#POST /v1/pos/sync\|/v1/pos/sync]] | Sync offline transactions |

---

## 8. Notification Module

> **Base Path:** `/v1/notifications`
> **Details:** [[notifications]]

| Feature(s) | Method | Endpoint | Description |
|------------|--------|----------|-------------|
| [[notifications]] | `GET` | [[notifications#GET /v1/notifications\|/v1/notifications]] | List user's notifications |
| [[notifications]] | `POST` | [[notifications#POST /v1/notifications/{id}/read\|/v1/notifications/{id}/read]] | Mark as read |
| [[notifications]] | `POST` | [[notifications#POST /v1/notifications/read-all\|/v1/notifications/read-all]] | Mark all as read |
| [[notifications]] | `GET` | [[notifications#GET /v1/notifications/preferences\|/v1/notifications/preferences]] | Get preferences |
| [[notifications]] | `PUT` | [[notifications#PUT /v1/notifications/preferences\|/v1/notifications/preferences]] | Update preferences |
| [[notifications]] | `GET` | [[notifications#GET /v1/merchant/notifications/preferences\|/v1/merchant/notifications/preferences]] | Merchant prefs |
| [[notifications]] | `PUT` | [[notifications#PUT /v1/merchant/notifications/preferences\|/v1/merchant/notifications/preferences]] | Update merchant prefs |

---

## 9. Error Handling

### 9.1 Error Response Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request body",
    "details": [
      { "field": "email", "message": "Invalid email format" }
    ]
  }
}
```

### 9.2 Common Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `VALIDATION_ERROR` | 400 | Request body validation failed |
| `UNAUTHORIZED` | 401 | Authentication required |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `CART_MERCHANT_CONFLICT` | 400 | Cart contains items from different merchant |
| `POS_QUOTA_EXCEEDED` | 402 | POS transaction quota exhausted |
| `CAPABILITY_NOT_ACTIVE` | 403 | Required capability not enabled |

---

## 10. Rate Limiting

Rate limits are applied per module:

| Module | Limit | Window |
|--------|-------|--------|
| Auth | 10 requests | 1 minute |
| Directory | 60 requests | 1 minute |
| Marketplace | 120 requests | 1 minute |
| Consumer | 120 requests | 1 minute |
| Merchant | 60 requests | 1 minute |
| POS | 300 requests | 1 minute |
| Notification | 60 requests | 1 minute |

**Rate Limit Headers:**
```
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 45
X-RateLimit-Reset: 1704067260
```

---

## 11. Authentication

### 11.1 Token Structure (JWT)

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

### 11.2 Authorization Header

```
Authorization: Bearer <access_token>
```

---

#halava #spec #api
