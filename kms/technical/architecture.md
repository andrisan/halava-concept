# Halava Technical Architecture

> **Last updated:** February 2026
> **Status:** Active specification
>
> **Related documents:**
> - [[web-app-spec]] — Detailed product specification
> - [[data-model]] — Database schema documentation
> - [[api-spec]] — API contracts and examples

---

## 1. System Overview

Halava is a Progressive Web App (PWA) with a monolithic API backend, designed for rapid MVP development with clear paths for future scaling.

### 1.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              CLIENTS                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│  Consumer Web App │ Merchant Dashboard │ POS Interface │ Admin Dashboard    │
│  (PWA)            │ (PWA)              │ (PWA)         │ (Web)              │
└────────────────────────────────┬────────────────────────────────────────────┘
                                 │ HTTPS
                                 ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              API GATEWAY / CDN                               │
│  CDN (Static assets, PWA shell, images)                                     │
│  Rate Limiting │ SSL Termination │ Request Routing                          │
└────────────────────────────────┬────────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              APPLICATION LAYER                               │
│  HALAVA API SERVER                                                          │
│  Auth │ Consumer │ Merchant │ Admin │ Directory │ Marketplace │ POS        │
└────────────────────────────────┬────────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              DATA LAYER                                      │
│  PostgreSQL + PostGIS │ Redis (Cache) │ Object Storage (S3) │ Search        │
└────────────────────────────────┬────────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              EXTERNAL SERVICES                               │
│  Email (Resend) │ Maps (Mapbox) │ Payment (Phase 2: Stripe) │ Analytics     │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Component Responsibilities

### 2.1 Frontend Applications

| Application | Users | Key Responsibilities |
|-------------|-------|---------------------|
| **Consumer Web App** | End consumers | Browse, search, order, cart, purchase history |
| **Merchant Dashboard** | Merchant owners, staff | Listings, products, inventory, orders, capabilities |
| **POS Interface** | Cashiers, staff | In-store sales, receipts, offline operation |
| **Admin Dashboard** | Admins, moderators | User management, moderation, platform config |

### 2.2 API Server Modules

| Module | Responsibilities |
|--------|-----------------|
| **Auth Module** | Magic link, OTP, JWT, session management, RBAC |
| **Consumer Module** | User profiles, saved items, purchase history |
| **Merchant Module** | Business profiles, capability management, staff |
| **Directory Module** | Place listings, geo-search, halal status |
| **Marketplace Module** | Product catalog, cart, checkout, orders, group purchases |
| **POS Module** | Transactions, receipts, offline sync, quota management |
| **Notification Module** | In-app notifications, email dispatch |

---

## 3. Technology Stack

### 3.1 Frontend Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Framework** | Next.js 14+ (App Router) | SSR for SEO, React ecosystem |
| **Language** | TypeScript | Type safety |
| **Styling** | Tailwind CSS | Utility-first, rapid prototyping |
| **UI Components** | shadcn/ui | Accessible, customizable |
| **State Management** | Zustand + TanStack Query | Lightweight client + server state |
| **Maps** | Mapbox GL JS | Geo-based discovery |
| **PWA** | next-pwa / Workbox | Offline capability |

### 3.2 Backend Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Runtime** | Node.js 20+ | JavaScript ecosystem, async I/O |
| **Framework** | Hono or Fastify | Lightweight, TypeScript-first |
| **ORM** | Drizzle ORM or Prisma | Type-safe queries |
| **Validation** | Zod | Shared schemas frontend/backend |
| **Authentication** | Custom (magic link + JWT) | Simple, passwordless |
| **Job Queue** | BullMQ (Redis-backed) | Background jobs |

### 3.3 Infrastructure Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Hosting** | Vercel (frontend) + Railway (API) | Easy deployment |
| **Database** | Neon or Supabase (Postgres) | Managed with PostGIS |
| **Cache** | Upstash Redis | Serverless, pay-per-use |
| **Object Storage** | Cloudflare R2 or AWS S3 | Cost-effective |
| **CDN** | Cloudflare or Vercel Edge | Static delivery |
| **Email** | Resend or SendGrid | Transactional email |
| **Monitoring** | Sentry (errors) + Axiom (logs) | Error tracking |

