# Halava Monetization & Pricing Strategy (Pitch & Spec Summary)

> **Last updated:** January 2026
> **Target market:** Japan (currency: Japanese Yen ¥)
>
> **Related documents:**
> - `halava_web_app_spec_canvas.md` — Detailed product specification
> - `halava_pitch_deck_outline_10_12_slides.md` — Investor presentation (uses this document as source of truth for pricing)

## 1. Product & Market Context

Halava is a **two-sided halal commerce platform** with a strong consumer-first approach:
- **Consumers** use Halava to discover halal products, enjoy unique features (finance management relate to groceries and eating out, halal place discovery, halal trust, and convenience), and coordinate group purchases.
- **Merchants** join Halava to access a customer base attracted by Halava's rich feature set, while gaining powerful business management tools (inventory, sales analytics, staff management), enhanced online presence and digital storefront, and operational efficiency that drives higher order value and repeat purchases.

Key characteristics:
- **Halal trust as foundation:** Halava provides verified halal information and certification visibility, solving the core trust problem Muslim consumers face when shopping and dining
- **Consumer utility drives demand:** Valuable everyday tools (halal discovery, spending insights, dining-out budgeting) attract consumers organically—merchants join because customers are already there
- **Merchant digital empowerment:** Beyond marketplace listings, Halava gives merchants a complete online presence, storefront, and business management suite (inventory, analytics, staff, POS)
- **Fair, success-aligned pricing:** Transaction fees scale smoothly with GMV; subscriptions unlock operational tools and are waived when sales are strong—Halava only wins when merchants win
- **Low-friction accessibility:** Email magic-link authentication, no passwords, streamlined onboarding for both consumers and merchants via existing B2B halal supplier networks

---

## 2. Core Monetization Philosophy

**Separation of concerns (very important):**

- **Transaction fees** monetize *volume and success* (gradual, scalable, no caps)
- **Membership plans** monetize *features and operational value*, not volume

Guiding principles:
- No paywalls on core selling functionality (creating product listings, managing inventory, processing orders, and communicating with buyers.)
- No quotas on revenue-generating transactions (online orders scale infinitely with transaction fees)
- POS quotas are acceptable because POS is an operational tool, not a revenue channel Halava intermediates
- No opportunity loss on high-GMV merchants
- Pricing must be explainable in under 10 seconds

---

## 3. Transaction Fee Model (Gradual Pricing)

Transaction fees apply to **all merchants** for **online orders**, regardless of plan.
For POS transactions, there are no transaction fees—instead, POS access and capabilities depend on the merchant's membership plan.
Fees decrease **smoothly as GMV increases**.

**Fee rates vary by phase** to reflect the value Halava provides:

### Phase 1 — MVP (Manual Payment Verification)

In MVP, merchants verify customer payments manually via bank transfer, requiring staff effort. Halava charges **lower fees** starting at 2% to reflect this merchant burden—similar to Shopify's external payment gateway fee:

| Monthly GMV | Transaction Fee |
|------------|-----------------|
| ¥0 – ¥300k | 2.0% |
| ¥300k – ¥1M | 1.8% |
| ¥1M – ¥3M | 1.6% |
| ¥3M+ | 1.4% (or negotiated) |

**Why this structure:**
- **Shopify precedent:** Shopify charges ~2% for merchants using external payment gateways where Shopify doesn't process payments
- **Fair exchange:** Merchants do the payment verification work, so Halava takes less
- **Gradual reward:** Higher volume still earns lower rates, encouraging growth
- **Low barrier:** Encourages merchant adoption during early platform growth

### Phase 2+ — Payment Provider Integration

When Halava intermediates payments (automatic processing, no manual verification), Halava provides significantly more value. Fees increase accordingly:

| Monthly GMV | Transaction Fee |
|------------|-----------------|
| ¥0 – ¥300k | 5.0% |
| ¥300k – ¥1M | 4.5% |
| ¥1M – ¥3M | 4.0% |
| ¥3M – ¥10M | 3.0% |
| ¥10M+ | 2.5% (or negotiated) |

