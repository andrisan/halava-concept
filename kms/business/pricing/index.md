# Halava Pricing — SKU Registry

> **Last updated:** March 2026
>
> **Related:**
> - [[monetization]] — Full monetization strategy and billing model
> - [[monetization#3. Billing Model: Halava SKUs]] — How the SKU model works
> - [[glossary#Halava-Specific Terms]] — Definitions for Halava Service, Halava SKU, and related terms

---

## Overview

Halava uses a **consumption-based pricing model** built on commerce-native billing units. Each **Halava Service** owns its own set of **Halava SKUs**, each with an independent price definition (unit type, tiers, rate per unit).

For a full explanation of the billing model hierarchy and tiered volume pricing mechanics, see [[monetization#3. Billing Model: Halava SKUs]].

### Bundled Order Fee

For digital orders (Shop and Restaurant Operations), the **Basic Digital Order Fee** (¥30 fixed) and the **Transaction Processing** (% of order value) are presented to merchants as a **single combined fee per payment method**:

| Payment method | Combined fee per order |
|----------------|------------------------|
| Halava Pay | 4% + ¥30 |
| Merchant-Managed | 0.95%–0.4% + ¥30 |
| Pay at Pickup | ¥30 only |

The ¥30 fixed component is waived in the free tier (first 50 orders/month for Shop; first 100/month for Restaurant Operations). See [[payment-gateway/transaction-processing]] for the canonical rate reference.

---

## Halava Services & Their SKUs

| Halava Service | SKU | File |
|----------------|-----|------|
| Shop | Product Listing | [[shop/product-listing]] |
| Shop | Featured Listings | [[shop/featured-listings]] |
| Restaurant Operations | Menu Item | [[restaurant-operations/menu-item]] |
| Payment Gateway | Transaction Processing (incl. ¥30 order fee) | [[payment-gateway/transaction-processing]] |
| POS | POS Transaction | [[pos/transaction]] |
| Platform | Staff Accounts | [[platform/staff-accounts]] |

---

## Simulation

See [[merchant-expense-simulation]] for a worked example of monthly fees across three merchant profiles (grocery store, restaurant, online importer).

---

#halava #business #pricing #billing
