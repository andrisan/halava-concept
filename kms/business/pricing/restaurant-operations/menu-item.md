# Halava SKU: Menu Item

> **Owning service:** Restaurant Operations
> **Last updated:** March 2026
>
> **Related:**
> - [[pricing/index]] — Full SKU registry
> - [[monetization#3. Billing Model: Halava SKUs]] — Billing model overview
> - [[restaurant-ops]] — Restaurant Operations feature
> - [[shop/product-listing]] — Equivalent SKU for the Shop service

---

## SKU Definition

| Attribute | Value |
|-----------|-------|
| **Billing unit** | Per menu item in catalog per month |
| **Pricing model** | Fixed monthly rate per item, tiered volume (marginal rate) |
| **Applies to** | All menu items in the restaurant's catalog, regardless of status |
| **Free tier** | First 100 menu items at no charge |

---

## Tiered Rate Table

Rates are expressed as a monthly equivalent and prorated to a **daily rate** for exact billing. Tiers apply on a **marginal basis** — each rate applies only to items within that tier on a given day.

| Menu items in catalog | Monthly rate / item | Daily rate / item |
|-----------------------|---------------------|-------------------|
| 1 – 100 | ¥0 (free tier) | ¥0 |
| 101 – 200 | ¥8 | ¥0.27 |
| 201 – 400 | ¥5 | ¥0.17 |
| 401+ | ¥4 | ¥0.13 |

### Monthly Cost Examples (30-day month, stable catalog)

| Restaurant type | Total items | Daily charge | Monthly fee |
|-----------------|-------------|--------------|-------------|
| Small café | 40 | ¥0 | **¥0** |
| Standard halal restaurant | 80 | ¥0 | **¥0** |
| Full menu restaurant | 150 | ¥13.50 | **~¥410** |
| Large multi-section menu | 300 | ¥26.70 | **~¥800** |

> Monthly totals rounded to the nearest ¥10 on invoice.

---

## All Menu Items Are Billed, Regardless of Status

Every menu item stored in Halava's system incurs storage and catalog maintenance costs.

| Status | Billed? |
|--------|---------|
| Active (published, visible to consumers) | ✅ Yes |
| Draft | ✅ Yes |
| Archived | ✅ Yes |
| Temporarily unavailable (86'd / sold out today) | ✅ Yes — item remains in catalog |
| Deleted | ❌ No — removed entirely |

Modifiers and variants (e.g., size options, add-ons) do not count as separate billable items — only the parent menu item is counted.

---

## Billing Measurement: Daily Snapshot

Billing is based on a **midnight snapshot of the menu item count each day**. Each day is billed independently at the daily-prorated rate. The monthly invoice is the sum of all daily charges.

This is exact — not an average, not a snapshot of one day. A restaurant that adds seasonal items for part of the month is billed precisely for the days those items existed in the catalog.

---

## Pricing Rationale

### Why bill all items, not just active ones

Menu items marked unavailable, seasonal items in draft, and archived historical items all occupy database records and contribute to catalog maintenance. Billing only published items would create incentives to archive large menu sections purely to reduce billing count.

### Free tier at 100 items

100 items covers the full menu of the vast majority of halal restaurants — most have between 20 and 80 items. Nearly all restaurants will never pay this fee. The free tier is set at 100 (rather than a smaller number) because it now covers the full catalog including drafts and seasonal items not currently on the menu.

### Lower rates than Shop

Restaurant menus are typically much smaller than product catalogs. The ¥8 base rate reflects this — a restaurant with 150 total items pays ¥400/month, negligible relative to per-table revenue.

---

#halava #business #pricing #sku #restaurant-operations