---

## 4. Deployment Architecture

### 4.1 Environment Topology

| Environment | Frontend | API | Database |
|-------------|----------|-----|----------|
| **Production** | Vercel | Railway | Neon Postgres |
| **Staging** | Vercel Preview | Railway | Separate Neon branch |
| **Development** | Local | Local | Docker Postgres |

### 4.2 Deployment Pipeline

```
Push → CI Build → Test Suite → Deploy Preview → Manual Approve → Staging → Prod
```

- `main` branch → Production (manual approval)
- `staging` branch → Staging (auto-deploy)
- Pull requests → Preview deployments

---

## 5. Security Architecture

### 5.1 Authentication Flow

```
Enter Email → Send Magic Link → Click Link → Verify Token → Issue JWT → Store in Cookie
```

**Token structure:**
- Access token: 15 minutes (stateless JWT)
- Refresh token: 7 days (HTTP-only cookie)

### 5.2 Authorization Model

- **Consumer:** Basic user access
- **Merchant Owner:** Full merchant access
- **Merchant Staff:** POS + limited dashboard
- **Moderator:** Content moderation
- **Admin:** Full platform access

### 5.3 Data Security

| Concern | Implementation |
|---------|----------------|
| **Data in transit** | TLS 1.3 |
| **Data at rest** | Database encryption |
| **Secrets** | Environment variables via platform secrets |
| **Input validation** | Zod schemas on all inputs |
| **SQL injection** | ORM with parameterized queries |
| **XSS prevention** | React escaping, CSP headers |

---

## 6. POS Offline Architecture