**Why this structure:**
- **Phase 1 discount:** Merchants do extra work (manual payment verification), so they pay less
- **Phase 2 premium:** Halava handles payment processing, eliminates manual work, provides buyer protection—justifying higher fees
- **Clear value exchange:** Fee increases are tied to tangible service improvements, making pricing easy to explain

Key properties:
- No free transactions
- No hard cliffs (marginal rate system)
- Merchants are never punished for growth
- Platform revenue always scales with success

### 3.1 Transaction Fee Scope

**Phase 1 — MVP (off-platform settlement):**

- **Online marketplace orders:** Transaction fees nominally apply to all orders placed through the Halava marketplace. However, since payment is settled directly between consumer and merchant (bank transfer), fee collection is **honor-based**: Halava invoices merchants monthly based on recorded order GMV.
  - **Precedent:** Shopify uses a similar "Bill You Later" model when merchants use external payment gateways (e.g., KOMOJU). Shopify records sales in real-time but accumulates transaction fees and invoices them monthly on the merchant's subscription billing cycle. Merchants receive their revenue immediately but are invoiced separately for fees 30 days later.
  - **Halava's approach:** Similar structure—merchants see their sales credited to their bank immediately, and Halava invoices accumulated fees monthly.
  - **Cash flow implication:** Merchants must reserve a buffer to cover monthly fee invoices, which will fluctuate with GMV. This is an accepted friction point for MVP speed but should be clearly communicated during onboarding.
- **POS in-store transactions:** Not subject to transaction fees. POS transactions are not intermediated by Halava.
- **Enforcement limitation:** Halava cannot automatically deduct fees from transactions it does not intermediate. Merchants could route orders off-platform (bypass Halava entirely). This is an accepted risk for MVP speed, mitigated by building trust and demonstrating platform value.
- **Dispute resolution intermediary:** Although Halava does not control funds, Halava provides **mediation services** for order disputes:
  - Halava acts as a neutral third party to facilitate communication between consumer and merchant
  - Halava reviews order records, chat history, and delivery confirmation to assess claims
  - Halava can issue non-binding recommendations (e.g., "merchant should issue partial refund")
  - Halava can flag or suspend merchants with repeated unresolved disputes
  - **Limitation:** Halava cannot force refunds or chargebacks—final resolution depends on merchant cooperation
  - **Trust-building value:** This service differentiates Halava from direct peer-to-peer transactions and builds consumer confidence even without payment control

**Phase 2 — Payment provider integration:**

- **Online marketplace orders:** Transaction fees are **deducted automatically at source** using a **connected-accounts model**. This is a proven pattern used by Uber, Airbnb, DoorDash, and Shopify. Here's how it works:
  - **Supported providers in Japan:** Stripe Connect (recommended), PAY.JP Platform, GMO Payment Gateway
  - The payment provider maintains separate financial accounts for Halava and each merchant.
  - When a consumer pays for an order, the payment provider splits the received amount automatically:
    - Merchant's share is settled directly to the merchant's connected account
    - Halava's platform fee is settled to Halava's account
  - No invoicing or honor-based collection needed; fees are deducted at the point of payment.
  - This eliminates enforcement risk and ensures 100% fee collection for intermediated transactions.
  - **Stripe Connect specifics:** Supports "destination charges" (charge customer, split to connected account) or "separate charges and transfers." Halava would use destination charges with application fees.
  - **Payment provider fees (important):** The provider's processing fee (e.g., Stripe ~3.6% + ¥30 in Japan) is charged **in addition to** Halava's platform fee. Both are deducted before merchant settlement.
    - Example: ¥10,000 order → Stripe takes ¥390, Halava takes ¥500 → Merchant receives ¥9,110
    - These fees are shown as separate line items on merchant invoices (see Section 3.3)
    - Total merchant cost in Phase 2: ~8.6% (Halava 5% + Stripe 3.6%) for small merchants
- **POS transactions processed through the provider:** Subject to the standard transaction fee, deducted at source the same way.
- **POS cash transactions:** Remain outside Halava's fee scope (no intermediation). Halava may introduce optional self-reported POS fee tiers in a later phase if cash-heavy merchants benefit significantly from the platform.

