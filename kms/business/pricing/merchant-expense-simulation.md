# Halava Merchant Monthly Expense Simulation

> **Last updated:** March 2026
> **Purpose:** Illustrate realistic monthly Halava fees across three merchant profiles
>
> **Related:**
> - [[pricing/index]] — Full SKU registry
> - [[payment-gateway/transaction-processing]] — Combined order fee rates
> - [[shop/product-listing]] — Product Listing SKU rates
> - [[shop/featured-listings]] — Featured Listings SKU rates
> - [[restaurant-operations/menu-item]] — Menu Item SKU rates
> - [[pos/transaction]] — POS Transaction SKU rates
> - [[platform/staff-accounts]] — Staff Accounts SKU rates

---

## Simulation Context

All three simulations assume **Phase 2** (Halava Pay live via Stripe Connect). The month is a standard 30-day calendar month. Catalog sizes and order volumes are held constant for simplicity — real billing prorates daily snapshots.

**SKU rates used in this simulation:**

| SKU | Rate summary |
|-----|--------------|
| Transaction Processing — Halava Pay | 4% + ¥30/order |
| Transaction Processing — Merchant-Managed | 0.95%–0.4% (tiered) + ¥30/order |
| Transaction Processing — Pay at Pickup | ¥30/order |
| ¥30 free tier | First 50 orders/month (Shop); first 100/month (Restaurant Operations) |
| Product Listing | Free ≤100; ¥10/product/month (101–300); ¥7 (301–700); ¥5 (701+) |
| Menu Item | Free ≤100; ¥8/item/month (101–200); ¥5 (201–400); ¥4 (401+) |
| Featured Listings | ¥500/¥3,000 (category 1d/7d); ¥2,000/¥12,000 (homepage 1d/7d); 10% off bookings 4–10; 20% off 11+ |
| POS Transaction | Free ≤500/month; ¥3 (501–2,000); ¥2 (2,001–5,000); ¥1 (5,001+) |
| Staff Accounts | Free ≤2; ¥500/account (3–10); ¥300 (11+) |

---

## Merchant A — Small Halal Grocery Store

### Profile

A solo-operated halal grocery in Tokyo. Stocks imported Indonesian and Malaysian goods. Has both a small online storefront and a physical counter. One part-time cashier.

**Services active:** Shop, POS, Payment Gateway, Platform

### Monthly Activity

| Activity | Volume | Notes |
|----------|--------|-------|
| Products in catalog | 120 | Stable all month |
| Digital orders — Halava Pay | 35 orders | Avg ¥3,500/order → ¥122,500 GMV |
| Digital orders — Pay at Pickup | 25 orders | Avg ¥1,500/order → ¥37,500 GMV |
| POS walk-in transactions | 600 | Avg ¥1,500/transaction |
| Staff accounts | 1 | 1 cashier; within free tier |
| Featured listing bookings | 0 | — |

### Fee Breakdown

#### Product Listing

| Products | Billable (above free tier of 100) | Rate | Fee |
|----------|----------------------------------|------|-----|
| 120 | 20 | ¥10/product | **¥200** |

#### Transaction Processing — Digital Orders

Total digital orders: 60. Free tier: first 50 orders → ¥30 waived.

| Component | Calculation | Fee |
|-----------|------------|-----|
| ¥30 fixed — orders 1–50 (free tier) | 50 × ¥0 | ¥0 |
| ¥30 fixed — orders 51–60 | 10 × ¥30 | ¥300 |
| % — Halava Pay (35 orders × ¥3,500) | 4% × ¥122,500 | ¥4,900 |
| % — Pay at Pickup | No % component | ¥0 |
| **Transaction Processing subtotal** | | **¥5,200** |

#### POS Transaction

| Walk-ins | Free tier (≤500) | Billable | Rate | Fee |
|----------|-----------------|----------|------|-----|
| 600 | 500 | 100 | ¥3 | **¥300** |

#### Staff Accounts

| Accounts | Free tier (≤2) | Billable | Rate | Fee |
|----------|---------------|----------|------|-----|
| 1 | 1 | 0 | — | **¥0** |

### Monthly Invoice — Merchant A

| SKU | Fee |
|-----|-----|
| Product Listing | ¥200 |
| Transaction Processing | ¥5,200 |
| POS Transaction | ¥300 |
| Staff Accounts | ¥0 |
| **Total** | **¥5,700** |

**Digital GMV:** ¥160,000 (Halava Pay + Pay at Pickup)
**Effective fee rate on digital GMV:** ¥5,200 ÷ ¥160,000 = **3.25%** (transaction fees only)
**All-in effective rate on digital GMV:** ¥5,700 ÷ ¥160,000 = **3.56%**

