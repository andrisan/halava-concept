# Halava Monetization & Pricing Strategy

> **Last updated:** March 2026
> **Target market:** Japan (currency: Japanese Yen ¥)
>
> **Related documents:**
> - [[pricing/index]] — Halava SKU registry (per-service pricing files)
> - [[web-app-spec]] — Detailed product specification
> - [[pitch-deck]] — Investor presentation (uses this document as source of truth for pricing)
> - [[risk-assessment]] — Financial risks and mitigations

---

## 1. Product & Market Context

Halava is a **two-sided halal commerce platform** with a strong consumer-first approach:
- **Consumers** use Halava to discover halal products, enjoy unique features (finance management, halal place discovery, convenience), and coordinate group purchases.
- **Merchants** join Halava to access a customer base, gain powerful business management tools, enhanced online presence, and operational efficiency.

Key characteristics:
- **Halal trust as foundation**
- **Consumer utility drives demand**
- **Merchant digital empowerment**
- **Fair, success-aligned pricing**
- **Low-friction accessibility**

### 1.1 Primary Target: Indonesian Diaspora in Japan

**Market data (Source: Embassy of Indonesia, 2026):**
- **230,689** Indonesian nationals residing in Japan
- **37.2% year-over-year growth** — fastest-growing foreign community
- High concentration in Greater Tokyo, Kansai, and Chubu regions

Indonesians represent the ideal early adopter segment:
- Strong halal dietary observance
- Active community networks (group purchase potential)
- Underserved by existing platforms
- High smartphone and digital payment adoption

### 1.2 Revenue Potential Illustration

> **Note:** Illustration will be revised once SKU rates are finalized. The table below reflects the prior flat-rate model and is retained for order-of-magnitude reference only.

**Assumptions (prior model, for reference):**
- Average monthly halal food spending per person: **¥10,000** (groceries + dining)
- Effective blended rate: **~5%** (Phase 2 approximation)

| Adoption Rate | Active Users | Monthly GMV | Monthly Fee Revenue (est.) | Annual Fee Revenue (est.) |
|---------------|--------------|-------------|---------------------------|--------------------------|
| 1% | 2,307 | ¥23.1M | ¥1.15M | ¥13.8M |
| 5% | 11,534 | ¥115.3M | ¥5.77M | ¥69.2M |
| 10% | 23,069 | ¥230.7M | ¥11.53M | ¥138.4M |
| 20% | 46,138 | ¥461.4M | ¥23.07M | ¥276.8M |

> **Note:** This excludes POS transactions, staff account fees, and non-Indonesian users. Actual revenue will be higher with multi-segment adoption.

---

## 2. Core Monetization Philosophy

### Platform Model

Halava is designed as a **full-suite business platform for halal merchants** — not a marketplace merchants join as a side channel, but the central operating system they run their business on. The model is deliberately analogous to a cloud platform provider:

- Merchants register once and **activate the capabilities they need**: Shop, Restaurant Operations, POS, Directory, Staff Accounts, and more
- Each capability is independent — a restaurant activates Restaurant Ops; a retailer activates Shop; a hybrid business activates both
- There is no business type selection at registration and no fixed configuration — the platform adapts to the merchant
- As the merchant grows, they activate more capabilities and generate more revenue for Halava naturally

This model creates deep merchant stickiness (high switching cost when the whole business runs on Halava), strong revenue per merchant (multiple SKUs activate over time), and direct alignment between merchant success and platform success.

### Billing Model

All Halava fees are **consumption-based** — merchants pay only for what they use, across independently priced SKUs per Halava Service. There are no membership tiers, no plan gates, and no fixed monthly subscription fees.

Guiding principles:
- No paywalls on core selling functionality
- Merchants can use Halava at no cost up to defined free tier thresholds per SKU
- No quotas on any transaction type — all volume is metered, not capped
- No opportunity loss on high-GMV merchants
- Pricing must be explainable in under 10 seconds

---

## 3. Billing Model: Halava SKUs