**Phase 2.5 — Group delivery (Future feature post-v1.5):**

- **What it is:** Halava enables groups of friends to coordinate a single bulk order from a merchant, with one person (Initiator) paying and handling offline reimbursement/distribution.
- **Why future, not MVP:** MVP focuses on halal discovery and basic online + POS integration. Delivery coordination adds complexity without immediate revenue.
- **Delivery model by distance:**
  - **Out-of-city / regional delivery:** ✅ Feasible via regular shipping companies (Yamato, Sagawa, Japan Post, etc.). Group orders are consolidated into a single shipment to one address, leveraging standard B2C logistics. This is straightforward and can be implemented with existing courier integrations.
  - **In-city / same-city delivery:** ⚠️ Requires further exploration. Last-mile logistics for same-city group orders present unique challenges:
    - Multiple drop-off points vs. single address consolidation
    - Coordination with on-demand courier services (Uber Direct, Wolt Drive, etc.) vs. scheduled delivery
    - Cost efficiency: Is it cheaper for group members to pick up from a single point, or for Halava to coordinate multi-stop delivery?
    - **Status:** Solution design in progress. Potential approaches include designated pickup points, time-window coordination, or partnership with local courier networks. This will be revisited before Phase 2.5 implementation.
- **Delivery fees in Phase 2.5:**
  - Halava does NOT handle logistics/shipping itself (no delivery fleet, courier partnership required).
  - Merchants choose their own fulfillment (self-delivery, partner courier, or digital fulfillment like QR-based pickup).
  - Halava may introduce optional fulfillment fees (e.g., 0.5–1% if Halava partners with a logistics provider) or simply pass through merchant-configured shipping costs to consumers.
  - **Transaction fee still applies** to the aggregated group order (same 2.5–5% model).
- **Benefit to merchants:** Group purchases increase order value (free shipping threshold), reducing delivery cost burden when customers are price-sensitive and coordinating.

**Phase 3 — Direct payment intermediation (Halava holds funds transfer license):**

After demonstrating consistent scale and compliance, Halava obtains its own **資金移動業 (funds transfer business) license** from the Financial Services Agency (FSA) in Japan. This enables Halava to directly intermediate payments without relying on third-party providers.

- **Online marketplace orders:** Transaction fees are **deducted at source** by Halava itself, without a payment provider intermediary.
  - The payment flow: Consumer → Halava (temporarily holds funds) → Halava deducts its platform fee → Merchant receives net amount.
  - Halava's fee structure remains identical to Phase 2 (2.5% – 5% depending on GMV tier).
  - **Gateway/processing costs:** Minimal. Halava negotiates directly with bank settlement networks (Japan Clearing House, etc.), eliminating the third-party processor markup (~1.5% savings vs. Phase 2).
  - **Benefit to merchants:** Lower total fees due to eliminated intermediary margin. Example: Phase 2 total = 5% Halava + 3.6% gateway = 8.6%; Phase 3 total = ~5% Halava + ~0.5% settlement = 5.5%.
- **POS transactions:** Subject to standard transaction fee, deducted at source.
- **Cash transactions:** Remain outside Halava's fee scope (no intermediation).

**Regulatory and operational requirements:**

- **Compliance burden:** Halava must maintain strict KYC/AML controls, transaction monitoring, and dispute resolution systems. Ongoing FSA audits and reporting required.
- **Capital requirement:** FSA license requires maintaining a minimum reserve fund (typically ¥20–50M depending on transaction volume).
- **Timeline:** Phase 3 is a **long-term goal** (3–5+ years), only pursued after Phase 2 generates sufficient scale and operational track record.
- **Risk:** If Halava fails to comply with FSA regulations, the license can be revoked, causing operational collapse. Phase 2 (third-party provider) is safer operationally.

### 3.2 GMV Tier Calculation

- **Period:** Monthly calendar period (1st to last day of each month). GMV resets at the start of each month.
- **Rate application:** **Marginal rate** (tax-bracket style). Each tier's rate applies only to the GMV within that tier's range, not to the entire month's GMV.
  - Example: A merchant with ¥500k monthly GMV pays 5% on the first ¥300k (= ¥15,000) + 4.5% on the remaining ¥200k (= ¥9,000), totaling ¥24,000 — **not** 4.5% × ¥500k (= ¥22,500).
