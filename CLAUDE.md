# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Halava** is a consumer-first halal commerce platform concept for Japan. This repository contains product specifications, business model documentation, and brand assets — not source code. The project is in the specification phase with MVP development in progress.

**Tagline:** "Halal, Available Anywhere"

**Core Features:**
- B2C marketplace for halal groceries/ingredients
- Discovery directory for halal restaurants and places
- Merchant operations platform with modular capabilities

## Repository Structure

```
halava-concept/
├── README.md                                    # Project overview and vision
├── halava_web_app_spec_canvas.md               # Detailed product specification
├── halava_monetization_pricing_strategy_summary.md  # Business model & pricing
├── halava_pitch_deck_outline_10_12_slides.md   # Investor presentation outline
└── logo/logo.svg                               # Brand logo
```

## Key Architectural Concepts

### Capability-Based Merchant Model
Inspired by Google Cloud Platform's API enablement pattern. Merchants enable capabilities (Directory Listing, Shop/Marketplace Selling, Restaurant Operations, POS, Analytics) rather than being locked into business types.

**Capability States:** Disabled → Enabled (Needs setup) → Active → Suspended

### Consumer-First Growth Strategy
Build value for consumers first through discovery and group purchase features, letting merchant demand follow organically.

### Three-Phase Payment Integration
1. **Phase 1 (MVP):** Off-platform settlement with honor-based monthly invoicing
2. **Phase 2:** Third-party payment provider integration (Stripe Connect/PAY.JP)
3. **Phase 3:** Direct 資金移動業 (funds transfer) license (3–5+ years)

### Transaction Fee Structure (Tiered by Monthly GMV)
- ¥0–¥300k: 5.0%
- ¥300k–¥1M: 4.5%
- ¥1M–¥3M: 4.0%
- ¥3M–¥10M: 3.0%
- ¥10M+: 2.5% (or negotiated)

## Documentation Priority

When working with this repository:
1. **README.md** — Start here for project overview
2. **halava_web_app_spec_canvas.md** — Detailed feature specifications and user journeys
3. **halava_monetization_pricing_strategy_summary.md** — Revenue model and pricing logic
4. **halava_pitch_deck_outline_10_12_slides.md** — Market positioning and investor context

## Key Terms

- **GMV:** Gross Merchandise Value
- **BOPU:** Buy Online, Pick Up (in-store)
- **Capability:** A modular feature set merchants can enable/disable
- **Consumer-first:** Growth strategy prioritizing consumer value over merchant acquisition