---

## Merchant B — Warung Makan (Dine-in Restaurant)

### Profile

A 30-seat halal Indonesian restaurant in Osaka. Handles dine-in (QR table ordering), takeaway orders via the Halava app, and walk-in counter service. Six front-of-house and kitchen staff accounts.

**Services active:** Restaurant Operations, POS, Payment Gateway, Platform

### Monthly Activity

| Activity | Volume | Notes |
|----------|--------|-------|
| Menu items in catalog | 90 | Stable all month |
| Digital orders — Halava Pay (QR + app) | 200 orders | Avg ¥2,000/order → ¥400,000 GMV |
| Digital orders — Pay at Pickup | 50 orders | Avg ¥1,500/order → ¥75,000 GMV |
| POS walk-in transactions | 400 | Avg ¥2,000/transaction |
| Staff accounts | 6 | Within tier 3–10 |
| Featured listing bookings | 0 | — |

### Fee Breakdown

#### Menu Item

| Items | Billable (above free tier of 100) | Fee |
|-------|----------------------------------|-----|
| 90 | 0 | **¥0** |

#### Transaction Processing — Digital Orders

Total digital orders: 250. Free tier: first 100 orders (Restaurant Operations) → ¥30 waived.

| Component | Calculation | Fee |
|-----------|------------|-----|
| ¥30 fixed — orders 1–100 (free tier) | 100 × ¥0 | ¥0 |
| ¥30 fixed — orders 101–250 | 150 × ¥30 | ¥4,500 |
| % — Halava Pay (200 orders × ¥2,000) | 4% × ¥400,000 | ¥16,000 |
| % — Pay at Pickup | No % component | ¥0 |
| **Transaction Processing subtotal** | | **¥20,500** |

#### POS Transaction

| Walk-ins | Free tier (≤500) | Billable | Fee |
|----------|-----------------|----------|-----|
| 400 | 400 | 0 | **¥0** |

#### Staff Accounts

| Accounts | Free tier (≤2) | Billable | Rate | Fee |
|----------|---------------|----------|------|-----|
| 6 | 2 | 4 | ¥500 | **¥2,000** |

### Monthly Invoice — Merchant B

| SKU | Fee |
|-----|-----|
| Menu Item | ¥0 |
| Transaction Processing | ¥20,500 |
| POS Transaction | ¥0 |
| Staff Accounts | ¥2,000 |
| **Total** | **¥22,500** |

**Digital GMV:** ¥475,000 (Halava Pay + Pay at Pickup)
**Effective fee rate on digital GMV:** ¥20,500 ÷ ¥475,000 = **4.32%** (transaction fees only)
**All-in effective rate on digital GMV:** ¥22,500 ÷ ¥475,000 = **4.74%**

---

## Merchant C — Halal Imports Online Store (Growing)

### Profile

An established halal food importer selling online through Halava. High-value orders (specialty goods, bulk packs). Accepts both Halava Pay and Merchant-Managed bank transfer (long-standing customers prefer it). Actively promotes seasonal products via Featured Listings. No physical POS. Small team.

**Services active:** Shop, Payment Gateway, Platform

### Monthly Activity

| Activity | Volume | Notes |
|----------|--------|-------|
| Products in catalog | 280 | Stable all month |
| Digital orders — Halava Pay | 130 orders | Avg ¥7,500/order → ¥975,000 GMV |
| Digital orders — Merchant-Managed | 50 orders | Avg ¥15,000/order → ¥750,000 GMV |
| POS walk-in transactions | 0 | Online-only |
| Staff accounts | 4 | 2 billable |
| Featured listing bookings | 6 | 3 category 7-day + 3 category 7-day (at discount) |

### Fee Breakdown

#### Product Listing

| Products | Tier | Rate | Fee |
|----------|------|------|-----|
| First 100 | Free tier | ¥0 | ¥0 |
| 101–280 (180 products) | Tier 2 (101–300) | ¥10/product | ¥1,800 |
| **Product Listing subtotal** | | | **¥1,800** |

#### Transaction Processing — Digital Orders

Total digital orders: 180. Free tier: first 50 orders (Shop) → ¥30 waived.

**¥30 fixed component:**

| Component | Calculation | Fee |
|-----------|------------|-----|
| ¥30 fixed — orders 1–50 (free tier) | 50 × ¥0 | ¥0 |
| ¥30 fixed — orders 51–180 | 130 × ¥30 | ¥3,900 |

**% component:**

