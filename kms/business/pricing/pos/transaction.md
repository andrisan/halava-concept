# Halava SKU: POS Transaction

> **Owning service:** POS
> **Last updated:** March 2026
>
> **Note:** POS is a shared capability used by both Shop and Restaurant Operations merchants.
>
> **Related:**
> - [[pricing/index]] — Full SKU registry
> - [[monetization#3. Billing Model: Halava SKUs]] — Billing model overview
> - [[pos#UI/UX Specification]] — POS feature specification
> - [[payment-gateway/transaction-processing]] — Applies to digitally-originated orders (mutually exclusive with this SKU)

---

## SKU Definition

| Attribute | Value |
|-----------|-------|
| **Billing unit** | Per walk-in transaction originated at the POS terminal |
| **Pricing model** | Fixed fee per transaction, tiered volume (marginal rate) |
| **Applies to** | Transactions where the order is **created and completed at the POS** with no prior online order |
| **Free tier** | First 500 transactions per month at no charge |

---

## Scope: Walk-in Transactions Only

This SKU applies **only** to transactions that originate at the POS terminal — a customer who walks in and places their order directly at the counter or through the merchant's POS interface.

It does **not** apply when the POS is used to fulfil or collect payment for an order that was already placed online. In that case, the order is already covered by the Transaction Processing combined fee, and billing does not apply twice.

### Order Origin Determines the Billing SKU

| How the order was placed | Billing SKU |
|--------------------------|-------------|
| Customer walks in, orders at POS | **POS Transaction** |
| Customer orders via Halava app or web | **Transaction Processing combined fee** |
| Customer scans QR at table, orders in-app | **Transaction Processing combined fee** |
| Customer orders online, pays / picks up at POS counter | **Transaction Processing combined fee** only — POS Transaction does not additionally apply |

The POS terminal is a fulfillment surface. Whether a merchant uses it to take a new walk-in order or to complete an existing online order, the billing SKU is determined by where the order originated — not where it was paid or fulfilled.

---

## Tiered Rate Table

Tiers apply on a **marginal basis** — each rate applies only to transactions within that tier. Tiers reset on the first day of each calendar month.

| Monthly walk-in POS transactions | Fee per transaction |
|----------------------------------|---------------------|
| 1 – 500 | ¥0 (free tier) |
| 501 – 2,000 | ¥3 |
| 2,001 – 5,000 | ¥2 |
| 5,001+ | ¥1 |

### Monthly Cost Examples

| Merchant type | Monthly walk-in transactions | Calculation | Monthly POS fee |
|---------------|------------------------------|-------------|-----------------|
| Food stall (light) | 300 | Within free tier | **¥0** |
| Food stall (busy) | 800 | 500×¥0 + 300×¥3 | **¥900** |
| Halal grocery | 1,500 | 500×¥0 + 1,000×¥3 | **¥3,000** |
| Small restaurant | 3,000 | 500×¥0 + 1,500×¥3 + 500×¥2 | **¥5,500** |
| Full restaurant | 6,000 | 500×¥0 + 1,500×¥3 + 3,000×¥2 + 500×¥1 | **¥11,000** |

---

## What Counts as a Billable Transaction

| Event | Counts? |
|-------|---------|
| Walk-in sale originated and completed at POS | ✅ Yes |
| Online order paid / collected at POS counter | ❌ No — billed as Transaction Processing combined fee |
| Voided sale (cancelled before completion) | ❌ No |
| Refund / return processed through POS | ❌ No |
| Test transaction | ❌ No |
| Offline walk-in transaction (synced later) | ✅ Yes — counted in the month it was recorded |

---

## Pricing Rationale

### The ¥3 base rate in context

At a typical halal food transaction value of ¥1,500, the ¥3 fee represents **0.2% of transaction value** — well below payment processing fees (2%–3.25%). This covers Halava's operational scope for each POS transaction: inventory sync, unified purchase history, receipt generation, and reporting.

Payment processing (when Halava Pay is used at the POS) is charged separately under [[payment-gateway/transaction-processing]].

### Free tier at 500 transactions

500 walk-in transactions/month (~17/day) covers the majority of micro-merchants — food stalls, pop-up shops, occasional in-store sellers — entirely at no cost.

---

## Competitive Context

| What competitors bundle | Halava separates into |
|-------------------------|-----------------------|
| Software: ¥0 | POS Transaction SKU (this file) |
| Card processing: 2.6% + ¥15/tx | [[payment-gateway/transaction-processing]] SKU |

A merchant using Halava POS with cash payments pays only the POS Transaction fee — significantly cheaper than competitors whose bundled card-processing fees apply to every transaction.

---

#halava #business #pricing #sku #pos
