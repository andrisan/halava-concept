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

**Assumptions:**
- Average monthly halal food spending per person: **¥10,000** (groceries + dining)
- Transaction fee rate: **5%** (Phase 2, entry tier)

| Adoption Rate | Active Users | Monthly GMV | Monthly Trx Fee Revenue | Annual Trx Fee Revenue |
|---------------|--------------|-------------|-------------------------|------------------------|
| 1% | 2,307 | ¥23.1M | ¥1.15M | ¥13.8M |
| 5% | 11,534 | ¥115.3M | ¥5.77M | ¥69.2M |
| 10% | 23,069 | ¥230.7M | ¥11.53M | ¥138.4M |
| 20% | 46,138 | ¥461.4M | ¥23.07M | ¥276.8M |

> **Note:** This excludes POS transactions, membership fees, and non-Indonesian users. Actual revenue will be higher with multi-segment adoption.

**Conservative scenario (5% adoption):**
- ¥115M monthly GMV from Indonesian diaspora alone
- ¥5.77M monthly transaction fee revenue
- Validates unit economics before expansion to other segments

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

### Early Adopter Program

**Pricing benefits:**
- **Phase 1 (MVP):** 50% discount on all paid plans — locked in for 5 years
- **Phase 2:** 25% discount for new merchants
- **Phase 3+:** Full pricing applies

**Feature development partnership:**

Early adopters (Phase 1 merchants) receive direct input into product development:

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

### Free Plan (Default)
- Monthly fee: ¥0
- Unlimited product uploads
- Online & group purchase (transaction fees apply)
- **POS: 300 transactions/month**
- 2 staff accounts

### Growth Plan
- Monthly fee: **¥6,000** (waived when monthly transaction fees ≥ ¥6,000)
  - *Phase 1 early adopter price: ¥3,000*
- **POS: 3,000 transactions/month**
- 5 staff accounts
- Advanced promotions and analytics

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

### 5.1 Automatic Waiver Coupon

Merchants receive an **automatic coupon** that waives the membership fee when their transaction fees reach the plan threshold.

| Plan | Membership Fee | Coupon Threshold | Coupon Value |
|------|----------------|------------------|--------------|
| Growth | ¥6,000 | ¥6,000 in trx fees | -¥6,000 (full waiver) |
| Pro | ¥18,000 | ¥18,000 in trx fees | -¥18,000 (full waiver) |

**How it works:**
- Membership fee is the base monthly charge
- When transaction fees ≥ membership fee, a coupon is automatically applied
	- Coupon waives the full membership fee
	- Result: Merchant pays only transaction fees (same as MAX formula outcome)

**Example by plan and sales volume:**

| Scenario | Plan | Monthly GMV | Transaction Fee (5%) | Membership Fee | Coupon | Total Payment |
|----------|------|-------------|---------------------|----------------|--------|---------------|
| Low sales | Free | ¥50,000 | ¥2,500 | ¥0 | — | **¥2,500** |
| Low sales | Growth | ¥50,000 | ¥2,500 | ¥6,000 | None | ¥8,500 |
| Near threshold | Growth | ¥100,000 | ¥5,000 | ¥6,000 | None | ¥11,000 |
| At threshold | Growth | ¥120,000 | ¥6,000 | ¥6,000 | -¥6,000 | **¥6,000** |
| High sales | Growth | ¥200,000 | ¥10,000 | ¥6,000 | -¥6,000 | **¥10,000** |

**Key insight:** A low-sales merchant on Free plan pays ¥2,500. The same merchant on Growth plan pays ¥8,500. Only upgrade when you need the extra POS quota or features.

**Break-even GMV by plan:**
- Growth Plan (¥6,000): ¥120,000 monthly GMV
- Pro Plan (¥18,000): ¥360,000 monthly GMV

**Merchant benefit:** Reach the threshold and your membership fee is waived — you only pay transaction fees.

### 5.2 Why This Is Fair

**Free plan exists for low-volume merchants.** Upgrading to Growth/Pro is a choice to access more features and quota — not a requirement.

| Merchant Type | Online GMV | POS Needs | Best Plan | What They Pay |
|---------------|------------|-----------|-----------|---------------|
| Small/starting | Low | Low (<300/mo) | **Free** | Trx fees only |
| POS-heavy | Low | High (3000+/mo) | **Growth/Pro** | Membership + trx fees |
| Online-heavy | High | Any | **Growth/Pro** | Trx fees only (coupon) |
| High volume | High | High | **Pro** | Trx fees only (coupon) |

**What the membership fee covers:**
- POS transaction quota (300 → 3,000 → Unlimited)
- Staff accounts (2 → 5 → 16)
- Advanced features (analytics, promotions, featured placement)

**The waiver coupon is a bonus**, not an entitlement. Merchants who drive high online GMV are rewarded — their membership fee is waived because their transaction fees already exceed it.

**Low online GMV + paid plan = paying for features**, not being penalized. If a merchant doesn't need the extra POS quota or features, they should stay on Free.

### 5.3 Implementation by Phase

**Phase 1 (Honor-based):**
- Transaction fees invoiced monthly based on reported GMV
- Membership fee invoiced separately
- Coupon applied automatically if threshold reached

**Phase 2+ (Payment provider integration):**
- Transaction fees auto-deducted from each sale (5% at source)
- At month end:
  - If transaction fees ≥ membership fee: Coupon applied, no membership charge
  - If transaction fees < membership fee: Membership fee charged (trx fees already collected separately)

**Example (Growth Plan ¥6,000, high sales month ¥200k GMV):**

| Timing | Event | Amount |
|--------|-------|--------|
| During month | Transaction fees deducted (5% × ¥200k) | -¥10,000 |
| Month end | Membership fee | ¥6,000 |
| Month end | Waiver coupon applied | -¥6,000 |
| **Total** | | **¥10,000** |

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
