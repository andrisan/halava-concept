# Halava Concept

A halal-first commerce platform for Indonesia, combining a directory of halal businesses, online marketplace, and point-of-sale system.

---

## 📁 Repository Structure

```
halava-concept/
├── kms/                  # 🔗 Source of truth (Obsidian vault)
│   ├── index.md          # Map of Content
│   ├── spec/             # Product specifications
│   ├── business/         # Business documents
│   ├── technical/        # Technical architecture
│   └── design/           # Design documentation
├── flat/                 # 🤖 AI-readable exports (auto-generated)
├── logo/                 # Brand assets
├── sync.sh               # KMS → Flat sync script
└── README.md
```

### Working with the Documentation

**For humans (Obsidian):**
- Open `kms/` as an Obsidian vault
- Use `[[wikilinks]]` for internal navigation
- Start from `kms/index.md` as the Map of Content

**For AI / automation:**
- Use `flat/` folder for LLM context
- Standard markdown links (no wikilinks)
- Run `./sync.sh` to regenerate from kms/

---

## 🗺️ Documentation Map

| Document | Description |
|----------|-------------|
| **[Web App Spec](kms/spec/web-app-spec.md)** | Core product specification |
| **[Pages & Navigation](kms/spec/pages-navigation-ux.md)** | UI/UX specifications |
| **[API Spec](kms/spec/api-spec.md)** | API contracts |
| **[Architecture](kms/technical/architecture.md)** | Technical architecture |
| **[Data Model](kms/technical/data-model.md)** | Database schema |
| **[Monetization](kms/business/monetization.md)** | Pricing & revenue model |
| **[Pitch Deck](kms/business/pitch-deck.md)** | Investor presentation outline |
| **[Market Validation](kms/business/market-validation.md)** | Validation tracking |
| **[Risk Assessment](kms/business/risk-assessment.md)** | Risk analysis |

---

## 🚀 Getting Started

```bash
# Clone the repository
git clone https://github.com/andrisan/halava-concept.git
cd halava-concept

# Open kms/ in Obsidian for linked navigation
# Or read flat/ for AI-friendly markdown

# Sync kms → flat (after editing in Obsidian)
chmod +x sync.sh
./sync.sh
```

---

## 📝 Contributing

1. Edit documents in `kms/` using Obsidian or any markdown editor
2. Use `[[wikilinks]]` for internal references
3. Run `./sync.sh` before committing to update `flat/`
4. Both `kms/` and `flat/` should be committed

---

## 📄 License

MIT License - See [LICENSE](LICENSE) for details.
