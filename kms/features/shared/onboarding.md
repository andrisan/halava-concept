# Onboarding (Registration & Setup)

> **Feature Type:** Consumer & Merchant
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[directory]] · [[marketplace]] · [[pos]] · [[web-app-spec]]

---

## Definition

**Onboarding** is the registration and initial setup flow for both consumers and merchants. It's designed to be minimal-friction, getting users to value quickly without unnecessary barriers.

**Core principles:**
- **Consumers:** Sign up → Browse immediately
- **Merchants:** Sign up → Dashboard → Enable features gradually
- **No business type selection** — Capability model means merchants choose features, not categories

---

## How It Works

### Consumer Registration

1. **Sign up** with email (passwordless: OTP or magic link)
2. **Minimal profile:** Name only (phone optional)
3. **Ready to use:** Browse, save, and purchase

### Merchant Registration

1. **Sign up** as merchant (separate flow from consumer)
2. **Basic profile only:** Business name, contact email
3. **Land on dashboard** with suggested capabilities
4. **Enable features** incrementally (Directory, POS, Shop, etc.)
5. **No upfront classification** — No "Are you a restaurant or shop?" question

---

## User Journey

### Consumer: Register

```
Home → [Sign Up]
  → Enter email
  → Receive OTP / Magic link
  → Verify
  → Enter name (phone optional)
  → ✅ Account created
  → Redirect to Home (can browse, save, purchase)
```

### Consumer: First Purchase

```
After registration:
  → Browse products/places
  → Add to cart
  → Checkout prompts:
    - Delivery: Enter address (saved for future)
    - Payment: Follow payment flow
  → Complete first purchase
  → "Welcome! Your receipt is in Purchase History"
```

### Merchant: Register

```
Home → [Become a Merchant] or Register → [I'm a Merchant]
  → Enter email
  → Receive OTP / Magic link
  → Verify
  → Business profile:
    - Business name
    - Contact email
    - (No business type selection!)
  → ✅ Account created
  → Redirect to Merchant Dashboard
```

### Merchant: First-Time Dashboard

```
Dashboard (first login):
  → Welcome message: "Let's set up your business"
  → Suggested capabilities:
    ┌─────────────────────────────────────────┐
    │ Get Started                             │
    │                                         │
    │ Enable features for your business:      │
    │                                         │
    │ ┌─────────────┐ ┌─────────────┐         │
    │ │ 📍 Directory│ │ 🛒 Shop     │         │
    │ │ Get found   │ │ Sell online │         │
    │ │ [Enable]    │ │ [Enable]    │         │
    │ └─────────────┘ └─────────────┘         │
    │                                         │
    │ ┌─────────────┐ ┌─────────────┐         │
    │ │ 💳 POS      │ │ 🍽️ Restaurant│        │
    │ │ In-store   │ │ Food service│         │
    │ │ [Enable]    │ │ [Enable]    │         │
    │ └─────────────┘ └─────────────┘         │
    └─────────────────────────────────────────┘
  → Click [Enable] on any capability
  → Enter setup wizard for that capability
  → Complete setup → Capability active
```

### Merchant: Enable First Capability

Example: Enabling Directory

