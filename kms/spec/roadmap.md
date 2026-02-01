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
| v1.3 | Advanced Order & Accounting | Future | Planned |

---

## v1.0 — "Discover + Shop + POS" (MVP)

**Goal:** Launch with a complete consumer-to-merchant transaction flow covering both online and in-store purchases.

### Consumer Features

| Feature | Description |
|---------|-------------|
| Authentication | Email/OTP passwordless login |
| [[directory]] | Location-based discovery (map + list) |
| Place Pages | Hours, photos, tags, halal status disclosure |
| Search & Filters | Distance, open now, cuisine, amenities |
| [[marketplace]] | Product catalog, cart, checkout, order tracking |
| [[group-purchase]] | Multiple users contribute to shared order |
| Purchase History | Unified expense tracking across all orders |
| Price Comparison | Historical price tracking across merchants |
| BOPU | Buy-online-pick-up options |
| Reviews & Ratings | Rate places and products |
| Saved Items | Bookmark places and products |

### Merchant Features

| Feature | Description |
|---------|-------------|
| Onboarding | Business profile only (no type selection) |
| [[directory]] | Business listing capability |
| [[marketplace]] | Shop / Marketplace Selling capability |
| [[pos]] | POS capability for in-store sales |
| Products | Manage products with prices and stock |
| Orders Dashboard | Online orders + POS transactions |
| Inventory | Low-stock alerts (online + in-store) |
| Promotions | Basic coupon codes |

---

## v1.1 — "Restaurant Ops"

**Goal:** Enable food service businesses with dine-in, takeaway, and kitchen operations.

| Feature | Description |
|---------|-------------|
| [[restaurant-ops]] | Restaurant Operations capability |
| Menu Management | Menu items with modifiers |
| QR Menu | Contactless ordering |
| Reservations | Table booking (or QR menu — choose one) |
| Advanced POS | Tables, split bills, modifiers |
| Kitchen Queue | Order preparation workflow |
| Multi-language | EN + JP + ID support |

---

## v1.3 — "Advanced Order & Accounting"

**Goal:** Enhanced group ordering and merchant financial tools.

### In-city Group Delivery

| Aspect | Description |
|--------|-------------|
| Collaborative Cart | Multiple users add items to shared cart |
| Single Payer | Initiator pays full amount (items + shipping) |
| Dynamic Shipping | Free delivery if order exceeds threshold (e.g., ¥10,000) |
| Simplified Fulfillment | Merchant fulfills one order; Initiator distributes |
| Transparency | Detailed per-participant breakdown for reimbursement |

### Accounting Capability

| Feature | Description |
|---------|-------------|
| Bookkeeping | Ledger, chart of accounts |
| Invoicing | Invoice generation |
| Tax Exports | Tax-ready reporting |

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
