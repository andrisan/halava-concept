# Glossary

> **Purpose:** Index of abbreviations and terms used throughout the Halava KMS
>
> **Related:** [[index]] · [[web-app-spec]]

---

## Business & Finance

| Abbreviation | Full Term | Definition |
|--------------|-----------|------------|
| **B2B** | Business to Business | Commercial transactions between businesses (e.g., Halava → merchant) |
| **B2C** | Business to Consumer | Commercial transactions between businesses and end consumers |
| **CAC** | Customer Acquisition Cost | Total cost to acquire a new customer (marketing, sales, onboarding) |
| **GMV** | Gross Merchandise Value | Total value of goods sold through the platform before fees/deductions |
| **LTV** | Lifetime Value | Total revenue expected from a customer over their entire relationship |
| **MoM** | Month over Month | Comparison metric between consecutive months |
| **MVP** | Minimum Viable Product | First version with core features sufficient for early adopters |
| **ROI** | Return on Investment | Ratio of net profit to investment cost |
| **SAM** | Serviceable Addressable Market | Portion of TAM that can be reached with current business model |
| **SOM** | Serviceable Obtainable Market | Realistic portion of SAM that can be captured |
| **TAM** | Total Addressable Market | Total market demand for a product/service |
| **ToS** | Terms of Service | Legal agreement between platform and users |
| **YoY** | Year over Year | Comparison metric between same periods in consecutive years |

---

## Product & Features

| Abbreviation | Full Term | Definition |
|--------------|-----------|------------|
| **BOPU** | Buy Online, Pick Up | Order online and collect in-store (also: BOPIS - Buy Online, Pick Up In Store) |
| **POS** | Point of Sale | System for processing in-store transactions |
| **QR** | Quick Response (Code) | 2D barcode used for linking, payments, and information sharing |
| **SKU** | Stock Keeping Unit | Unique identifier for each product variant. Also used in "Halava SKU" (billing) — context (Shop vs Billing) distinguishes the two. |

---

## Technical

| Abbreviation | Full Term | Definition |
|--------------|-----------|------------|
| **API** | Application Programming Interface | Interface for software components to communicate |
| **CRUD** | Create, Read, Update, Delete | Four basic operations of persistent storage |
| **FK** | Foreign Key | Database constraint linking tables |
| **GIN** | Generalized Inverted Index | PostgreSQL index type for full-text search |
| **GiST** | Generalized Search Tree | PostgreSQL index type for geometric/spatial data |
| **JSON** | JavaScript Object Notation | Lightweight data interchange format |
| **JSONB** | JSON Binary | PostgreSQL's binary JSON storage format |
| **OTP** | One-Time Password | Single-use code for authentication |
| **REST** | Representational State Transfer | Architectural style for web APIs |
| **UI** | User Interface | Visual elements users interact with |
| **URL** | Uniform Resource Locator | Web address |
| **UUID** | Universally Unique Identifier | 128-bit identifier for database records |
| **UX** | User Experience | Overall experience when using a product |

---

## Marketing & Growth

| Abbreviation | Full Term | Definition |
|--------------|-----------|------------|
| **CTA** | Call to Action | Prompt encouraging user action (e.g., "Sign Up Now") |
| **MAU** | Monthly Active Users | Unique users who engaged with the platform in a month |
| **SEO** | Search Engine Optimization | Improving visibility in search engine results |

---

## Legal & Compliance (Japan)

| Abbreviation | Full Term | Definition |
|--------------|-----------|------------|
| **APPI** | Act on the Protection of Personal Information | Japan's primary data privacy law |
| **FSA** | Financial Services Agency | Japanese financial regulatory authority |
| **資金移動業** | Funds Transfer Business | License required for payment intermediation in Japan |

---

## Halava-Specific Terms