- **Why marginal:** Eliminates cliff effects where earning ¥1 more could shift the entire GMV to a lower rate, creating unpredictable revenue for Halava and confusing billing for merchants.

### 3.3 Payment Processing Costs

Transaction fees above are Halava's platform take. Underlying payment gateway fees are handled as follows:

- **Phase 1 — MVP (off-platform settlement):** No gateway fees apply. Consumers pay merchants directly via bank transfer; Halava does not intermediate the payment.
- **Phase 2 — Payment provider integration (e.g., Stripe Connect, PAY.JP):** Gateway fees (e.g., Stripe ~3.6% + ¥30 in Japan) are passed through as a **separate, transparent line item** on the merchant's invoice — never bundled into the platform fee. Merchant-facing invoice shows: `Platform fee (X%) + Gateway fee (Y% + ¥Z) = Total`.
- **Phase 3 — Direct intermediation (Halava holds license):** Halava settles payments directly with bank networks, reducing gateway costs to ~0.5%. See Phase 3 details in section 3.1 for merchant cost comparison and regulatory requirements.
- **All phases:** Cash and external payment methods incur no gateway fee.

---

## 4. Membership Plans (Features + POS Quota)

Membership plans **do not affect transaction fee rates** for online orders.
They unlock **advanced features** and determine **POS transaction quota**.

### Early Adopter Pricing Strategy

Halava uses a **higher base price with early-phase discounts** to:
- Establish appropriate market positioning (competitive with Shopify Japan ¥3,650–¥46,000/mo)
- Reward early merchants who take a risk on a new platform
- Avoid the friction of raising prices on existing customers later
- Create urgency for early sign-ups

**Early adopter discount structure:**
- **Phase 1 (MVP):** 50% discount on all paid plans — locked in for merchants who join during this phase
- **Phase 2 (Payment Integration):** 25% discount for new merchants joining during this phase
- **Phase 3+:** Full pricing applies to new merchants; early adopters retain their locked-in discount

Early adopter discounts are **lifetime benefits** for qualifying merchants as long as they maintain an active subscription (no lapses > 60 days).

### Free Plan (Default)
- Monthly fee: ¥0
- Unlimited product uploads
- Online & group purchase (transaction fees apply)
- Basic order management
- Basic sales summary
- Public web storefront
- **POS: 300 transactions/month** (basic features)
- Top-ups available (see section 4.1)

Merchants can stay on this plan forever.

### Growth Plan
- Monthly fee: **¥6,000** (waived when monthly transaction fees ≥ ¥6,000)
  - *Phase 1 early adopter price: ¥3,000 (waiver threshold: ¥3,000)*
  - *Phase 2 early adopter price: ¥4,500 (waiver threshold: ¥4,500)*
- Everything in Free Plan, plus:
  - Advanced promotions (rules, limits)
  - Group purchase analytics
  - Customer repeat insights
  - Sales export (CSV)
  - **POS: 3,000 transactions/month** (advanced features: multi-register, shift management)
  - 2 staff roles & permissions
  - 1 store location
  - Priority onboarding/support
- Top-ups available

### Pro Plan
- Monthly fee: **¥18,000** (waived when monthly transaction fees ≥ ¥18,000)
  - *Phase 1 early adopter price: ¥9,000 (waiver threshold: ¥9,000)*
  - *Phase 2 early adopter price: ¥13,500 (waiver threshold: ¥13,500)*
- Everything in Growth Plan, plus:
  - Advanced analytics & trends
  - Inventory alerts & forecasting
  - 5 store locations
  - 10 staff roles & permissions
  - Accounting export
  - **POS: Unlimited transactions**
  - Featured placement (non pay-to-win)
  - Free / discounted physical promotion kits

### Custom Enterprise Plan
- Monthly fee: Negotiated
- Custom features & integrations
- Dedicated account manager
- POS: Unlimited transactions

### 4.1 POS Transaction Top-ups

