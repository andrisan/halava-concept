# Halava SKU: Transaction Processing

> **Owning service:** Payment Gateway
> **Last updated:** March 2026
>
> **Related:**
> - [[pricing/index]] — Full SKU registry
> - [[monetization#3. Billing Model: Halava SKUs]] — Billing model overview
> - [[monetization#5. Payment Architecture]] — Full payment architecture and category definitions
> - [[merchant-managed-payment]] — Merchant-Managed Payment application flow and lifecycle

---

## SKU Definition

| Attribute | Value |
|-----------|-------|
| **Billing unit** | Percentage of transaction value + fixed ¥30 per order |
| **Pricing model** | Flat % for Halava Pay (Phase 2+); tiered volume % for Merchant-Managed; ¥30 fixed applies to both, and to Pay at Pickup |
| **Applies to** | All digitally-originated orders, with rates varying by payment method |
| **Free tier** | ¥30 fixed component waived for first 50 orders/month (Shop) and first 100 orders/month (Restaurant Operations). % component applies from ¥1 in all phases. |

---

## Combined Order Fee

This section is the canonical reference for order fees. The fee per order combines a **payment processing component** (% of order value) and an **order management component** (¥30 fixed per order).

| Payment method       | Combined fee per order                     | Available  |
| -------------------- | ------------------------------------------ | ---------- |
| **Halava Pay**       | 4% + ¥30                                   | Phase 2+   |
| **Merchant-Managed** | 0.95%–0.4% + ¥30 (% tiered by monthly volume) | All phases |
| **Pay at Pickup**    | ¥30                                        | All phases |

### Free Tier on the ¥30 Component

| Service | Free tier |
|---------|-----------|
| Shop | First 50 orders/month: ¥30 fixed waived. % component applies from ¥1. |
| Restaurant Operations | First 100 orders/month: ¥30 fixed waived. % component applies from ¥1. |

The free-tier threshold differs by service because order frequency differs structurally — a small restaurant generates more orders per month than a small shop. Future services will define their own thresholds at launch.

| Halava Service | Free tier (¥30 waived) |
|----------------|------------------------|
| Shop | First 50 orders/month |
| Restaurant Operations | First 100 orders/month |

---

## Scope

This SKU has two % rate structures depending on how payment is handled. The two-rate model reflects Halava's payment evolution across phases.

**Phase 1 — Merchant-Managed only:** Halava does not hold a 資金移動業 (funds transfer business) license at launch. Intermediating consumer payments is therefore not legally permissible. All digital payment flows through Merchant-Managed: consumers pay merchants directly, and Halava never touches the funds. The Merchant-Managed rate is the only % rate that applies in Phase 1.

**Phase 2+ — Both rates apply:** Halava Pay launches via Stripe Connect. Stripe's regulatory coverage means Halava does not need its own 資金移動業 license. The Halava Pay rate applies to all Halava-processed payments. Merchant-Managed remains available as a permanent "bring your own payment" option.

**Halava Pay rate** applies when the consumer pays via a Halava-managed method (Credit Card, Debit Card, Bank Transfer via Halava, or COD via a Halava-partnered delivery company). Available from Phase 2+.

**Merchant-Managed rate** applies when the merchant handles payment collection outside Halava — bank transfer to the merchant's own account, or COD via the merchant's own delivery contract. Available in all phases. Access is application-gated; see [[merchant-managed-payment]] for the application flow. Order lifecycle is merchant-driven: the merchant manually updates status and tracking through the Halava dashboard; Halava does not intermediate payment or disputes.

**Pay at Pickup** is a fulfilment method — Halava manages the full order lifecycle but does not handle payment. The ¥30 fixed component applies; no % component.

---

## Transaction Fee Model

This section is the canonical reference for transaction processing rates. Links from other documents to `#Transaction Fee Model` resolve here.

Tiers are measured on **combined monthly order volume** (¥) within the calendar month, applied on a **marginal basis** — each rate applies only to the volume within that tier.

### Halava Pay Rate

Applies when the consumer pays via Credit Card, Debit Card, Bank Transfer (via Halava), or COD via a partnered delivery company.

| Monthly volume (¥) | % Rate |
|--------------------|--------|
| All volumes        | 4.0%   |

> **Note:** Halava Pay is a flat rate in Phase 2 (Stripe Connect). Volume tiers will be introduced in Phase 3 when migration to a lower-cost processor (Adyen, KOMOJU, or GMO-PG) makes meaningful discounts sustainable. See [[payment-processors]].

### Merchant-Managed Rate

Applies when the merchant handles settlement directly — bank transfer to the merchant's own account, or COD via the merchant's own delivery contract. Available in all phases.

| Monthly volume (¥) | % Rate |
|--------------------|--------|
| ¥1 – ¥500,000 | 0.95% |
| ¥500,001 – ¥2,000,000 | 0.8% |
| ¥2,000,001 – ¥10,000,000 | 0.6% |
| ¥10,000,001+ | 0.4% |

---

### Monthly Cost Examples

Shop free tier applied (first 50 orders/month: ¥30 waived).

**Halava Pay (4% + ¥30/order):**

| Merchant type | Monthly orders | Avg order value | Monthly GMV | % fee    | Fixed ¥30       | Total fee    |
| ------------- | -------------- | --------------- | ----------- | -------- | --------------- | ------------ |
| New shop      | 30             | ¥3,000          | ¥90,000     | ¥3,600   | ¥0 (free tier)  | **¥3,600**   |
| Small shop    | 80             | ¥3,000          | ¥240,000    | ¥9,600   | 30×¥30=¥900     | **¥10,500**  |
| Growing shop  | 300            | ¥3,500          | ¥1,050,000  | ¥42,000  | 250×¥30=¥7,500  | **¥49,500**  |
| Established   | 800            | ¥5,000          | ¥4,000,000  | ¥160,000 | 750×¥30=¥22,500 | **¥182,500** |

**Merchant-Managed (0.95%–0.4% tiered + ¥30/order):**

| Merchant type | Monthly orders | Avg order value | Monthly GMV | % fee (tiered) | Fixed ¥30 | Total fee |
|---------------|----------------|-----------------|-------------|----------------|-----------|-----------|
| Small shop | 80 | ¥3,000 | ¥240,000 | ¥240k×0.95%=¥2,280 | 30×¥30=¥900 | **¥3,180** |
| Growing shop | 300 | ¥3,500 | ¥1,050,000 | ¥500k×0.95%+¥550k×0.8%=¥9,150 | 250×¥30=¥7,500 | **¥16,650** |
| Established | 800 | ¥5,000 | ¥4,000,000 | ¥500k×0.95%+¥1.5M×0.8%+¥2M×0.6%=¥28,750 | 750×¥30=¥22,500 | **¥51,250** |

**Pay at Pickup (¥30/order only):**

| Merchant type | Monthly orders | Fixed ¥30 | Total fee |
|---------------|----------------|-----------|-----------|
| Small shop | 80 | 30×¥30=¥900 | **¥900** |
| Growing shop | 300 | 250×¥30=¥7,500 | **¥7,500** |

---

## Pricing Rationale

### Halava Pay rate of 4.0% (flat)

Halava's processing rate covers both the underlying payment infrastructure cost and the value-added layer:

| Component           | What it covers                                                          |
| ------------------- | ----------------------------------------------------------------------- |
| Infrastructure cost | Payment network fees, settlement, fraud screening (via Stripe Connect)  |
| Halava value layer  | Buyer protection, dispute intermediation, Halava-managed reconciliation |

4.0% is set above Stripe Connect's underlying cost of 3.6%, ensuring a positive margin (+0.4%) on every transaction at all volumes. The flat structure reflects Phase 2 reality: Stripe's pricing is itself flat, so introducing volume tiers would require subsidising high-volume merchants from lower-tier revenue — which is deferred to Phase 3 when a lower-cost processor makes meaningful discounts sustainable.

Halava remains competitive: BASE charges 3.6% + ¥40/transaction with no marketplace infrastructure; STORES.jp charges 5%; Shopify Japan charges 3.25–3.9% plus a mandatory ¥3,650–¥46,000/month subscription. Halava offers full multi-merchant marketplace infrastructure at 4.0% + ¥30 with no subscription.

### Merchant-Managed rate at ~24% of Halava Pay (first tier)

The 0.95% rate reflects three components:

| Component | What it covers |
|-----------|---------------|
| Operational cost | Order intake, state management, timeout handling, permanent record-keeping |
| Brand risk premium | Halava absorbs reputational exposure on orders it does not control — a consumer who has a bad payment experience will associate it with Halava regardless of any disclaimer |
| Regulatory accommodation | In Phase 1, Merchant-Managed is the only compliant digital payment model available; the rate reflects that Halava bears platform cost and brand exposure even while operating outside the payment flow |

The application gate reduces the probability of a bad actor accessing Merchant-Managed Payment, but residual brand risk remains on every approved merchant's orders. The rate compensates Halava for carrying that exposure.

The gap between 4.0% and 0.95% creates a natural migration incentive: as a merchant's volume grows, the absolute fee difference becomes significant, and the operational benefits of Halava Pay — payment automation, no manual confirmation, dispute intermediation — become compelling on their own. Migration is pull-based, not forced.

### Fixed ¥30 component

The ¥30 fixed fee covers Halava's order management infrastructure — the work Halava performs regardless of payment method:

- Order routing and merchant notification
- Status lifecycle management (placed → confirmed → shipped → fulfilled)
- Consumer notifications at each stage
- Record-keeping and dispute logging

¥30 is set below BASE's ¥40 per-transaction fixed fee while delivering full multi-merchant marketplace infrastructure. It applies to every payment method including Pay at Pickup, where it is the only fee charged (no % component).

### Volume tiers (Phase 3)

Volume-tiered pricing for Halava Pay is deferred to Phase 3. When Halava migrates to a lower-cost processor (Adyen interchange++ or negotiated GMO-PG rates), the underlying cost drops enough to offer meaningful tier discounts — 3.0% or lower at high volume — without running at a loss. Merchants who grow with the platform during Phase 2 will benefit from these reductions when they arrive.

---

## Billing Per Payment Category

| Payment option | ¥30 fixed (waived in free tier) | % component |
|----------------|---------------------------------|-------------|
| **Halava Pay** (CC, Debit, Bank Transfer, COD) | ✅ Applies | ✅ 4.0% |
| **Pay at Pickup** | ✅ Applies | ❌ Does not apply |
| **Merchant-Managed** (Bank Transfer, own COD) | ✅ Applies | ✅ 0.95%–0.4% (tiered) |

---

## Halava Pay Methods

| Method | Settlement |
|--------|------------|
| Credit Card | Authorised and settled via Halava Pay |
| Debit Card | Authorised and settled via Halava Pay |
| Bank Transfer | Consumer transfers to Halava's account; Halava confirms receipt and releases to merchant |
| COD via Delivery Company | Delivery company (e.g., Kuroneko Yamato) collects cash at the door; remits to Halava; Halava settles to merchant |

## Pay at Pickup

| Method | Settlement |
|--------|------------|
| Pay at Pickup | Consumer pays cash in person at collection. Halava manages full order lifecycle. No Halava payment intermediation. |

## Merchant-Managed Payment

| Method | Settlement |
|--------|------------|
| Bank Transfer | Consumer transfers to merchant's own bank account. Merchant confirms manually. |
| COD (merchant's delivery contract) | Merchant's delivery partner (e.g., Kuroneko direct contract) collects cash and remits directly to merchant. |

> **Note:** For Merchant-Managed orders, Halava cannot detect when the consumer has paid — payment confirmation is the merchant's responsibility. Order status updates, shipment tracking, and consumer notifications are available through the Halava dashboard but are merchant-driven (no automation). Halava provides no dispute intermediation. Merchant must opt in and configure this option in their dashboard — it does not appear at checkout unless configured.

---

#halava #business #pricing #sku #payment-gateway
