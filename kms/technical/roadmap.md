# Halava Roadmap

> **Last updated:** March 2026
> **Status:** Active
>
> **Related:** [[web-app-spec]] · [[monetization]]

---

## Release Overview

All features are part of a single release. No version gating.

| Version | Codename | Status |
|---------|----------|--------|
| v1.0 | Full Platform | In Progress |

---

## v1.0 — Full Platform

**Goal:** Launch with the complete feature set — consumer discovery, marketplace, merchant operations, restaurant capabilities, POS, app platform, and platform moderation tools.

### Shared Features

| Feature | Description | Implemented? |
|---------|-------------|--------------|
| [[authentication]] | Email/OTP passwordless login (consumers & merchants) | ✅ Core |
| [[onboarding]] | Profile setup for consumers and merchants | ❌ |
| [[roles-permissions]] | Role-based access (Owner, Staff: Cashier/Inventory/Part-time) | ✅ |
| [[notifications]] | Order updates, alerts, low-stock warnings | ❌ |
| [[directory]] | Consumers discover places; merchants manage listings | ✅ |
| [[marketplace]] | Consumers shop; merchants sell products | ✅ |
| [[multi-language]] | EN + JP + ID support across platform | ❌ |
| Messaging | Consumer ↔ Merchant conversation threads | ✅ |

### Consumer Features

| Feature | Description | Implemented? |
|---------|-------------|--------------|
| [[directory#Place Pages\|Place Pages]] | Hours, photos, tags, halal status disclosure | ✅ |
| [[directory#Search & Filters\|Search & Filters]] | Distance, open now, cuisine, amenities | ✅ Core |
| [[group-purchase]] | Multiple users contribute to shared order | ✅ |
| [[bopu]] | Buy-online-pick-up options | ⚠️ Partial |
| [[reviews-ratings]] | Rate places and products | ❌ |
| [[saved-items]] | Bookmark places and products | ✅ |

### Merchant Features

| Feature | Description | Implemented? |
|---------|-------------|--------------|
| [[pos]] | POS capability for in-store sales | ✅ |
| [[products]] | Manage products with prices and stock | ✅ |
| [[order-management]] | Online orders + POS transactions | ✅ |
| [[inventory]] | Low-stock alerts (online + in-store) | ✅ Core |
| [[promotions]] | Basic coupon codes | ❌ |
| [[restaurant-ops]] | Restaurant Operations capability | ✅ |
| [[restaurant-ops#Menu Management\|Menu Management]] | Menu items with modifiers | ✅ |
| [[restaurant-ops#QR Menu\|QR Menu]] | Contactless ordering | ✅ |
| [[restaurant-ops#Kitchen Queue\|Kitchen Queue]] | Order preparation workflow | ✅ |
| [[restaurant-ops#Reservations\|Reservations]] | Table booking system | ❌ |
| [[pos#Advanced POS\|Advanced POS]] | Tables, split bills, modifiers | ❌ |
| [[accounting]] | Bookkeeping, invoicing, tax exports | ❌ |

### Platform Features

| Feature | Description | Implemented? |
|---------|-------------|--------------|
| [[admin-moderation]] | Content moderation, report handling, user management | ❌ |
| App Platform | Installable first-party and third-party apps | ✅ |
| Billing | Usage-based fees, SKU breakdown, monthly invoice | ✅ |

---

## Acceptance Criteria

- [ ] Merchants can register in-store purchases via POS
- [ ] POS transactions appear in consumers' unified purchase history (when linked)
- [ ] Inventory updates correctly for both online and in-store sales
- [ ] Consumers can perform bulk/group purchases and choose delivery or pickup
- [ ] A merchant can register without selecting shop or restaurant
- [ ] Capabilities can be enabled incrementally without data migration

---

## Future Considerations

> ⚠️ **Note:** Items below are preliminary ideas and have not been fully scoped or validated.

| Feature | Description | Timeline |
|---------|-------------|----------|
| Payment Integration | Stripe Connect (Halava Pay launch) | Phase 2 |
| Payment Processor Survey | Evaluate Adyen / KOMOJU / GMO-PG when Stripe margin pressure is measurable | Phase 3 |
| Personalized Recommendations | ML-based discovery | TBD |
| Multi-region | Expansion beyond Japan | TBD |

---

#halava #roadmap #planning