When a merchant reaches their monthly POS quota, they can purchase top-up packs to continue processing transactions.

**Top-up pricing:**

| Pack | Transactions | Price | Per-transaction |
|------|--------------|-------|-----------------|
| Small | 100 | ¥300 | ¥3.0 |
| Medium | 300 | ¥750 | ¥2.5 |
| Large | 500 | ¥1,000 | ¥2.0 |

**Top-up rules:**
- **Monthly expiry:** Unused top-up quota expires at month end. No rollover.
- **Hard cap with grace buffer:** When quota is exhausted, a 5-transaction grace buffer is provided and auto-billed at ¥75 (¥15/transaction). This prevents hard-stops during service but discourages reliance on grace. Grace is 6–8x more expensive than planned top-ups, incentivizing merchants to purchase ahead.
- **Purchase anytime:** Merchants can pre-purchase top-ups before hitting the limit.
- **Auto top-up (opt-in):** Merchants can enable automatic top-up purchase when quota reaches 80%.

**Upgrade incentive math:**

| Scenario | Monthly cost | Transactions |
|----------|--------------|--------------|
| Free only | ¥0 | 300 |
| Free + 2× Medium top-up | ¥1,500 | 900 |
| Free + 3× Large top-up | ¥3,000 | 1,800 |
| **Growth plan** | **¥3,000** | **3,000** |

Merchants who consistently need 1,500+ transactions/month are better off upgrading to Growth. Top-ups are designed for occasional spikes, not sustained high usage.

---

## 5. Membership Fee Waiver Logic (Important)

To avoid opportunity loss and reduce merchant resistance:

**Monthly charge logic (internal):**
```
Merchant pays = MAX(
  membership_fee,
  transaction_fee_for_the_month
)
```

**Monthly billing mechanism:**
- Halava calculates both the transaction fee for the month and the membership fee on a **single consolidated invoice**.
- The membership fee is **always displayed** on the invoice, even when it's waived.
- If transaction fees ≥ membership fee, the membership fee line is marked as **crossed out** or explicitly noted as **"Waived"** to visually emphasize the benefit.
- This transparency ensures merchants understand they are receiving value from their plan without paying additional costs in that month.

**Merchant-facing explanation:**
- If monthly sales are high, the membership fee is **waived for that month**
- If monthly sales are low, the membership fee applies

**Example (Growth Plan — Full Price ¥6,000):**
- Membership: ¥6,000
- Assumed transaction fee rate: ~5% (for GMV under ¥300k)
- Break-even GMV: ~¥120,000 (¥120,000 × 5% = ¥6,000)
- At ¥300k–1M GMV tier (4.5% fee): membership is waived if transaction fees ≥ ¥6,000 (i.e., GMV ≥ ~¥133,000)

**Example (Growth Plan — Phase 1 Early Adopter ¥3,000):**
- Membership: ¥3,000
- Break-even GMV: ~¥60,000 (¥60,000 × 5% = ¥3,000)

**Example (Pro Plan — Full Price ¥18,000):**
- Membership: ¥18,000
- At 5% tier: break-even GMV ~¥360,000
- At 4.5% tier: break-even GMV ~¥400,000

**Example (Pro Plan — Phase 1 Early Adopter ¥9,000):**
- Membership: ¥9,000
- At 5% tier: break-even GMV ~¥180,000

This ensures:
- No revenue cap for Halava
- No wasted subscription feeling for merchants
- Simple and fair mental model

### 5.1 Merchant-Facing Invoice Presentation

To maintain trust and avoid confusion, the monthly merchant invoice should present charges transparently:

```
Monthly Invoice — January 2026
─────────────────────────────────
Plan: Growth (¥6,000/mo)
Early Adopter Discount: Phase 1 (50% off, lifetime)
Effective Plan Rate: ¥3,000/mo
Online GMV: ¥450,000

Transaction fees:
  ¥0–¥300k   @ 5.0%  = ¥15,000
  ¥300k–¥450k @ 4.5%  = ¥6,750
  Total transaction fees: ¥21,750

Membership fee: ¥3,000 (early adopter rate)
Waiver applied: ✓ (transaction fees exceed membership fee)

Amount due: ¥21,750
─────────────────────────────────
```

