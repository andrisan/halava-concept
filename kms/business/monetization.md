# Halava Monetization & Pricing Strategy

> **Last updated:** February 2026
> **Target market:** Japan (currency: Japanese Yen ¥)
>
> **Related documents:**
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

---

## 2. Core Monetization Philosophy

**Separation of concerns (very important):**

- **Transaction fees** monetize *volume and success* (gradual, scalable, no caps)
- **Membership plans** monetize *features and operational value*, not volume

Guiding principles:
- No paywalls on core selling functionality
- No quotas on revenue-generating transactions
- POS quotas are acceptable (operational tool, not revenue channel)
- No opportunity loss on high-GMV merchants
- Pricing must be explainable in under 10 seconds

---

## 3. Transaction Fee Model (Gradual Pricing)

Transaction fees apply to **all merchants** for **online orders**, regardless of plan.

### Phase 1 — MVP (Manual Payment Verification)

| Monthly GMV | Transaction Fee |
|------------|-----------------|
| ¥0 – ¥300k | 2.0% |
| ¥300k – ¥1M | 1.8% |
| ¥1M – ¥3M | 1.6% |
| ¥3M+ | 1.4% (or negotiated) |

### Phase 2+ — Payment Provider Integration

| Monthly GMV | Transaction Fee |
|------------|-----------------|
| ¥0 – ¥300k | 5.0% |
| ¥300k – ¥1M | 4.5% |
| ¥1M – ¥3M | 4.0% |
| ¥3M – ¥10M | 3.0% |
| ¥10M+ | 2.5% (or negotiated) |

### 3.1 Transaction Fee Scope

**Phase 1 — MVP (off-platform settlement):**
- Online marketplace orders: Honor-based monthly invoicing
- POS transactions: Not subject to transaction fees

**Phase 2 — Payment provider integration:**
- Online marketplace orders: Automatically deducted at source via connected-accounts model (Stripe Connect, PAY.JP)

### 3.2 GMV Tier Calculation

- **Period:** Monthly calendar period
- **Rate application:** **Marginal rate** (tax-bracket style)

**Example:** A merchant with ¥500k monthly GMV pays:
- 5% × ¥300k = ¥15,000
- 4.5% × ¥200k = ¥9,000
- **Total: ¥24,000**

---

## 4. Membership Plans (Features + POS Quota)

Membership plans **do not affect transaction fee rates** for online orders.

### Early Adopter Pricing Strategy

- **Phase 1 (MVP):** 50% discount on all paid plans — locked in for 5 years
- **Phase 2:** 25% discount for new merchants
- **Phase 3+:** Full pricing applies

### Free Plan (Default)
- Monthly fee: ¥0
- Unlimited product uploads
- Online & group purchase (transaction fees apply)
- **POS: 300 transactions/month**

### Growth Plan
- Monthly fee: **¥6,000** (waived when monthly transaction fees ≥ ¥6,000)
  - *Phase 1 early adopter price: ¥3,000*
- **POS: 3,000 transactions/month**
- Advanced promotions, analytics, 5 staff accounts

### Pro Plan
- Monthly fee: **¥18,000** (waived when monthly transaction fees ≥ ¥18,000)
  - *Phase 1 early adopter price: ¥9,000*
- **POS: Unlimited transactions**
- Full analytics, 16 staff roles, featured placement

### 4.1 POS Transaction Top-ups

| Pack | Transactions | Price | Per-transaction |
|------|--------------|-------|-----------------|
| Small | 100 | ¥300 | ¥3.0 |
| Medium | 300 | ¥750 | ¥2.5 |
| Large | 500 | ¥1,000 | ¥2.0 |

**Top-up rules:**
- Monthly expiry (no rollover)
- Hard cap with 5-transaction grace buffer (auto-billed at ¥75)
- Auto top-up available (opt-in)

> See [[pos#UI/UX Specification]] for quota UI implementation.

---

## 5. Membership Fee Waiver Logic

**Monthly charge logic:**
```
Merchant pays = MAX(
  membership_fee,
  transaction_fee_for_the_month
)
```

**Example (Growth Plan — ¥6,000):**
- Break-even GMV: ¥120,000 (¥120,000 × 5% = ¥6,000)

---

## 6. Refund & Cancellation Policy

### Phase 1 — MVP
- Refunds handled directly between consumer and merchant
- Halava provides mediation services

### Phase 2 — Payment provider integration
- Platform fee refunded proportionally
- Gateway fees not refundable (industry standard)
- Consumer protection via provider's buyer protection

---

## 7. CAC Strategy

### Merchant CAC
- B2B halal supplier network
- In-store promotion kits (QR posters, counter displays)

### Consumer CAC
- Group purchase sharing (forced virality)
- In-store QR exposure
- SEO & utility-driven discovery
- Paid marketing only after retention is proven

---

## 8. Investment Staging & Co-Founder Equity Structure

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
- Phase 2 payment provider integration

---

## 9. Competitive Benchmarking

| Platform | Transaction Fee | Subscription Model |
|----------|-----------------|-------------------|
| **Halava** | 2.5–5% (GMV-based) | ¥0–¥18,000/mo (waivable) |
| **BASE (Japan)** | 3.6% + 40¥ | ¥0 (free plan) |
| **STORES.jp** | 5% | ¥0–¥2,178/mo |
| **Shopify Japan** | 3.25–3.9% + gateway | ¥3,650–¥46,000/mo |
| **UberEats** | 30–35% | N/A |

---

#halava #business #monetization #pricing
