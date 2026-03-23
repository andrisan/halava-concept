# Halava SKU: Product Listing

> **Owning service:** Shop
> **Last updated:** March 2026
>
> **Related:**
> - [[pricing/index]] — Full SKU registry
> - [[monetization#3. Billing Model: Halava SKUs]] — Billing model overview
> - [[products]] — Product management feature
> - [[restaurant-operations/menu-item]] — Equivalent SKU for the Restaurant Operations service

---

## SKU Definition

| Attribute | Value |
|-----------|-------|
| **Billing unit** | Per product in catalog per month |
| **Pricing model** | Fixed monthly rate per product, tiered volume (marginal rate) |
| **Applies to** | All products in the merchant's catalog, regardless of status |
| **Free tier** | First 100 products at no charge |

---

## Tiered Rate Table

Rates are expressed as a monthly equivalent and prorated to a **daily rate** for exact billing. Tiers apply on a **marginal basis** — each rate applies only to the products within that tier on a given day.

| Products in catalog | Monthly rate / product | Daily rate / product |
|---------------------|------------------------|----------------------|
| 1 – 100 | ¥0 (free tier) | ¥0 |
| 101 – 300 | ¥10 | ¥0.33 |
| 301 – 700 | ¥7 | ¥0.23 |
| 701+ | ¥5 | ¥0.17 |

### Monthly Cost Examples (30-day month, stable catalog)

| Merchant type | Total products | Daily charge | Monthly fee |
|---------------|----------------|--------------|-------------|
| Small halal shop | 60 | ¥0 | **¥0** |
| Grocery (core range) | 200 | ¥3.30 | **¥99** → ~**¥100** |
| Mid-size importer | 500 | ¥11.29 | **¥339** → ~**¥340** |
| Large distributor | 900 | ¥24.95 | **¥749** → ~**¥750** |

> Monthly totals rounded to the nearest ¥10 on invoice.

---

## All Products Are Billed, Regardless of Status

Every product stored in Halava's system incurs infrastructure costs: database storage, backup, data integrity checks, and association maintenance (order history, inventory records). The billing unit covers the full catalog.

| Status | Billed? |
|--------|---------|
| Active (published, visible to consumers) | ✅ Yes |
| Draft | ✅ Yes |
| Archived | ✅ Yes |
| Deleted | ❌ No — removed from catalog entirely |

Merchants who want to reduce their billable product count should **delete** products they no longer need, not archive or unpublish them.

---

## Billing Measurement: Daily Snapshot

Billing is based on a **midnight snapshot of the product count each day**. Each day is billed independently at the daily-prorated rate. The monthly invoice is the sum of all daily charges.

This is exact — not an average, not a snapshot of one day. A merchant who adds or removes products mid-month is billed precisely for the days they had those products.

**Example:** A merchant has 150 products for the first 20 days, then adds 50 more for the remaining 10 days of a 30-day month.

| Period | Product count | Billable above free tier (100) | Daily charge |
|--------|--------------|-------------------------------|--------------|
| Days 1–20 | 150 | 50 in tier 1 | 50 × ¥0.33 = ¥16.50 |
| Days 21–30 | 200 | 100 in tier 1 | 100 × ¥0.33 = ¥33.00 |

- Total: (20 × ¥16.50) + (10 × ¥33.00) = ¥330 + ¥330 = **¥660**

---

## Pricing Rationale

### Why bill all products, not just active ones

Storage, backup, and catalog integrity costs apply to every product record. Drafts and archived products with historical order associations consume real resources. Billing only active listings would reward merchants for accumulating large inactive catalogs at no cost, and create incentives to toggle listing status purely for billing reasons.

### Free tier at 100 products

100 products is larger than an active-only model would need to be, because it now covers the full catalog including drafts and archived items. Most small merchants — a halal grocery stocking core imports, a food seller's complete range — will never pay this fee.

### Lower rates reflect the blended cost of active and inactive products

The ¥10 base rate is lower than an active-listing-only model because not every product is being indexed and served to consumers in real time. The rate reflects blended storage and serving costs across the full range of product states.

---

#halava #business #pricing #sku #shop
