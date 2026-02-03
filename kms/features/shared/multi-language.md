# Multi-language Support

> **Feature Type:** Shared (Platform-wide)
> **Version:** v1.1
> **Status:** Planned
>
> **Related:** [[web-app-spec]] · [[directory]] · [[marketplace]] · [[restaurant-ops]]

---

## Definition

**Multi-language Support** enables Halava to serve users in their preferred language. The platform will support English, Japanese, and Indonesian at launch, with infrastructure for additional languages.

**Core value proposition:**
- Serve Japan's diverse halal-seeking community
- Support international tourists and residents
- Enable merchants to reach broader audiences
- Inclusive experience for all users

---

## Supported Languages

### v1.1 Launch Languages

| Language | Code | Primary Audience |
|----------|------|------------------|
| **English** | `en` | International users, default |
| **Japanese** | `ja` | Local Japanese users |
| **Indonesian** | `id` | Indonesian community in Japan |

### Future Languages (v1.2+)

| Language | Code | Priority |
|----------|------|----------|
| Arabic | `ar` | High |
| Malay | `ms` | Medium |
| Urdu | `ur` | Medium |
| Bengali | `bn` | Low |

---

## How It Works

### Language Detection

1. **User preference** — Saved in profile (highest priority)
2. **Browser/device language** — Auto-detected
3. **Geolocation** — Japan → Japanese, others → English
4. **Default** — English

### Language Switching

Users can switch language anytime via:
- Profile settings
- Footer language selector
- App settings

### Content Types

| Content Type | Translation Method |
|--------------|-------------------|
| **UI strings** | Pre-translated, stored in i18n files |
| **System messages** | Pre-translated |
| **Merchant content** | Merchant-provided or auto-translated |
| **User-generated** | Original language + optional translation |

---

## User Journey

### Consumer: Change Language

```
Profile → Settings → Language
  → Current: English
  → Select: 日本語 (Japanese)
  → [Save]
  → App reloads in Japanese
```

### Consumer: View Translated Content

```
Place Page (merchant content in Japanese)
  → Description shown in Japanese
  → [Translate to English] button
  → Machine translation displayed
  → Note: "Auto-translated from Japanese"
```

### Merchant: Add Translations

```
Dashboard → Settings → Languages
  → Primary language: Japanese
  → Additional languages:
    ☑ English
    ☐ Indonesian
  → [Save]

Dashboard → Menu → Edit Item
  → Name (Japanese): ビーフルンダン
  → Name (English): Beef Rendang
  → Description (Japanese): ...
  → Description (English): ...
  → [Save]
```

---

## UI/UX Specification

### Language Selector (Footer)

```
┌──────────────────────────────────────────┐
│                                          │
│   [🌐 English ▼]                         │
│   ├── English                            │
│   ├── 日本語                              │
│   └── Bahasa Indonesia                   │
│                                          │
└──────────────────────────────────────────┘
```

### Language Settings (Profile)

```
┌──────────────────────────────────────────┐
│ Language & Region                        │
├──────────────────────────────────────────┤
│                                          │
│ App Language                             │
│ ┌──────────────────────────────────────┐ │
│ │ 日本語 (Japanese)                 ▼  │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Content Translation                      │
│ ☑ Show translation button for foreign   │
│   language content                       │
│                                          │
│ Region                                   │
│ ┌──────────────────────────────────────┐ │
│ │ Japan                             ▼  │ │
│ └──────────────────────────────────────┘ │
│ (Affects currency, date format)         │
│                                          │
└──────────────────────────────────────────┘
```

### Merchant Translation Interface

```
┌──────────────────────────────────────────┐
│ Edit Menu Item                           │
├──────────────────────────────────────────┤
│                                          │
│ [Japanese] [English] [+ Add Language]    │
│                                          │
│ ─── Japanese (Primary) ───               │
│                                          │
│ Name *                                   │
│ ┌──────────────────────────────────────┐ │
│ │ ビーフルンダン                        │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Description                              │
│ ┌──────────────────────────────────────┐ │
│ │ インドネシア風スパイシービーフ煮込み   │ │
│ │ ココナッツミルクで柔らかく仕上げました │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ─── English ───                          │
│                                          │
│ Name                                     │
│ ┌──────────────────────────────────────┐ │
│ │ Beef Rendang                         │ │
│ └──────────────────────────────────────┘ │
│ [Auto-translate from Japanese]          │
│                                          │
│ Description                              │
│ ┌──────────────────────────────────────┐ │
│ │ Indonesian-style spicy beef stew     │ │
│ │ slow-cooked in coconut milk          │ │
│ └──────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Translation Indicator

When viewing auto-translated content:

```
┌──────────────────────────────────────────┐
│ About                                    │
├──────────────────────────────────────────┤
│ 🌐 Auto-translated from Japanese         │
│                                          │
│ Indonesian-style spicy beef stew         │
│ slow-cooked in coconut milk. Made with   │
│ authentic halal-certified beef.          │
│                                          │
│ [View Original] [Report Translation]     │
└──────────────────────────────────────────┘
```

---

## Technical Implementation

### i18n Structure

```
locales/
├── en/
│   ├── common.json      # Shared strings
│   ├── auth.json        # Authentication
│   ├── directory.json   # Directory feature
│   ├── marketplace.json # Marketplace feature
│   └── ...
├── ja/
│   └── ...
└── id/
    └── ...