### 3.1 Structure

Halava uses a **consumption-based pricing model** built around commerce-native billing units. The hierarchy is:

```
Halava Service
  └── Halava SKU
        └── Price definition (unit type, tiers, rate per unit)
```

- A **Halava Service** is a product area (e.g., Shop, Restaurant Operations, Payment Gateway).
- A **Halava SKU** is a billable unit owned by a specific service. Each SKU has its own independent price definition.
- **SKU** is used intentionally as a unit-agnostic term — it handles varied pricing models (per transaction, per listing, per % of value, per month, etc.) with a consistent structure.

> **Context separation:** Product SKUs live in the merchant's Shop. Billing SKUs live in the Billing section. Merchants familiar with "SKU" from their own catalogs will encounter the term in both places, but the context makes the distinction clear.

### 3.2 Tiered Volume Pricing

Each SKU uses **tiered volume pricing**: the more a merchant uses, the lower the per-unit rate.

- Tiers apply on a **marginal basis** (tax-bracket style) — no cliff penalties
- Tiers reset monthly
- Lower rates reward high-volume merchants without penalizing them at tier boundaries

**Example (illustrative — actual rates TBD):**

| Monthly transactions | Per-transaction fee |
|---------------------|---------------------|
| 1 – 100 | ¥X per order |
| 101 – 500 | ¥Y per order |
| 501+ | ¥Z per order |

### 3.3 Free Tier

Most SKUs include a **free tier** — a defined usage threshold below which no charge applies. Merchants can operate on Halava at no cost until they exceed free tier limits across their active SKUs.

Free tier thresholds are defined per SKU and reviewed periodically as the platform scales.

> **Exception:** The Transaction Processing % component has no free tier — payment processing incurs real marginal cost from the first yen. The ¥30 fixed component (Basic Digital Order Fee) is waived in the free tier for each service. See [[payment-gateway/transaction-processing]].

---

## 4. Halava SKUs

Pricing details for each SKU live in dedicated files, grouped by service. See [[pricing/index]] for the full registry.

| Halava Service | SKU | File |
|----------------|-----|------|
| Shop | Product Listing | [[shop/product-listing]] |
| Shop | Featured Listings | [[shop/featured-listings]] |
| Restaurant Operations | Menu Item | [[restaurant-operations/menu-item]] |
| Payment Gateway | Transaction Processing (incl. ¥30 order fee) | [[payment-gateway/transaction-processing]] |
| POS | POS Transaction | [[pos/transaction]] |
| Platform | Staff Accounts | [[platform/staff-accounts]] |

---

## 5. Payment Architecture

### 5.1 Payment Option Categories

Halava has three payment option categories. What appears at consumer checkout depends on the merchant's configuration and the current platform phase.

#### Halava Pay

Halava manages the full payment flow — authorisation, settlement, buyer protection, dispute intermediation. Available from Phase 2+ onwards. Halava controls this group; merchants cannot disable it.

| Method | Who collects | Notes |
|--------|-------------|-------|
| Credit Card | Halava | Processed via Halava Pay |
| Debit Card | Halava | Processed via Halava Pay |
| Bank Transfer | Halava | Consumer transfers to Halava's account; Halava confirms and releases to merchant |
| COD via Delivery Company | Halava's delivery partner | e.g., Kuroneko Yamato 代金引換 — remits to Halava; Halava settles to merchant |

Halava manages the complete order lifecycle for all Halava Pay orders — status updates, notifications, and dispute intermediation are automated.

#### Pay at Pickup

A fulfilment method, not a payment method. The consumer places a digital order and pays cash in person when collecting at the merchant's location. Halava manages the full order lifecycle (status updates, notifications) but does not handle the payment.

Merchants can enable or disable Pay at Pickup in their dashboard. Available in all phases.

#### Merchant-Managed Payment

The merchant handles payment collection outside Halava. Halava records the order, notifies the merchant at placement, and provides the same order management tools as Halava Pay — status updates, tracking number input, and consumer notifications — but payment confirmation and payment-triggered status changes must be handled manually by the merchant. Halava does not intermediate payment or disputes.

