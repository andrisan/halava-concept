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
├── kms/                    # Source of truth (Obsidian vault with wikilinks)
│   ├── index.md            # Map of Content
│   ├── spec/               # Product specifications
│   │   ├── web-app-spec.md
│   │   ├── pages-navigation-ux.md
│   │   └── api-spec.md
│   ├── business/           # Business documents
│   │   ├── monetization.md
│   │   ├── pitch-deck.md
│   │   ├── market-validation.md
│   │   └── risk-assessment.md
│   ├── technical/          # Technical architecture
│   │   ├── architecture.md
│   │   └── data-model.md
│   └── design/             # Design documentation
│       ├── wireframes.md
│       └── design-system.md
├── flat/                   # AI-readable originals (full detail, no wikilinks)
│   └── halava_*.md         # Original specification files
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
5. **kms/technical/architecture.md** — System architecture overview

## Key Terms

- **GMV:** Gross Merchandise Value
- **BOPU:** Buy Online, Pick Up (in-store)
- **Capability:** A modular feature set merchants can enable/disable
- **Consumer-first:** Growth strategy prioritizing consumer value over merchant acquisition