```

### Translation Keys

```json
// locales/en/common.json
{
  "nav.home": "Home",
  "nav.search": "Search",
  "nav.orders": "Orders",
  "nav.profile": "Profile",
  "action.save": "Save",
  "action.cancel": "Cancel",
  "status.open": "Open",
  "status.closed": "Closed"
}
```

### Dynamic Content Translation

For merchant content without translations:

1. Check if translation exists in merchant data
2. If not, offer machine translation option
3. Cache translations for performance
4. Allow users to report bad translations

### RTL Support (Future)

For Arabic and other RTL languages:
- CSS logical properties
- Mirrored layouts
- RTL-aware components

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                     UserPreferences                              │
├─────────────────────────────────────────────────────────────────┤
│  user_id         UUID FK → User PRIMARY KEY                     │
│  language        ENUM(en, ja, id) DEFAULT 'en'                  │
│  region          VARCHAR(10) DEFAULT 'JP'                       │
│  show_translation_button  BOOLEAN DEFAULT true                  │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                   MerchantTranslation                            │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  entity_type     VARCHAR(50) NOT NULL (item, place, etc.)       │
│  entity_id       UUID NOT NULL                                  │
│  field           VARCHAR(50) NOT NULL (name, description)       │
│  language        VARCHAR(5) NOT NULL (en, ja, id)               │
│  value           TEXT NOT NULL                                  │
│  is_auto_translated  BOOLEAN DEFAULT false                      │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
│  UNIQUE(merchant_id, entity_type, entity_id, field, language)   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    TranslationCache                              │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  source_text_hash  VARCHAR(64) NOT NULL                         │
│  source_language VARCHAR(5) NOT NULL                            │
│  target_language VARCHAR(5) NOT NULL                            │
│  translated_text TEXT NOT NULL                                  │
│  created_at      TIMESTAMP NOT NULL                             │
│  expires_at      TIMESTAMP NOT NULL                             │
│  UNIQUE(source_text_hash, source_language, target_language)     │
└─────────────────────────────────────────────────────────────────┘
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `merchant_translation` | `merchant_id, entity_type, entity_id, language` | Translation lookup |
| `translation_cache` | `source_text_hash, source_language, target_language` | Cache hit |
| `translation_cache` | `expires_at` | Cache cleanup |

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/locales/{lang}` | Get translation strings |
| `PUT` | `/api/v1/profile/language` | Update user language |
| `POST` | `/api/v1/translate` | Request translation |
| `GET` | `/api/v1/merchant/translations` | Get merchant translations |
| `PUT` | `/api/v1/merchant/translations` | Update translations |

### Translation Request

```json
// POST /api/v1/translate
{
  "text": "ビーフルンダン",
  "source_language": "ja",
  "target_language": "en"
}

// Response
{
  "translated_text": "Beef Rendang",
  "is_cached": false,
  "confidence": 0.95
}
```

---

## Localization Details

### Date & Time Formats

| Language | Date | Time |
|----------|------|------|
| English | Jan 30, 2026 | 7:00 PM |
| Japanese | 2026年1月30日 | 19:00 |
| Indonesian | 30 Jan 2026 | 19.00 |

### Currency

All regions use Japanese Yen (¥) as platform operates in Japan.

### Number Formats

| Language | Example |
|----------|---------|
| English | 1,234.56 |
| Japanese | 1,234.56 |
| Indonesian | 1.234,56 |

---

## Success Metrics

| Metric | Target (v1.1) |
|--------|---------------|
| Non-English user adoption | > 30% |
| Language switch rate | < 5% (indicates good detection) |
| Translation usage | > 20% of foreign content |
| Merchant translation rate | > 50% add English |

---

## Dependencies

- Translation API (Google Translate / DeepL)
- i18n framework (react-i18next or similar)
- CDN for locale files

---

#halava #feature #multi-language #i18n #shared #v1.1