**This is the primary payment option in Phase 1 for a regulatory reason.** Intermediating consumer payments — collecting funds and remitting to merchants — requires a 資金移動業 (funds transfer business) license from Japan's FSA. Halava will not hold this license at initial launch. Merchant-Managed Payment allows merchants to collect payment directly (consumer to merchant), keeping Halava outside the money flow and within regulatory compliance.

In Phase 2+, when Halava Pay becomes available via a licensed payment partner, Merchant-Managed Payment remains as a permanent **"bring your own payment"** option for merchants who have existing payment infrastructure they wish to keep — analogous to using your own DNS or storage provider on a cloud platform, rather than the native service.

**This is an application-gated feature.** Merchants cannot self-enable it — each application is reviewed and approved by Halava individually. Any registered merchant can apply; Halava decides case-by-case based on submitted documentation. See [[merchant-managed-payment]] for the full application flow.

| Method | Who collects | Merchant configures |
|--------|-------------|---------------------|
| Bank Transfer | Merchant | Bank name, branch, account number, account name — must match business registration |
| COD (own delivery contract) | Merchant's delivery partner | Declares active delivery contract (e.g., Kuroneko direct) — requires proof of contract |

### 5.2 What Appears at Checkout

Consumer checkout shows only the payment options the merchant has configured, plus Halava Pay in Phase 2+.

| Payment group | Controlled by | Phase 1 | Phase 2+ |
|---------------|--------------|---------|----------|
| Halava Pay | Halava — always shown if available | ❌ Not yet available | ✅ Always shown |
| Pay at Pickup | Merchant opt-in | ✅ If enabled | ✅ If enabled |
| Merchant-Managed Payment | Merchant opt-in + setup | ✅ If configured | ✅ If configured |

A merchant who has configured all three groups will show all three at checkout. A merchant who has not configured Merchant-Managed Payment will not show it. A merchant with only Pay at Pickup in Phase 1 will show only Pay at Pickup.

### 5.3 Billing Per Payment Option

| Payment option | Combined fee per order |
|----------------|------------------------|
| **Halava Pay** (CC, Debit, Bank Transfer, COD) | 4% + ¥30 |
| **Pay at Pickup** | ¥30 only |
| **Merchant-Managed** (Bank Transfer, own COD) | 0.95%–0.4% + ¥30 |

The combined fee bundles the Basic Digital Order Fee (¥30 fixed) and the Transaction Processing (% component) into a single merchant-facing rate. The ¥30 is waived in the free tier (first 50 orders/month for Shop; first 100/month for Restaurant Operations). See [[payment-gateway/transaction-processing]] for the canonical rate reference and monthly cost examples.

### 5.4 Payment Method Selection

Within the options the merchant has enabled, the payment method is **selected by the consumer at checkout**.

- Merchants configure which payment groups appear (Merchant-Managed and Pay at Pickup are opt-in)
- Halava Pay is always shown in Phase 2+ regardless of merchant preference — Halava controls this group
- Within each group, consumers choose freely
- Payment method records are **immutable** — set by consumer action, not merchant input

---

## 6. Consumer Checkout Design & Trust

### 6.1 Phase 1 Checkout

In Phase 1, Halava Pay is not available. The checkout shows only what the merchant has configured.

```
[ Bank Transfer ] [ COD ]                  [ Pay at Pickup ]
 ←── Merchant-Managed Payment (if set up) ──►    ←── Fulfilment ──►
```

If the merchant has not configured Merchant-Managed Payment, that group does not appear. If the merchant has not enabled Pay at Pickup, that group does not appear. A merchant with neither configured will not have a functioning checkout in Phase 1.

**Merchant-Managed Payment group:**
> *"Payment is handled directly with the merchant. Order updates depend on the merchant updating your order status."*

**Pay at Pickup:**
> *"Place your order now and pay cash when you collect. Your order is tracked by Halava."*