```
Dashboard → Capabilities → Directory → [Enable]
  → Setup Wizard:
    Step 1: Business name & category (restaurant, shop, service)
    Step 2: Address (map pin)
    Step 3: Operating hours
    Step 4: Photos (cover + gallery)
    Step 5: Halal status declaration
    Step 6: Optional: Upload certificate
  → [Publish]
  → ✅ Directory Listing Active
  → "Your business is now visible on Halava!"
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Sign Up** | `/signup` | Consumer registration |
| **Merchant Sign Up** | `/merchant/signup` | Merchant registration |
| **Verify Email** | `/verify` | OTP/magic link entry |
| **Profile Setup** | `/profile/setup` | Initial profile |
| **Merchant Dashboard** | `/merchant` | First-time dashboard |

### Consumer Sign Up

```
┌──────────────────────────────────────────┐
│ Create Account                           │
├──────────────────────────────────────────┤
│                                          │
│ Join Halava and discover halal           │
│ products and places.                     │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Email                                │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [ Continue with Email ]                  │
│                                          │
│ ─────────── or ───────────               │
│                                          │
│ [ Continue with Google ]                 │
│ [ Continue with Apple ]                  │
│                                          │
│ Already have an account? [Sign In]       │
│                                          │
│ ─────────────────────────────────────── │
│ Are you a merchant? [Register Business]  │
└──────────────────────────────────────────┘
```

### Email Verification

```
┌──────────────────────────────────────────┐
│ Check Your Email                         │
├──────────────────────────────────────────┤
│                                          │
│ We sent a verification code to:          │
│ user@example.com                         │
│                                          │
│ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐│
│ │    │ │    │ │    │ │    │ │    │ │    ││
│ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘│
│                                          │
│ Didn't receive it? [Resend]              │
│                                          │
│ [← Back]                                 │
└──────────────────────────────────────────┘
```

### Merchant Registration

```
┌──────────────────────────────────────────┐
│ Register Your Business                   │
├──────────────────────────────────────────┤
│                                          │
│ Join Halava to reach customers           │
│ seeking halal products and services.     │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Your Email                           │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [ Continue ]                             │
│                                          │
│ ─────────────────────────────────────── │
│                                          │
│ ✓ No business type selection required    │
│ ✓ Enable features as you need them       │
│ ✓ Free to start, pay as you grow         │
│                                          │
│ Already registered? [Sign In]            │
└──────────────────────────────────────────┘
```

### Merchant Profile Setup

```
┌──────────────────────────────────────────┐
│ Business Profile                         │
├──────────────────────────────────────────┤
│                                          │
│ Tell us about your business.             │
│ You can change this later.               │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Business Name *                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Contact Email *                      │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Phone (optional)                     │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [ Complete Setup ]                       │
│                                          │
│ Note: You'll choose features in the      │
│ next step — no business type needed.     │
└──────────────────────────────────────────┘
```

### First-Time Dashboard

```
┌─────────────────────────────────────────────────────────────────┐
│ 👋 Welcome to Halava, [Business Name]!                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│ Get started by enabling features for your business:             │
│                                                                 │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 📍 Directory Listing                                [Enable]│ │
│ │ Get discovered by customers searching for halal places.     │ │
│ │ Perfect for: Any halal business                             │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🛒 Online Shop                                      [Enable]│ │
│ │ Sell products online with delivery or pickup.               │ │
│ │ Perfect for: Grocery stores, specialty shops               │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 💳 Point of Sale (POS)                              [Enable]│ │
│ │ Register in-store sales and manage inventory.               │ │
│ │ Perfect for: Any retail business                            │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🍽️ Restaurant Operations                           [Enable]│ │
│ │ Manage menus, orders, and kitchen workflow.                 │ │
│ │ Perfect for: Restaurants, cafes, food stalls               │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ Not sure? Start with Directory Listing — it's free!            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         Merchant                                 │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User (owner) UNIQUE                  │
│  name            VARCHAR(255) NOT NULL                          │
│  slug            VARCHAR(100) UNIQUE NOT NULL                   │
│  description     TEXT                                           │
│  contact_email   VARCHAR(255)                                   │
│  contact_phone   VARCHAR(20)                                    │
│  logo_url        VARCHAR(500)                                   │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    MerchantCapability                            │
├─────────────────────────────────────────────────────────────────┤
│  merchant_id     UUID FK → Merchant                             │
│  capability_type ENUM(directory, shop, pos, restaurant)         │
│  status          ENUM(disabled, enabled_needs_setup,            │
│                       active, suspended)                        │
│  enabled_at      TIMESTAMP                                      │
│  setup_completed_at  TIMESTAMP                                  │
│  suspended_at    TIMESTAMP                                      │
│  suspended_reason VARCHAR(255)                                  │
│  PRIMARY KEY (merchant_id, capability_type)                     │
└─────────────────────────────────────────────────────────────────┘
```

### Capability Lifecycle

```
disabled → enabled_needs_setup → active
                 ↓                  ↓
              disabled          suspended
                                    ↓
                                 active (reinstated)
