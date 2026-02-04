# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Halava** is a consumer-first halal commerce platform concept. This repository contains product specifications, business model documentation, and brand assets — not source code. The project is in the specification phase with MVP development in progress.

**Tagline:** "Halal, Available Anywhere"

**Core Features:**
- B2C marketplace for halal groceries/ingredients
- Discovery directory for halal restaurants and places
- Merchant operations platform with modular capabilities

## Repository Structure

```
halava-concept/
├── kms/                    # Source of truth (Obsidian vault with wikilinks)
│   ├── index.md            # Map of Content
│   ├── spec/               # Product specifications
│   │   ├── web-app-spec.md
│   │   ├── pages-navigation-ux-spec.md
│   │   └── api-spec.md
│   ├── features/           # Feature specifications by audience
│   │   ├── consumer/       # Consumer-facing features
│   │   │   ├── group-purchase.md
│   │   │   ├── purchase-history.md
│   │   │   ├── price-comparison.md
│   │   │   ├── bopu.md
│   │   │   ├── reviews-ratings.md
│   │   │   └── saved-items.md
│   │   ├── merchant/       # Merchant capabilities
│   │   │   ├── pos.md
│   │   │   ├── products.md
│   │   │   ├── order-management.md
│   │   │   ├── inventory.md
│   │   │   ├── promotions.md
│   │   │   ├── restaurant-ops.md
│   │   │   └── accounting.md
│   │   ├── shared/         # Features used by both consumers & merchants
│   │   │   ├── authentication.md
│   │   │   ├── onboarding.md
│   │   │   ├── notifications.md
│   │   │   ├── directory.md
│   │   │   ├── marketplace.md
│   │   │   └── multi-language.md
│   │   └── platform/       # Platform-level features
│   │       ├── roles-permissions.md
│   │       └── admin-moderation.md
│   ├── business/           # Business documents
│   │   ├── monetization.md
│   │   ├── pitch-deck.md
│   │   ├── market-validation.md
│   │   └── risk-assessment.md
│   ├── technical/          # Technical architecture
│   │   ├── architecture.md
│   │   ├── data-model.md
│   │   └── roadmap.md
│   └── design/             # Design documentation
│       ├── wireframes.md
│       └── design-system.md
├── flat/                   # AI-readable originals (full detail, no wikilinks)
│   ├── README.md
│   ├── halava_web_app_spec_canvas.md
│   ├── halava_pages_navigation_ux.md
│   ├── halava_api_spec.md
│   ├── halava_monetization_pricing_strategy_summary.md
│   ├── halava_pitch_deck_outline_10_12_slides.md
│   ├── halava_market_validation.md
│   ├── halava_risk_assessment.md
│   └── halava_technical_architecture.md
├── logo/logo.svg           # Brand logo
├── sync.sh                 # KMS → Flat sync script
└── README.md               # Project overview
```

### Two Documentation Formats

**kms/ (Obsidian vault):**
- Condensed, interlinked notes with `[[wikilinks]]`
- Best for human navigation and knowledge exploration
- Open in Obsidian for graph view and backlinks

**flat/ (Original specs):**
- Full-detail specification files
- Standard markdown (no wikilinks)
- Best for AI context and comprehensive reference

### Converting KMS to Flat

When syncing or converting KMS documents to flat format:
1. **Remove all wikilinks** — Convert `[[document]]` to standard Markdown links `[document](document.md)`
2. **Remove Obsidian tags** — Strip `#halava #business` style tags
3. **No KMS references** — The flat version must be completely standalone with zero visibility into the KMS structure. Do not mention `/kms/`, wikilinks, or Obsidian
4. **Self-contained** — Each flat file should work independently without referencing the KMS folder
5. **Use flat file naming** — Reference other flat files by their `halava_*.md` names, not KMS paths

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
1. **kms/index.md** — Map of Content for navigation
2. **kms/spec/web-app-spec.md** — Product specification summary
3. **flat/halava_web_app_spec_canvas.md** — Full detailed specification
4. **flat/halava_monetization_pricing_strategy_summary.md** — Complete revenue model
5. **kms/technical/architecture.md** — System architecture summary
6. **flat/halava_technical_architecture.md** — Full technical architecture

## Key Terms

> **Full glossary:** See `kms/glossary.md` for complete abbreviations and definitions.

- **GMV:** Gross Merchandise Value
- **BOPU:** Buy Online, Pick Up (in-store)
- **CAC:** Customer Acquisition Cost
- **POS:** Point of Sale
- **Capability:** A modular feature set merchants can enable/disable
- **Consumer-first:** Growth strategy prioritizing consumer value over merchant acquisition