For Merchant-Managed orders, payment confirmation is not automated — Halava cannot detect when the consumer has paid, so the merchant must confirm payment and drive subsequent status updates manually through the dashboard. Fulfillment steps (status, tracking, notifications) work the same as any order type. Pay at Pickup and Halava Pay order lifecycles are fully automated by Halava.

### 6.2 Phase 2+ Checkout

In Phase 2+, Halava Pay is live and always shown. The checkout shows up to three groups depending on what the merchant has configured:

```
[ CC ] [ Debit ] [ Bank Transfer ] [ COD ]    [ Bank Transfer ] [ COD ]    [ Pay at Pickup ]
 ←──────────── Halava Pay ────────────────►    ←── Merchant-Managed ──────►    ←── Fulfilment ──►
```

Halava Pay is always present — Halava controls this group regardless of merchant preference. Merchant-Managed Payment and Pay at Pickup appear only if the merchant has configured them.

**Halava Pay group:**
> *"Payment secured by Halava. Eligible for dispute resolution and buyer protection."*

**Merchant-Managed Payment group:**
> *"Payment is handled directly with the merchant. Order updates depend on the merchant updating your order status."*

**Pay at Pickup:**
> *"Place your order now and pay cash when you collect. Your order is tracked by Halava."*

Halava Pay and Pay at Pickup order lifecycles are fully automated. For Merchant-Managed orders, the merchant manually drives updates — status changes, tracking, and notifications — through the Halava dashboard.

### 6.3 Design Principles (Both Phases)

- **Value-based framing, not fear-based warnings** — the Halava Pay message leads with protection and benefit, not risk.
- **Halava does not imply the merchant is untrustworthy** for Merchant-Managed orders — the messaging states Halava's limited role without casting doubt on merchant integrity.
- Info icon (ⓘ) appears at the group level only — not repeated on each individual payment method.
- Pay at Pickup is presented as a fulfilment choice, not a lesser option — the order is fully tracked in both phases.

---

## 7. Merchant Payment Strategy

Halava's approach to growing gateway revenue is structurally embedded in the product, not driven by sales messaging.

### 7.1 Merchant-Managed Payment as a Permanent Compatibility Layer

Merchant-Managed Payment is designed for established merchants who already have their own payment infrastructure — direct bank accounts, existing delivery contracts (e.g., Kuroneko 直契約), and proven operational workflows. These merchants want to join Halava for consumer reach without restructuring their payment stack.

Access is **application-gated**: any registered merchant can apply, and Halava decides case-by-case. This protects Halava's brand — a consumer who has a poor experience with a merchant's payment handling will associate that experience with Halava regardless of any disclaimer. The application process ensures that Halava has verified the merchant's identity and infrastructure before they are shown to consumers as a payment option.

Halava earns on every Merchant-Managed order via the Transaction Processing (Merchant-Managed rate), covering the real cost of order intake, state management, and record-keeping regardless of payment method.

### 7.2 Organic Discovery of Halava Pay Value

Merchants discover the value of Halava Pay through their own operational experience, not through sales pitches. As order volume grows, the cost of managing Merchant-Managed payments — manual bank transfer confirmation, chasing consumer transfers, no automated order updates, no dispute intermediation — becomes increasingly burdensome. The migration to Halava Pay feels like relief, not obligation.

Merchants are never forced to switch. The operational friction of Merchant-Managed at scale creates a natural pull toward Halava Pay when they're ready.

### 7.3 Consumer Incentives Drive Halava Pay Adoption

Gateway revenue growth is ultimately a **consumer product problem**. Consumer incentives — buyer protection, cashback, loyalty programs, seamless checkout — naturally drive adoption of Halava Pay. Merchants benefit when their customers prefer Halava Pay: Halava manages the full order lifecycle, eliminating manual workload entirely.

### 7.4 Structural Revenue Protection

