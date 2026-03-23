# Merchant-Managed Payment

> **Feature Type:** Merchant
> **Status:** Active (application-gated)
>
> **Related:**
> - [[monetization#5. Payment Architecture]] — Payment architecture overview
> - [[payment-gateway/transaction-processing]] — Billing SKU for this feature
> - [[onboarding]] — Merchant registration flow
> - [[admin-moderation]] — Admin review tooling

---

## Overview

Merchant-Managed Payment allows a merchant to collect payment outside of Halava's payment infrastructure. When enabled, the merchant's configured payment methods appear at consumer checkout. Halava records the order, notifies the merchant at placement, and provides the same order management tools as Halava Pay — status updates, tracking number input, and consumer notifications. The key difference is **payment-related automation is absent**: Halava cannot detect when the consumer has paid, so payment confirmation and payment-triggered status changes must be handled manually by the merchant. Fulfillment steps work the same as any order type — the merchant updates them through the dashboard. Halava does not intermediate payment or disputes.

**This is an application-gated feature.** Merchants cannot self-enable it. Each application is reviewed and approved by Halava individually.

---

## Why This Feature Exists

### Regulatory Necessity (Phase 1)

Intermediating consumer payments — collecting funds from the consumer and remitting to the merchant — requires a **資金移動業 (funds transfer business) license** from Japan's Financial Services Agency (FSA). Halava will not hold this license at initial launch.

Merchant-Managed Payment keeps Halava outside the money flow: the consumer pays the merchant directly (bank transfer to the merchant's own account, or COD via the merchant's own delivery contract), and Halava never touches the funds. This is the legally compliant digital payment model for Phase 1.

Without this feature, Phase 1 merchants would have no digital payment option — only Pay at Pickup (cash at collection), which is too limiting for e-commerce.

### "Bring Your Own Payment" (Phase 2+)

When Halava Pay launches in Phase 2 via a licensed payment partner, Merchant-Managed Payment remains as a permanent option. Halava is designed as a **full-suite business platform** — analogous to a cloud provider — where merchants activate the capabilities they need. Just as a cloud platform supports bringing your own DNS, storage, or identity provider rather than forcing native services, Halava supports merchants who have existing payment infrastructure (bank relationships, delivery contracts) they wish to preserve.

Migration to Halava Pay happens organically as merchants experience the operational benefits of full automation — not through pressure or removal of the option.

### Why Application-Gated

A consumer who has a bad payment experience will associate it with Halava regardless of any disclaimer. The application process ensures Halava has verified the merchant's identity and payment infrastructure before their methods are shown to consumers — protecting the platform's halal trust brand while keeping access open to any merchant who can demonstrate genuine existing infrastructure.

---

## Supported Methods

Merchant-Managed Payment has two methods with different risk profiles and different approval requirements.

### Bank Transfer

The consumer transfers payment to the merchant's own bank account. Merchant confirms receipt manually. Halava displays the merchant's bank account details at checkout.

**Risk level:** Lower. The consumer has not yet transferred when the order is placed — if the merchant is unresponsive, the consumer simply doesn't pay.

### COD via Merchant's Own Delivery Contract

The merchant's delivery partner (e.g., Kuroneko Yamato direct contract) collects cash at the door and remits to the merchant. Halava displays COD as available at checkout.

**Risk level:** Higher. The consumer receives goods and hands over cash — if there is a dispute about delivery condition or amount, there is no Halava record and no Halava intermediation.

---

## Eligibility

Any registered merchant can apply. There is no minimum order history on Halava — this feature is specifically designed to onboard established merchants who are joining Halava for the first time and already have their own payment infrastructure.

Halava reviews each application individually and decides whether to approve. There are no published approval criteria beyond the document requirements below — Halava uses judgement based on the application materials.

---

## Application Flow

### Merchant Side

1. **Opens the application form** from their dashboard (available to all registered merchants)
2. **Selects which methods to apply for:** Bank Transfer, COD (own contract), or both
3. **Submits required documents:**

| Method | Required submission |
|--------|---------------------|
| Bank Transfer | Bank name, branch name, account type, account number, account name (must match business registration) |
| COD (own contract) | Declaration of active delivery contract + contract document or carrier account number |

4. **Signs the Merchant Agreement** (see below)
5. **Submits application** — enters a pending state; feature is not yet enabled

### Halava Review (Admin Side)

1. Admin receives application in the review queue
2. Verifies bank account name against business registration
3. For COD applications: verifies delivery contract documentation
4. Approves or rejects with a stated reason
5. Merchant is notified of the decision via dashboard notification and email

There is no SLA commitment on review time. Halava may request additional documentation before deciding.

---

## Merchant Agreement

Before submitting an application, the merchant must explicitly acknowledge the following:

> *"By enabling Merchant-Managed Payment, I understand and agree that:*
> - *Halava cannot detect when the consumer has paid. I am responsible for confirming payment and updating order status accordingly — there is no payment automation.*
> - *Halava provides no dispute intermediation for orders placed under Merchant-Managed Payment*
> - *I am solely responsible for payment confirmation and all related consumer communication*
> - *Halava may suspend this feature if consumer complaint volume associated with my Merchant-Managed orders exceeds defined thresholds*
> - *I will keep my payment details accurate and up to date in my dashboard"*

This agreement is recorded at the time of application and re-acknowledged if the merchant adds a new method later.

---

## After Approval

Once approved:

- The enabled methods appear in the merchant's dashboard under **Payment Settings → Merchant-Managed Payment**
- The merchant can update their bank account details or delivery contract declaration at any time — changes are reflected at checkout immediately but logged for audit
- If the merchant disables a method, it is removed from consumer checkout immediately
- Halava can suspend or revoke access at any time (see below)

**Consumer checkout behavior:** The configured Merchant-Managed methods appear as a separate group, with a group-level info message:
> *"Payment is handled directly with the merchant. Order updates depend on the merchant updating your order status."*

---

## Suspension and Revocation

Halava may suspend Merchant-Managed Payment access if:

- Consumer complaint volume related to Merchant-Managed orders exceeds a defined threshold (exact threshold is set operationally and not published)
- The merchant's business registration lapses or is invalidated
- The merchant's bank account details are found to be inaccurate or fraudulent
- The delivery contract underlying a COD method is terminated

**Suspension** disables the feature and removes it from consumer checkout immediately. The merchant is notified with a reason. The merchant may appeal or reapply after resolving the underlying issue.

**Revocation** (permanent removal from eligibility) is reserved for deliberate misuse or fraud.

---

## Consumer-Visible Behavior

Consumers see Merchant-Managed Payment methods only if:
1. The merchant has been approved for those methods
2. The merchant has the methods enabled in their dashboard

The consumer sees no indication that the feature is application-gated — only the group-level message that payment is handled directly with the merchant.

---

## Halava Pay vs Merchant-Managed: Scope Comparison

| Function | Halava Pay | Merchant-Managed |
|----------|-----------|------------------|
| Payment processing | ✅ Automated | ❌ Merchant handles externally |
| Payment status (confirmed / failed) | ✅ Automated — Halava knows when payment clears | ❌ Merchant confirms manually |
| COD delivery confirmation | ✅ Carrier API callback (Halava's contracted partner) | ❌ No integration — merchant's own carrier contract |
| Fulfillment status updates (preparing, packed, shipped) | Merchant updates via dashboard | Merchant updates via dashboard |
| Shipment tracking number | Merchant inputs via dashboard | Merchant inputs via dashboard |
| Consumer notifications | Automated for payment events; triggered by merchant for fulfillment updates | Triggered by merchant's manual updates |
| Dispute intermediation | ✅ | ❌ |
| Buyer protection | ✅ | ❌ |
| Order record-keeping | ✅ | ✅ |
| Merchant notification at placement | ✅ | ✅ |

---

#halava #merchant #payment #feature
