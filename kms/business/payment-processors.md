# Payment Processor Comparison

> **Last updated:** March 2026
> **Purpose:** Reference for Phase 2 provider selection and Phase 3 survey decisions
>
> **Related:**
> - [[monetization#5. Payment Architecture]] — Payment architecture overview
> - [[payment-gateway/transaction-processing]] — Transaction Processing SKU and rates
> - [[merchant-managed-payment]] — Phase 1 payment model

---

## TL;DR

| | Adyen | KOMOJU | GMO-PG (fincode byGMO) |
|---|---|---|---|
| **Best for** | Enterprise, high volume | International merchants entering Japan | Japan-native startups & platforms |
| **Onboarding** | Sales process, weeks | Self-serve, days | Self-serve, days |
| **Monthly minimum** | ~€1,000 (~¥160,000) | None | None |
| **Pricing model** | Interchange++ | Flat rate per method | Flat rate (not publicly listed) |
| **Card fee (Japan)** | Interchange + ~0.6% markup | 3.6% (JPY) / 4.5% (foreign currency) | Not publicly listed, negotiated |
| **English support** | ✅ | ✅ Strong | ⚠️ Limited |
| **Marketplace support** | ✅ Adyen for Platforms | ⚠️ Limited | ✅ fincode byGMO (platform model) |
| **Pay-Easy** | ✅ | ✅ | ✅ |
| **Konbini** | ✅ via econtext | ✅ | ✅ |
| **Bank transfer (Furikomi)** | ✅ virtual account | ✅ | ✅ virtual account |

---

## Phased Approach

### Phase 1 — Merchant-Managed (no processor)

Consumer pays the merchant directly. Halava never touches funds. No payment processor integration required. Zero licensing risk.

### Phase 2 — Stripe Connect (committed)

Stripe's regulatory coverage enables Halava Pay without Halava holding its own 資金移動業 license. Self-serve onboarding, most mature marketplace architecture, best English documentation, no monthly minimum.

**Stripe Japan fees (standard):**
- Card (Visa, MC, JCB, Amex): 3.6% + ¥30 per transaction
- Bank transfer (Furikomi): 1.5% of transfer amount
- Connect platform fee: $2/active merchant/month + 0.25% + $0.25/payout
- Konbini: ~¥120/transaction
- PayPay: rate not publicly listed

Phase 2 runs long-term. Phase 3 is triggered only when Stripe's flat rate creates measurable margin pressure.

**Phase 3 trigger conditions:**

| Signal | Action |
|--------|--------|
| GMV ¥50M+/month | Negotiate Stripe custom pricing first (lowest friction) |
| Stripe custom pricing insufficient | Begin formal survey of Adyen, GMO-PG, KOMOJU |
| Survey complete | Migrate or run parallel integration |

**Questions Phase 2 will answer before Phase 3 decision:**
- What is the actual card-to-bank-transfer GMV split?
- What is the monthly GMV trajectory?
- Are Halava's merchants primarily Japan-native or international?
- Does Halava expand beyond Japan?
- What is the actual Stripe margin pressure at current volume?

### Phase 3 — Survey: Adyen / KOMOJU / GMO-PG

| Candidate | Would win if... |
|-----------|----------------|
| **Adyen** | GMV is very high and interchange++ savings justify enterprise onboarding overhead; Halava expands globally |
| **GMO-PG (fincode byGMO)** | Halava stays Japan-focused; platform rates are competitive; Japan-native compliance is priority |
| **KOMOJU** | Halava needs widest Japan-local payment method coverage or expands to international merchants |

---

## Adyen

**What it is:** Global enterprise payment processor. Amazon Japan uses Adyen as its underlying processor.

**Pricing:**
- Interchange++ — passes actual card network cost + ~0.6% Adyen markup
- No setup or monthly fees, but **minimum monthly invoice ~€1,000 (~¥160,000)**
- Cheaper than flat-rate at volume — domestic card interchange typically 1.5–2.5%, well below Stripe's flat 3.6%
- Chargeback fee: ~€25/dispute

**Japan payment methods:**
- Credit/Debit cards (Visa, Mastercard, JCB, Amex, Diners, UnionPay) — direct local acquiring
- Bank transfer (Furikomi) — virtual account per transaction
- Pay-Easy (covers Japan Post Bank ATM, 300+ banks)
- Konbini (via econtext — 7-Eleven, Lawson, FamilyMart, etc.)

**Platform/marketplace support:** Adyen for Platforms — full split payments, connected account management, multi-merchant disbursement.

**Pros for Halava (Phase 3):** Cheapest per-transaction at scale; full Japan coverage including Pay-Easy; battle-tested; Adyen holds necessary Japanese financial licenses.

**Cons for Halava:** Sales process required (weeks); ~¥160,000/month minimum (viable at ~¥8M+/month GMV at ~2% effective rate); enterprise-oriented documentation.

---

## KOMOJU

**What it is:** Japan-focused PSP by Degica. Built when Shopify entered Japan. Strong for international merchants entering the Japanese market.

**Pricing:**
- No setup fees, no monthly fees
- Flat rate per method:
  - Credit card (JPY): **3.6%**
  - Credit card (foreign currency): **4.5%**
  - Konbini: **2.75%**
  - Bank transfer (Furikomi): separate fee (see KOMOJU pricing page)
- Payout fee: ¥220 (under ¥30,000) / ¥410 (over ¥30,000)
- Volume pricing available over $150,000/month

**Japan payment methods:** Cards, Furikomi, Pay-Easy, Konbini, carrier billing (Docomo/au/SoftBank), prepaid vouchers (WebMoney, Bitcash), PayPay, and other digital wallets — broadest Japan-local coverage.

**Platform/marketplace support:** Limited — primarily single-merchant focused. No native split payments / connected accounts. Platform disbursement logic must be built separately.

**Pros for Halava (Phase 3):** Zero fixed costs; self-serve onboarding; strong English support; widest Japan-local payment method coverage.

**Cons for Halava:** Card rate same as Stripe (no cost advantage); weak marketplace architecture; payout fees add up for multi-merchant disbursement.

---

## GMO-PG (fincode byGMO)

**What it is:** Japan's largest PSP (TSE Prime listed, ¥22 trillion annual processing volume). Startup-focused product **fincode byGMO** (by subsidiary GMO Epsilon) designed specifically for platforms and subscription models.

**Pricing:**
- fincode byGMO: **no initial cost, no monthly fee** — pay-per-transaction only
- Exact transaction rates not publicly listed — negotiated based on business model and volume
- Enterprise GMO-PG: custom pricing, requires consultation

**Japan payment methods (fincode byGMO):** Cards (Visa, Mastercard, JCB, Amex, Diners), bank transfer via virtual account, Konbini, Google Pay, Apple Pay.

**Platform/marketplace support:** fincode byGMO explicitly supports platform-type and subscription business models. REST API with SDK and UI components. MCP (Model Context Protocol) compatible — first PSP in Japan to support AI agent integration.

**Pros for Halava (Phase 3):** Japan-native compliance; fincode byGMO built for startups and platforms; no fixed costs; GMO-PG group holds all necessary Japanese financial licenses; virtual account bank transfer with clean reconciliation.

**Cons for Halava:** Pricing not transparent — requires direct engagement; limited English documentation and support; smaller global footprint.

---

## Head-to-Head: What Matters for Halava

| Criterion | Adyen | KOMOJU | GMO-PG (fincode) |
|-----------|-------|--------|------------------|
| Zero fixed cost to launch | ❌ ~¥160K/month minimum | ✅ | ✅ |
| Self-serve onboarding | ❌ Sales process | ✅ | ✅ |
| Multi-merchant platform architecture | ✅ Adyen for Platforms | ❌ | ✅ fincode platform model |
| Japan-native compliance | ✅ | ✅ | ✅ Market leader |
| Pay-Easy support | ✅ | ✅ | ✅ |
| Card cost at scale | ✅ Cheapest (interchange++) | ⚠️ 3.6% flat | ❓ Negotiated |
| English support | ✅ | ✅ Strong | ⚠️ Limited |
| Transparent pricing | ✅ | ✅ | ❌ Must negotiate |
| AI/MCP integration | ❌ | ❌ | ✅ First in Japan |
| Startup friendliness | ❌ Enterprise focus | ✅ | ✅ Built for startups |

---

#halava #business #payment #reference