> See [[pages-navigation-ux-spec#POS Screen]] for UI details.

### 6.1 Offline Sync Flow

1. POS UI stores transactions in IndexedDB
2. Service Worker detects online/offline status
3. Online: Sync immediately to server
4. Offline: Queue locally, sync when reconnected

### 6.2 Conflict Resolution Strategy

| Field Type | Resolution Strategy |
|------------|---------------------|
| **Stock quantities** | Merchant review required (alert) |
| **Product metadata** | Last-write-wins with timestamp |
| **Prices** | Server authoritative |
| **Transaction data** | Append-only, no conflicts |

---

## 7. Non-Functional Requirements

### 7.1 Performance

| Requirement | Target | Implementation |
|-------------|--------|----------------|
| Search p95 latency | < 500ms | PostGIS geo-index, Postgres FTS, Redis caching |
| POS actions p95 latency | < 300ms | Local-first IndexedDB, async sync |
| Page load (LCP) | < 2.5s | SSR, CDN, optimized images |
| API response p95 | < 200ms | Connection pooling, query optimization |

### 7.2 Reliability

| Requirement | Target | Implementation |
|-------------|--------|----------------|
| Availability | 99.5% uptime | Managed services, health checks, auto-restart |
| POS offline reliability | 99.9% | Local-first IndexedDB, Service Worker |
| Recovery Time Objective (RTO) | < 4 hours | Automated backups, recovery runbooks |
| Recovery Point Objective (RPO) | < 1 hour | Point-in-time recovery, transaction logs |

### 7.3 Security & Compliance

| Requirement | Implementation |
|-------------|----------------|
| Data encryption in transit | TLS 1.3 |
| Data encryption at rest | Database-level encryption |
| Secure file uploads | Pre-signed URLs, file type validation |
| Audit logging | All admin/mod actions logged with actor, timestamp |
| Privacy compliance | Japan's APPI (Act on Protection of Personal Information) |
| Session security | HTTP-only cookies, CSRF protection |

### 7.4 Scalability

| Trigger | Action |
|---------|--------|
| API latency > 500ms p95 | Horizontal scaling, read replicas |
| Database connections > 80% | Connection pooling (PgBouncer) |
| Search latency > 1s | Dedicated search (Meilisearch) |
| 10+ regions | Regional deployments, edge caching |

### 7.5 Mobile Strategy

**Progressive Web App (PWA)**
- Installable on mobile devices
- Offline-capable (POS, cached content)
- Push notifications (Phase 2)
- App-like experience without app store

---

## 8. Future Architecture Considerations

### 8.1 Phase 2 Additions

- **Payment provider integration:** Stripe Connect webhook handlers
- **Real-time updates:** WebSocket or SSE for order status

### 8.2 Scaling Triggers

| Trigger | Action |
|---------|--------|
| API latency > 500ms p95 | Horizontal scaling, read replicas |
| Database connections > 80% | Connection pooling (PgBouncer) |
| Search latency > 1s | Dedicated search (Meilisearch) |
| 10+ regions | Regional deployments, edge caching |

### 8.3 Modular Monolith Architecture

Halava is developed as a **modular monolith** — a single deployable application with strict internal module boundaries, designed for future microservices migration.

#### Development Principles

| Principle | Description |
|-----------|-------------|
| **Module boundaries** | Each module (Auth, Consumer, Merchant, Directory, Marketplace, POS, Notification) has clear boundaries |
| **Interface-based communication** | Modules communicate through defined service interfaces, not direct imports |
| **Data ownership** | Each module owns its tables; no cross-module direct DB queries |
| **No circular dependencies** | Module dependency graph must be acyclic |
| **Shared kernel** | Only common types, utilities, and base models in shared layer |

#### Developer Quick Reference

**Folder Structure:**

```
src/
├── modules/
│   ├── auth/
│   │   ├── auth.service.ts       # Public interface (import this)
│   │   ├── auth.routes.ts
│   │   └── internal/             # Private (never import from outside)
│   ├── marketplace/
│   │   ├── marketplace.service.ts
│   │   └── internal/
│   ├── consumer/
│   ├── merchant/
│   ├── directory/
│   ├── pos/
│   └── notification/
├── shared/                       # Shared kernel
│   ├── types/                    # Common TypeScript types
│   ├── utils/                    # Pure utility functions
│   └── db/                       # Database client only
└── app.ts
```

**Module Rules (MVP):**

1. **Import from `*.service.ts` only** — Never import from another module's `internal/`
2. **No cross-module DB queries** — Need merchant data? Call `merchantService`, don't query their tables
3. **Shared = pure utilities** — No business logic in `shared/`, only types and helpers
4. **Events for side effects** — Don't call Notification directly; emit events instead
5. **One module owns each table** — If unsure, ask: "Who is responsible for this data?"

**ESLint Enforcement (optional):**

```javascript
// .eslintrc.js
rules: {
  'no-restricted-imports': ['error', {
    patterns: ['**/internal/*']
  }]
}
```

#### Module Dependency Rules

```
┌─────────────────────────────────────────────────┐
│                    Admin                         │
├─────────────────────────────────────────────────┤
│  Consumer  │  Merchant  │  Directory  │  POS    │
├─────────────────────────────────────────────────┤
│              Marketplace (core)                  │
├─────────────────────────────────────────────────┤
│           Notification (event-driven)            │
├─────────────────────────────────────────────────┤
│                Auth (foundation)                 │
├─────────────────────────────────────────────────┤
│              Shared Kernel (types)               │
└─────────────────────────────────────────────────┘
```

- Upper layers may depend on lower layers
- Same-level modules must not directly depend on each other
- Cross-module communication via service interfaces or events

#### Microservices Migration Triggers

| Trigger | Action |
|---------|--------|
| Team grows to 5+ engineers | Consider splitting by module ownership |
| Module requires independent scaling | Extract as separate service |
| Different tech stack needed | Extract module with appropriate stack |
| Deployment independence required | Extract critical modules first (POS, Auth) |

#### Migration Path

1. **Current (MVP):** Modular monolith with clear boundaries
2. **Phase 2:** Extract Notification module (event-driven, low coupling)
3. **Phase 3+:** Extract POS, Marketplace based on scaling needs

#### Files Affected by Future Migration

When microservices migration happens, the following files will need updates:

**Primary (architecture changes):**
- [[architecture]] — Update system diagram to show separate services
- [[data-model]] — Document data ownership per service
- [[api-spec]] — Split into per-service API contracts

**Secondary (reference updates):**
- [[web-app-spec]] — Update module references
- [[roadmap]] — Add migration phases
- [[pos]] — POS service architecture
- [[marketplace]] — Core service interactions
- [[notifications]] — Event service architecture

---

#halava #technical #architecture
