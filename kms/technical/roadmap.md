# Halava Roadmap

> **Last updated:** February 2026
> **Status:** Active
>
> **Related:** [[web-app-spec]] · [[monetization]]

---

## Release Overview

| Version | Codename | Target | Status |
|---------|----------|--------|--------|
| v1.0 | Discover + Shop + POS | MVP | In Progress |
| v1.1 | Restaurant Ops | Post-MVP | Planned |
| v1.2 | Advanced Order & Accounting | Future | Planned |

---

## v1.0 — "Discover + Shop + POS" (MVP)

**Goal:** Launch with a complete consumer-to-merchant transaction flow covering both online and in-store purchases.

### Shared Features

| Feature | Description |
|---------|-------------|
| [[authentication]] | Email/OTP passwordless login (consumers & merchants) |
| [[onboarding]] | Profile setup for consumers and merchants |
| [[roles-permissions]] | Role-based access (Owner, Staff: Cashier/Inventory/Part-time) |
| [[notifications]] | Order updates, alerts, low-stock warnings |
| [[directory]] | Consumers discover places; merchants manage listings |
| [[marketplace]] | Consumers shop; merchants sell products |

### Consumer Features

| Feature | Description |
|---------|-------------|
| [[directory#Place Pages\|Place Pages]] | Hours, photos, tags, halal status disclosure *(→ [[directory]])* |
| [[directory#Search & Filters\|Search & Filters]] | Distance, open now, cuisine, amenities *(→ [[directory]])* |
| [[group-purchase]] | Multiple users contribute to shared order |
| [[expense-insight]] | Expense tracking, spending insights, personal price history |
| [[bopu]] | Buy-online-pick-up options |
| [[reviews-ratings]] | Rate places and products |
| [[saved-items]] | Bookmark places and products |

### Merchant Features

| Feature | Description |
|---------|-------------|
| [[pos]] | POS capability for in-store sales |
| [[products]] | Manage products with prices and stock |
| [[order-management]] | Online orders + POS transactions |
| [[inventory]] | Low-stock alerts (online + in-store) |
| [[promotions]] | Basic coupon codes |

### Acceptance Criteria

- [ ] Merchants can register in-store purchases via POS
- [ ] POS transactions appear in consumers' unified purchase history (when linked)
- [ ] Inventory updates correctly for both online and in-store sales
- [ ] Consumers can perform bulk/group purchases and choose delivery or pickup
- [ ] A merchant can register without selecting shop or restaurant
- [ ] Capabilities can be enabled incrementally without data migration

---

## v1.1 — "Restaurant Ops"

**Goal:** Enable food service businesses with dine-in, takeaway, and kitchen operations.

### Shared Features

| Feature | Description |
|---------|-------------|
| [[multi-language]] | EN + JP + ID support across platform |

### Merchant Features

| Feature | Description |
|---------|-------------|
| [[restaurant-ops]] | Restaurant Operations capability |
| [[restaurant-ops#Menu Management\|Menu Management]] | Menu items with modifiers *(→ [[restaurant-ops]])* |
| [[restaurant-ops#QR Menu\|QR Menu]] | Contactless ordering *(→ [[restaurant-ops]])* |
| [[restaurant-ops#Kitchen Queue\|Kitchen Queue]] | Order preparation workflow *(→ [[restaurant-ops]])* |
| [[restaurant-ops#Reservations\|Reservations]] | Table booking system *(→ [[restaurant-ops]])* |
| [[pos#Advanced POS\|Advanced POS]] | Tables, split bills, modifiers *(→ [[pos]])* |

---

## v1.2 — "Advanced Order & Accounting"

**Goal:** Enhanced group ordering and merchant financial tools.

### Consumer Features

| Feature | Description |
|---------|-------------|
| [[group-purchase#In-city Group Delivery\|In-city Group Delivery]] | Collaborative cart, dynamic shipping, distribution tracking *(→ [[group-purchase]])* |

### Merchant Features

| Feature | Description |
|---------|-------------|
| [[accounting]] | Bookkeeping, invoicing, tax exports |

---

## Upcoming Versions

> 📝 **Template for future releases.** Copy the structure below when defining new versions.

```markdown
## vX.X — "Brief Summary"

**Goal:** One-sentence description of the release goal.

| Feature | Description |
|---------|-------------|
| Feature name | What it does |
```

---

## Future Considerations

> ⚠️ **Note:** Items below are preliminary ideas and have not been fully scoped or validated. Details subject to change based on user feedback and market conditions.

| Feature | Description | Timeline |
|---------|-------------|----------|
| Payment Integration | Stripe Connect / PAY.JP | Phase 2 |
| Direct Payments | 資金移動業 license | 3-5+ years |
| Personalized Recommendations | ML-based discovery | TBD |
| Multi-region | Expansion beyond Japan | TBD |

---

#halava #roadmap #planning