Key presentation principles:
- Always show both the membership fee and the transaction fees, even when the waiver applies.
- Explicitly label the waiver so the merchant understands they are receiving value from their plan without additional cost.
- Never show a combined or opaque total — the breakdown builds trust.
- When transaction fees are below the membership fee, the invoice shows: `Amount due: ¥3,000 (membership fee — includes platform usage up to this amount)`.

---

## 6. Refund & Cancellation Policy

### Phase 1 — MVP (off-platform settlement)

Since Halava does not process payments in MVP, refunds are handled directly between consumer and merchant. Halava facilitates communication via order status updates but does not intermediate funds.

- **Order cancellation before merchant confirmation:** Order is cancelled; no fees apply.
- **Order cancellation after merchant confirmation:** Consumer contacts the merchant directly. Halava updates order status to "cancelled" or "refunded" based on merchant action.

### Phase 2 — Payment provider integration

When Halava intermediates payments via a licensed provider:

- **Platform fee on refunds:** Halava's platform fee is refunded proportionally to the merchant. If a full refund is issued, the full platform fee is returned.
- **Gateway fees on refunds:** Payment processor fees (e.g., Stripe) are generally **not refundable** and are absorbed by the merchant, consistent with industry standard. This will be disclosed clearly in merchant onboarding.
- **Chargebacks:** Gateway chargeback fees are passed through to the merchant. Halava's platform fee is refunded if the chargeback is upheld. Dispute support is provided at Pro plan and above.
- **Consumer protection:** Payments intermediated by the provider benefit from the provider's buyer protection policies, significantly increasing consumer trust compared to Phase 1.

---

## 7. Customer Acquisition Cost (CAC) Strategy

### Merchant CAC
- Primarily driven by partner B2B network
- Onboarding cost = relationship + time
- Cash spend used mainly for **in-store promotion kits** (QR posters, counter displays)

### Consumer CAC
- No heavy paid marketing at early stage
- Driven by:
  - Group purchase sharing (forced, task-based virality)
  - Merchant QR touchpoints
  - SEO & utility-driven discovery
- Marketing spend introduced **only after retention & usage are proven**

---

## 8. Account Creation & UX

- Email-only sign-up with **magic link**
- No password
- Full name requested only when required (e.g., checkout)
- For group purchase flows, this magic-link approach makes joining feel like coordination rather than signing up—participants commit first, authenticate later. This minimizes friction in group purchase flows.

---

## 9. Funding & Business Model Alignment

- Early capital is used mainly for:
  - Founder salary (runway)
  - Cloud infrastructure
  - Promotion kit production
- Capital converts time into product leverage (not ads)
- Pricing model supports staged funding and sustainable private operation

### 9.1 Investment Staging & Co-Founder Equity Structure

To align capital deployment with risk reduction and value creation, Halava uses a **3-stage equity issuance model** with a **co-founder structure** where the capital provider also serves as the legal founder and company representative.

**Overall structure:**
- **Total capital invested:** ¥15M across 3 stages (by co-founder)
- **Total equity distribution:** Co-founder 40%, Operating Founder 60% (final)
- **Legal structure:** Co-founder registers and legally represents the company during Stage 1 (required for Japan business registration while Operating Founder is on student visa)
- **Key principle:** Equity allocation is earned through milestones and capital deployment
- **Transition:** Operating Founder transitions from contractor (Stage 1) to employee (Stage 2+)

---

**Stage 1 — Validation Stage**

- **Capital deployed:** ¥3M (by co-founder)
- **Equity allocation:** Co-founder 10%, Operating Founder 90%
- **Post-money valuation (implied):** ¥30M
- **Legal setup:** Co-founder registers the company and serves as legal representative (代表取締役). Operating Founder works as part-time contractor while on student visa.
- **Purpose:**
  - Register legal entity (株式会社) in Japan with co-founder as representative director
  - Build and launch MVP (Phase 1 from Section 3.1)
  - Onboard initial merchants (5–10 pilot merchants via B2B network)
  - Validate honor-based transaction fee collection model
  - Prove Operating Founder's execution capability and product-market fit hypothesis