Gateway revenue is structurally protected:
- Halava controls which payment options appear at checkout
- Merchants cannot suppress or reorder Halava Pay options in Phase 2+
- Halava Pay is always shown once available — consumer preference for it translates directly to gateway revenue without any merchant action required
- Merchant-Managed remains available for merchants who need it; its operational limitations naturally push volume toward Halava Pay as merchants scale

---

## 8. Early Adopter Program

Early adopters (Phase 1 merchants) receive a pricing discount and direct input into product development.

### Pricing Discount

Early adopters receive a discounted rate on all usage-based fees for a fixed term, locked in at onboarding. Specific discount percentages and lock-in periods are set per cohort at the time of onboarding and are not published here — this section records the program structure only.

### Feature Development Partnership

| Benefit | Description |
|---------|-------------|
| **Feature request priority** | Submit feature requests with guaranteed review |
| **Direct communication** | Dedicated channel to development team (LINE/Discord) |
| **Beta access** | First access to new features before general release |
| **Feedback sessions** | Monthly calls to discuss pain points and roadmap |
| **Custom development** | Consideration for business-critical features (case-by-case) |

> **Why this matters for Halava:**
> - Real-world validation of feature priorities
> - Organic roadmap expansion based on actual merchant needs
> - Stronger retention through product co-ownership
> - Early adopters become advocates, not just users

This is a **trade exchange**: merchants get discounted pricing + product influence, Halava gets committed feedback partners + feature validation.

---

## 9. Billing Implementation by Phase

**Phase 1 (Honor-based):**
- All usage fees invoiced monthly
- Merchants self-report or Halava tallies from platform data
- Honor-based collection; formal enforcement begins Phase 2

**Phase 2+ (Halava Pay integration):**
- For Halava Pay orders: the combined order fee (4% + ¥30) is auto-deducted at source
- Listing fees, staff account fees, and Merchant-Managed order fees invoiced monthly at month end

---

## 10. Refund & Cancellation Policy

### Phase 1 — MVP
- Refunds handled directly between consumer and merchant
- Halava provides mediation services

### Phase 2 — Halava Pay integration
- Platform fee refunded proportionally
- Gateway fees not refundable (industry standard)
- Consumer protection via Halava buyer protection

---

## 11. CAC Strategy

### Merchant CAC
- B2B halal supplier network
- In-store promotion kits (QR posters, counter displays)

### Consumer CAC
- Group purchase sharing (forced virality)
- In-store QR exposure
- SEO & utility-driven discovery
- Paid marketing only after retention is proven

---

## 12. Investment Staging & Co-Founder Equity Structure

> See [[risk-assessment#Financial Risks]] for runway scenarios.

**Overall structure:**
- **Total capital invested:** ¥15M across 3 stages
- **Total equity distribution:** Co-founder 40%, Operating Founder 60% (final)

### Stage 1 — Validation Stage (¥3M)
- Equity: Operating Founder 90%, Co-founder 10%
- 7-month runway
- 5-10 pilot merchants

### Stage 2 — Traction Stage (¥5M)
- Equity: Operating Founder 75%, Co-founder 25%
- 15-25 active merchants, ¥5M+ monthly GMV

### Stage 3 — Commitment Stage (¥7M)
- Equity: Operating Founder 60%, Co-founder 40%
- 50+ merchants, ¥10M+ monthly GMV
- Phase 2 Halava Pay integration

---

## 13. Competitive Benchmarking

| Platform | Transaction Fee | Subscription Model |
|----------|-----------------|-------------------|
| **Halava** | Basic Digital Order Fee (flat/trx) + 4.0% Halava Pay (flat) + per-SKU usage fees | No subscription — pay only what you use |
| **BASE (Japan)** | 3.6% + 40¥ | ¥0 (free plan) |
| **STORES.jp** | 5% | ¥0–¥2,178/mo |
| **Shopify Japan** | 3.25–3.9% + gateway | ¥3,650–¥46,000/mo |
| **UberEats** | 30–35% | N/A |

---

#halava #business #monetization #pricing