```

| State | Description |
|-------|-------------|
| **disabled** | Capability not enabled |
| **enabled_needs_setup** | Enabled but requires configuration |
| **active** | Fully configured and usable |
| **suspended** | Temporarily disabled (policy/billing) |

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `merchant` | `user_id` (unique) | Owner lookup |
| `merchant` | `slug` (unique) | URL lookup |
| `merchant_capability` | `merchant_id, capability_type` (primary) | Capability lookup |

---

## API Endpoints

> Full API index: [[api-spec#2. Auth Module]], [[api-spec#6.1 Profile & Capabilities]]

### POST /v1/auth/register

Register a new user account.

```json
// Request
{
  "email": "user@example.com",
  "name": "Ahmad"
}

// Response
{
  "message": "Verification code sent",
  "expires_in": 600
}
```

### GET /v1/consumer/profile

Get current user profile.

```json
// Response
{
  "id": "uuid",
  "email": "user@example.com",
  "name": "Ahmad",
  "phone": "+81-90-1234-5678",
  "role": "consumer",
  "created_at": "2026-01-01"
}
```

### PATCH /v1/consumer/profile

Update user profile.

```json
// Request
{
  "name": "Ahmad K.",
  "phone": "+81-90-1234-5678"
}

// Response
{
  "id": "uuid",
  "updated_at": "2026-01-28"
}
```

### POST /v1/merchant/register

Register a new merchant account.

```json
// Request
{
  "business_name": "Halal Mart Shibuya",
  "contact_email": "contact@halalmart.jp"
}

// Response
{
  "merchant_id": "uuid",
  "slug": "halal-mart-shibuya",
  "status": "created"
}
```

### GET /v1/merchant/profile

Get merchant profile.

```json
// Response
{
  "id": "uuid",
  "name": "Halal Mart Shibuya",
  "slug": "halal-mart-shibuya",
  "description": "...",
  "contact_email": "contact@halalmart.jp",
  "logo_url": "..."
}
```

### PATCH /v1/merchant/profile

Update merchant profile.

```json
// Request
{
  "description": "Your one-stop halal grocery store",
  "contact_phone": "03-1234-5678"
}
```

### GET /v1/merchant/capabilities

List merchant capabilities and their status.

```json
// Response
{
  "capabilities": [
    { "type": "directory", "status": "active" },
    { "type": "marketplace", "status": "enabled_needs_setup" },
    { "type": "pos", "status": "disabled" },
    { "type": "restaurant", "status": "disabled" }
  ]
}
```

### POST /v1/merchant/capabilities/{type}/enable

Enable a capability. Triggers setup wizard.

```json
// Response
{
  "type": "marketplace",
  "status": "enabled_needs_setup",
  "setup_url": "/merchant/setup/marketplace"
}
```

---

## Why No Business Type Selection

Traditional platforms ask: "Are you a restaurant or a shop?"

**Problems with this approach:**
- Many halal businesses are **hybrid** (e.g., restaurant with grocery corner)
- Early classification creates **onboarding friction**
- Users often don't know which category fits
- Changing type later requires data migration

**Halava's approach:**
- Skip the question entirely
- Let merchants **enable features** as needed
- A restaurant can add Shop later without re-registering
- Lower drop-off, higher activation

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Consumer sign-up completion | > 80% |
| Merchant registration completion | > 70% |
| Time to first capability enabled | < 10 min |
| First capability activation (setup complete) | > 60% within 24h |

---

## Dependencies

- [[web-app-spec#Accounts & Authentication]] — Auth flow details
- [[directory]] — First capability many merchants enable
- [[pos]] — Common first capability for retail
- [[marketplace]] — Online selling capability

---

#halava #feature #onboarding #registration #consumer #merchant