- **Capital allocation:**
  - ¥1.5M: Operating Founder compensation (part-time contractor rate: ¥1,500/hour while student; max 28 hours/week for 7 months ≈ 784 hours)
  - ¥800k: Cloud infrastructure, development tools, basic SaaS subscriptions
  - ¥500k: In-store promotion kits (QR posters, counter displays) for initial merchants
  - ¥200k: Legal setup, business registration (株式会社 formation), initial compliance
- **Critical requirement:** All legal entity formation, business registration, and foundational compliance **must be completed during Stage 1**. Stage 2 funding will not proceed without proper legal structure in place.
- **Timeline:** 7 months from funding to milestone completion

**Equity position after Stage 1:**
- Operating Founder: 90%
- Co-founder: 10%

**Risk profile:** Highest risk stage (idea → execution). Co-founder provides capital and legal foundation; Operating Founder provides execution. Operating Founder retains strong majority.

---

**Stage 2 — Traction Stage**

- **Capital deployed:** ¥5M (by co-founder)
- **Additional equity to co-founder:** +15% (cumulative: 25%)
- **Post-money valuation (implied):** ~¥20M (¥5M / 15% = ¥33.3M, but Stage 1 + Stage 2 basis)
- **Triggers (must achieve ALL):**
  - MVP is live and stable (users can complete full purchase flow)
  - 15–25 active merchants onboarded and processing orders
  - Real transaction volume recorded (minimum ¥5M GMV/month across all merchants)
  - Transaction fee collection working (honor-based invoicing proven)
- **Purpose:**
  - Expand merchant acquisition (target 50+ merchants)
  - Build foundation for Phase 2 (payment provider integration prep)
  - Hire 1–2 additional team members (operations, merchant success)
  - Improve product based on early merchant feedback
- **Capital allocation:**
  - ¥2.5M: Operating Founder salary (¥250,000/month for 12 months = ¥3M; adjusted with 1–2 part-time hires)
  - ¥1.2M: Merchant acquisition (promotion kits, onboarding support, partner incentives)
  - ¥800k: Product development (POS features, analytics, merchant dashboard improvements)
  - ¥500k: Infrastructure scaling (database, hosting for higher traffic)
- **Operating Founder transition:** Operating Founder changes visa status from student to employee visa (就労ビザ), becoming a formal employee of the company with monthly salary (¥250,000/month). Co-founder remains legal representative.
- **Dividend policy:** "The company may distribute dividends of 30%–50% of annual net profit, subject to cash flow, growth plans, and board approval."
  - Early years (Stage 2–3): 0%–30% payout (prioritize reinvestment)
  - Mature & cash-positive: 40%–50% payout
  - Default target: 50% is a founder-friendly baseline once stable
  - Dividends distributed to shareholders according to equity ownership (75% Operating Founder / 25% Co-founder at this stage)

**Equity position after Stage 2:**
- Operating Founder: 75%
- Co-founder: 25%

**Risk profile:** Medium risk. Product proven, but scale unproven. Co-founder sees execution capability before committing larger capital.

---

**Stage 3 — Commitment Stage**

- **Capital deployed:** ¥7M (by co-founder)
- **Additional equity to co-founder:** +15% (cumulative: 40%)
- **Post-money valuation (implied):** ~¥46.7M (¥7M / 15%)
- **Triggers (must achieve ALL):**
  - 50+ active merchants with consistent monthly orders
  - ¥10M+ monthly GMV across platform
  - Monthly revenue (transaction fees) ≥ ¥500k
  - Stable operations (no critical outages, merchants renewing)
  - Clear roadmap to Phase 2 (payment provider integration) with timeline and vendor selection
- **Purpose:**
  - Scale to 100+ merchants
  - Transition to Phase 2 (payment provider integration — see Section 3.1)
  - Build operational systems (customer support, merchant success, compliance)
  - Expand team to 5–7 people
  - Prepare for sustainable growth (accounting systems, legal structure refinement)