| Payment method | GMV | Rate | Fee |
|----------------|-----|------|-----|
| Halava Pay | ¥975,000 | 4.0% flat | ¥39,000 |
| Merchant-Managed: ¥1–¥500,000 | ¥500,000 | 0.95% | ¥4,750 |
| Merchant-Managed: ¥500,001–¥750,000 | ¥250,000 | 0.8% | ¥2,000 |
| **% subtotal** | | | **¥45,750** |

| **Transaction Processing subtotal** | ¥3,900 + ¥45,750 | **¥49,650** |

#### Featured Listings

| Booking | Type | Duration | Standard rate | Discount tier | Rate paid | Fee |
|---------|------|----------|---------------|--------------|-----------|-----|
| 1 | Category search | 7 days | ¥3,000 | Booking 1–3 (0%) | ¥3,000 | ¥3,000 |
| 2 | Category search | 7 days | ¥3,000 | Booking 1–3 (0%) | ¥3,000 | ¥3,000 |
| 3 | Category search | 7 days | ¥3,000 | Booking 1–3 (0%) | ¥3,000 | ¥3,000 |
| 4 | Category search | 7 days | ¥3,000 | Booking 4–10 (10% off) | ¥2,700 | ¥2,700 |
| 5 | Category search | 7 days | ¥3,000 | Booking 4–10 (10% off) | ¥2,700 | ¥2,700 |
| 6 | Category search | 7 days | ¥3,000 | Booking 4–10 (10% off) | ¥2,700 | ¥2,700 |
| **Featured Listings subtotal** | | | | | | **¥17,100** |

#### Staff Accounts

| Accounts | Free tier (≤2) | Billable | Rate | Fee |
|----------|---------------|----------|------|-----|
| 4 | 2 | 2 | ¥500 | **¥1,000** |

### Monthly Invoice — Merchant C

| SKU | Fee |
|-----|-----|
| Product Listing | ¥1,800 |
| Transaction Processing | ¥49,650 |
| Featured Listings | ¥17,100 |
| Staff Accounts | ¥1,000 |
| **Total** | **¥69,550** |

**Digital GMV:** ¥1,725,000 (Halava Pay + Merchant-Managed)
**Effective fee rate on digital GMV (transaction fees only):** ¥49,650 ÷ ¥1,725,000 = **2.88%**
**All-in effective rate on digital GMV:** ¥69,550 ÷ ¥1,725,000 = **4.03%**

> The all-in rate for Merchant C is higher due to Featured Listings spend — this is discretionary promotional investment, not a platform fee on GMV.
> Excluding Featured Listings: ¥52,450 ÷ ¥1,725,000 = **3.04%**

---

## Summary Comparison

| | Merchant A (Grocery) | Merchant B (Restaurant) | Merchant C (Importer) |
|---|---|---|---|
| **Services active** | Shop, POS, Payment Gateway | Restaurant Ops, POS, Payment Gateway | Shop, Payment Gateway |
| **Digital GMV** | ¥160,000 | ¥475,000 | ¥1,725,000 |
| **Total monthly fee** | ¥5,700 | ¥22,500 | ¥69,550 |
| **Transaction fees** | ¥5,200 | ¥20,500 | ¥49,650 |
| **Catalog fees** | ¥200 | ¥0 | ¥1,800 |
| **POS fees** | ¥300 | ¥0 | ¥0 |
| **Staff fees** | ¥0 | ¥2,000 | ¥1,000 |
| **Promotion fees** | ¥0 | ¥0 | ¥17,100 |
| **Effective rate on digital GMV (all-in)** | 3.56% | 4.74% | 4.03% |
| **Effective rate excl. promotions** | 3.56% | 4.74% | 3.04% |

### Key observations

**Free tiers absorb early-stage cost.** Merchant A pays ¥0 in catalog and staff fees entirely due to free tiers. A newer version of Merchant A with only 30 orders/month would pay ¥0 in transaction fixed fees too — only the 4% Halava Pay % would apply.

**Restaurant digital orders drive cost at scale.** Merchant B's ¥20,500 transaction fee is almost entirely the 4% Halava Pay component (¥16,000). The ¥30 fixed adds ¥4,500 once the 100-order free tier is exhausted. Increasing average order value reduces the effective rate.

**Merchant-Managed lowers % cost but not fixed cost.** Merchant C's 50 Merchant-Managed orders (¥750,000 GMV) incur 0.95%–0.8% vs 4% for Halava Pay — saving ~¥23,250 in % fees compared to if all GMV were Halava Pay. The ¥30 fixed is identical regardless of payment method.

**Featured Listings is the largest fee driver for Merchant C** at ¥17,100 — but this is promotional spend that the merchant controls. Without it, Merchant C's effective rate drops to 3.04%.

---

#halava #business #pricing #simulation
