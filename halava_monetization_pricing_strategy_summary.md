# Halava Monetization & Pricing Strategy (Pitch & Spec Summary)

## 1. Product & Market Context

Halava is a **two-sided halal commerce platform** with a strong consumer-first approach:
- **Consumers** use Halava to discover halal products, enjoy unique features (group purchase, discovery, trust, convenience), and coordinate purchases.
- **Merchants** join Halava because consumer demand already exists and because Halava increases order value, repeat purchases, and operational efficiency.

Key characteristics:
- Consumer-first, product-led growth
- Strong offline–online loop via merchants (QR, in-store promotion)
- Group purchase creates **forced sharing / organic distribution**
- Merchant onboarding is assisted by an existing B2B halal supplier network

---

## 2. Core Monetization Philosophy

**Separation of concerns (very important):**

- **Transaction fees** monetize *volume and success* (gradual, scalable, no caps)
- **Membership plans** monetize *features and operational value*, not volume

Guiding principles:
- No paywalls on core selling functionality
- No quotas, unlock schemes, or lifetime counters
- No opportunity loss on high-GMV merchants
- Pricing must be explainable in under 10 seconds

---

## 3. Transaction Fee Model (Gradual Pricing)

Transaction fees apply to **all merchants**, regardless of plan.
Fees decrease **smoothly as GMV increases**.

Example curve (illustrative, adjustable):

| Monthly GMV | Transaction Fee |
|------------|-----------------|
| ¥0 – ¥300k | 5.0% |
| ¥300k – ¥1M | 4.5% |
| ¥1M – ¥3M | 4.0% |
| ¥3M – ¥10M | 3.0% |
| ¥10M+ | 2.5% (or negotiated) |

Key properties:
- No free transactions
- No hard cliffs
- Merchants are never punished for growth
- Platform revenue always scales with success

---

## 4. Membership Plans (Features Only)

Membership plans **do not affect transaction fee rates**.
They only unlock **advanced features**.

### Free Plan (Default)
- Monthly fee: ¥0
- Unlimited product uploads
- Online & group purchase support
- Basic order management
- Basic sales summary
- Digital QR link for sharing

Merchants can stay on this plan forever.

---

### Growth Plan
- Monthly fee: ¥3,000
- Advanced promotions (rules, limits)
- Group purchase analytics
- Customer repeat insights
- Sales export (CSV)
- Priority onboarding/support

---

### Pro Plan
- Monthly fee: ¥8,000
- Advanced analytics & trends
- Inventory alerts & forecasting
- Staff roles & permissions
- Accounting export
- Featured placement (non pay-to-win)
- Free / discounted physical promotion kits

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

**Merchant-facing explanation:**
- If monthly sales are high, the membership fee is **waived for that month**
- If monthly sales are low, the membership fee applies

Example (Growth Plan):
- Membership: ¥3,000
- Transaction fee: 3%
- Break-even GMV: ¥100,000

This ensures:
- No revenue cap for Halava
- No wasted subscription feeling for merchants
- Simple and fair mental model

---

## 6. Customer Acquisition Cost (CAC) Strategy

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

## 7. Account Creation & UX

- Email-only sign-up with **magic link**
- No password
- Full name requested only when required (e.g., checkout)
- Designed to feel like coordination, not registration

This minimizes friction in group purchase flows.

---

## 8. Funding & Business Model Alignment

- Early capital is used mainly for:
  - Founder salary (runway)
  - Cloud infrastructure
  - Promotion kit production
- Capital converts time into product leverage (not ads)
- Pricing model supports staged funding and sustainable private operation

---

## 9. One-Sentence Pitch Summary

> "Halava is a consumer-first halal commerce platform where transaction fees scale smoothly with sales, and merchants optionally subscribe to advanced tools — with subscriptions automatically waived in high-sales months."

---

## 10. Why This Model Works

- Simple to explain
- Fair to small and large merchants
- No upside cap
- No artificial complexity
- Aligned with Japan SME behavior
- Suitable for long-term private operation

---

This document can be directly reused for:
- Pitch deck monetization slides
- Business model section
- Application specification updates
- Partner and investor explanation