- **Capital allocation:**
  - ¥3M: Team expansion (developers, operations, merchant success) + Operating Founder salary (¥250,000/month for 18–24 months; balance for team)
  - ¥2M: Payment provider integration (Stripe/PAY.JP setup, merchant onboarding to connected accounts, KYC compliance tools)
  - ¥1M: Marketing & merchant acquisition (expand beyond B2B network to organic channels)
  - ¥700k: Infrastructure & tooling (analytics, CRM, support systems)
  - ¥300k: Legal & compliance (payment provider contracts, FSA guidance consultation)
- **Dividend policy:** Same graduated structure as Stage 2. Dividends distributed to shareholders according to final equity ownership (Operating Founder 60%, Co-founder 40%).

**Final equity position:**
- Operating Founder: 60%
- Co-founder: 40%

**Risk profile:** Lowest risk. Revenue-generating, proven model, clear path to scale. Co-founder has seen consistent execution across 2 prior stages.

---

**Why this structure works:**

1. **Operating Founder protection:**
   - Retains majority (60%) and effective control throughout
   - Can continue building even if co-founder exits or doesn't fund later stages
   - Equity dilution happens only when capital is needed and value is proven
   - Transitions from contractor to employee with stable income

2. **Co-founder protection:**
   - Provides capital tied to achieved milestones
   - Can exit after any stage if performance doesn't meet expectations
   - Risk decreases with each stage as business proves itself
   - Legal representative role ensures compliance and governance oversight
   - Clear valuation step-ups reward early commitment

3. **Business alignment:**
   - Stages align with product phases (Phase 1 MVP → Phase 2 payment integration → Phase 3 prep)
   - Capital deployment matches actual operational needs at each stage
   - Forced discipline: must hit milestones to unlock next stage
   - Co-founder provides legal foundation; Operating Founder provides execution

4. **Japan-market fit:**
   - Solves visa/legal representative problem (student cannot register company)
   - Co-founder structure mirrors Japanese preference for long-term partnerships
   - Operating Founder maintains operational control and "ownership face" which matters in merchant relationships
   - Conservative equity structure (co-founder doesn't take majority)

**Alternative scenario — early exit:**

If co-founder chooses not to fund Stage 2 or Stage 3:
- Operating Founder retains majority equity (90% or 75%)
- Business can continue operating on transaction fee revenue
- Operating Founder can seek alternative funding or bootstrap to profitability
- No forced sale or control transfer
- Co-founder may remain as minority shareholder or exit via buyback agreement

---

## 10. One-Sentence Pitch Summary

> "Halava is a consumer-first halal commerce platform where transaction fees scale smoothly with sales, and merchants optionally subscribe to advanced tools — with subscriptions automatically waived in high-sales months."

---

## 11. Why This Model Works

- Simple to explain
- Fair to small and large merchants
- No upside cap
- No artificial complexity
- Aligned with Japan SME behavior
- Suitable for long-term private operation

---

## 12. Competitive Benchmarking

| Platform | Transaction Fee | Subscription Model | Notes |
|----------|-----------------|-------------------|-------|
| **Halava** | 2.5–5% (GMV-based) | ¥0–¥18,000/mo (waivable) | Gradual pricing, no caps, early adopter discounts |
| **BASE (Japan)** | 3.6% + 40¥ | ¥0 (free plan) | Simple but flat fee |
| **STORES.jp** | 5% | ¥0 (free), ¥2,178/mo (standard) | Higher flat rate |
| **Shopify Japan** | 3.25–3.9% + gateway | ¥3,650–¥46,000/mo | Monthly fee always applies |
| **Rakuten Ichiba** | 2–7% + monthly | ¥50,000+ setup | High barrier, complex fees |
| **UberEats** | 30–35% | N/A | Delivery platforms take much more |

Halava's model is competitive for Japan SMEs: lower take rate than delivery platforms, no high setup fees like Rakuten, waivable subscriptions unlike Shopify, and lifetime early adopter discounts reward merchants who join early.

---

This document can be directly reused for:
- Pitch deck monetization slides
- Business model section
- Application specification updates
- Partner and investor explanation

---

*Last updated: January 2026*

