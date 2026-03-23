# Halava SKU: Staff Accounts

> **Owning service:** Platform
> **Last updated:** March 2026
>
> **Related:**
> - [[pricing/index]] — Full SKU registry
> - [[monetization#3. Billing Model: Halava SKUs]] — Billing model overview
> - [[features/platform/roles-permissions]] — Staff roles and permission model

---

## SKU Definition

| Attribute | Value |
|-----------|-------|
| **Billing unit** | Per active staff account per month |
| **Pricing model** | Fixed monthly rate per account, tiered volume (marginal rate) |
| **Applies to** | All active staff accounts on the merchant's team, excluding the owner |
| **Free tier** | First 2 staff accounts at no charge |

---

## Tiered Rate Table

Tiers apply on a **marginal basis** — each rate applies only to accounts within that tier. Tiers reset on the first day of each calendar month.

| Active staff accounts (excl. owner) | Monthly rate / account |
|--------------------------------------|------------------------|
| 1 – 2 | ¥0 (free tier) |
| 3 – 10 | ¥500 |
| 11+ | ¥300 |

### Monthly Cost Examples

| Merchant type | Staff accounts | Calculation | Monthly fee |
|---------------|----------------|-------------|-------------|
| Solo operator | 0 | Owner only, no staff | **¥0** |
| Food stall | 2 | Within free tier | **¥0** |
| Small shop | 4 | 2×¥0 + 2×¥500 | **¥1,000** |
| Restaurant | 8 | 2×¥0 + 6×¥500 | **¥3,000** |
| Large operation | 15 | 2×¥0 + 8×¥500 + 5×¥300 | **¥5,500** |

---

## What Counts as a Billable Account

| Account type | Billed? |
|--------------|---------|
| Owner account | ❌ No — always free, exactly one per merchant |
| Active staff account | ✅ Yes — if beyond the free tier |
| Invited but not yet accepted | ❌ No — billed from the day the invitation is accepted |
| Suspended staff account | ❌ No — suspended accounts do not consume a billing slot |
| Deleted staff account | ❌ No |

Billing is based on a count of active staff accounts at the start of each day, prorated daily for the month.

---

## Pricing Rationale

### Free tier at 2 staff accounts

2 staff accounts covers the majority of micro-merchants — a food stall owner with one part-timer, a solo shop owner who needs a cashier. These merchants operate at low volume and should not face account fees before they have the throughput to justify them.

### ¥500 per additional account

At ¥500/month per staff account, a restaurant with 8 staff pays ¥3,000/month — well within operational norms for workforce management tooling in Japan. The fee covers access control, role management, activity logging, and per-account session infrastructure.

### Volume discount at 11+ accounts

Larger operations with 11+ staff (multi-location or high-volume restaurants) get a lower marginal rate. At this scale, per-account infrastructure costs are lower due to shared overhead.

---

#halava #business #pricing #sku #platform