| Term | Definition |
|------|------------|
| **Product Listing** | Billing SKU — charged per product in catalog per month, regardless of status (Shop service). See [[shop/product-listing]]. |
| **Featured Listings** | Billing SKU — paid placement in category search or homepage carousel; flat fee per booking (Shop service). See [[shop/featured-listings]]. |
| **Capability** | Modular feature set that merchants can enable/disable (e.g., POS, Directory Listing) |
| **Capability Lifecycle** | States: Disabled → Enabled (Needs setup) → Active → Suspended |
| **Consumer-first** | Growth strategy prioritizing consumer value to pull merchant demand |
| **Early Adopter Program** | Phase 1 merchants with discounted usage-based fees (locked in at onboarding) + feature development partnership |
| **Staff Accounts** | Billing SKU — per active staff account per month, beyond the free tier of 2 accounts. See [[platform/staff-accounts]]. |
| **Expense Insight** | Consumer feature for tracking halal spending and personal price history |
| **Free tier** | Defined usage threshold per Halava SKU below which no charge applies |
| **Group Purchase** | Feature allowing multiple consumers to coordinate shared orders |
| **Halava** | Platform name — abbreviation for "HALal, AVailable Anywhere" |
| **Halava Pay** | Halava's payment processing capability covering Credit Card, Debit Card, Bank Transfer (via Halava), and COD via delivery company |
| **Halava Processed** | Synonym for Halava Pay — payment category where Halava handles settlement, lifecycle management, and dispute intermediation |
| **Halava Service** | A product area that owns its own set of Halava SKUs (e.g., Shop, Payment Gateway, Restaurant Operations) |
| **Halava SKU** | A billable unit tied to a specific Halava Service, with its own independent price definition (unit type, tiers, rate) |
| **Honor-based fees** | Phase 1 fee collection via monthly invoicing (before Halava Pay integration) |
| **Marginal rate** | Tax-bracket style fee calculation (each tier applies only to that portion) |
| **Merchant-Managed Payment** | The primary digital payment model in Phase 1 (required by regulatory constraints — Halava lacks a 資金移動業 license at launch) and a permanent "bring your own payment" option from Phase 2+ onwards. Consumer pays the merchant directly; Halava never touches the funds. Order lifecycle is merchant-driven: status, tracking, and notifications are updated manually by the merchant through the Halava dashboard. Application-gated — Halava approves each merchant individually. No payment intermediation or dispute intermediation. See [[merchant-managed-payment]]. |
| **Pay at Pickup** | Fulfilment method — consumer places a digital order and pays cash in person when collecting. Halava manages the full order lifecycle. No transaction processing fee applies. |
| **Basic Digital Order Fee** | The fixed ¥30 per-order component of the Transaction Processing combined fee. Applies to all digitally-originated orders (app, web, QR table) regardless of payment method. Waived in free tier (first 50 orders/month for Shop; first 100/month for Restaurant Operations). Future services define their own free tier thresholds. Mutually exclusive with POS Transaction (determined by order origin). See [[payment-gateway/transaction-processing]]. |
| **POS Transaction** | Billing SKU — per in-store POS transaction, tiered volume pricing with a free tier (POS service). See [[pos/transaction]]. |
| **Transaction Processing** | Billing SKU — percentage of order value, bundled with the ¥30 Basic Digital Order Fee into a single combined order fee. Two % rates: Halava Pay (4.0% flat, Phase 2+) and Merchant-Managed (0.95%–0.4% tiered). Pay at Pickup: ¥30 fixed only, no % component. See [[payment-gateway/transaction-processing]] for the canonical combined fee reference. |
| **Unified Item Model** | Shared product/menu item structure supporting hybrid businesses |

---

## Payment Phases

| Phase | Description |
|-------|-------------|
| **Phase 1** | MVP — No 資金移動業 license; Halava cannot legally intermediate payments. Merchant-Managed Payment is the only digital payment option. Honor-based monthly invoicing. |
| **Phase 2** | Stripe Connect integration — Stripe's regulatory coverage enables Halava Pay without Halava holding its own license. Merchant-Managed remains as a permanent "bring your own payment" option. |
| **Phase 3** | Survey and potential migration: Adyen, KOMOJU, or GMO-PG (fincode byGMO) — triggered when Stripe's flat rate creates measurable margin pressure. Decision based on operational data from Phase 2. See [[payment-processors]]. |

---

#halava #reference #glossary
