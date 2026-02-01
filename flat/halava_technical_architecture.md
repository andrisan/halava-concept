# Halava Technical Architecture

> **Last updated:** February 2026
> **Status:** Active specification
>
> **Related documents:**
> - [halava_web_app_spec_canvas.md](halava_web_app_spec_canvas.md) — Detailed product specification
> - [halava_api_spec.md](halava_api_spec.md) — API contracts and examples

---

## 1. System Overview

Halava is a Progressive Web App (PWA) with a monolithic API backend, designed for rapid MVP development with clear paths for future scaling.

### 1.1 High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              CLIENTS                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  Consumer    │  │  Merchant    │  │  POS         │  │  Admin       │    │
│  │  Web App     │  │  Dashboard   │  │  Interface   │  │  Dashboard   │    │
│  │  (PWA)       │  │  (PWA)       │  │  (PWA)       │  │  (Web)       │    │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘    │
│         │                 │                 │                 │             │
│         └─────────────────┴────────┬────────┴─────────────────┘             │
│                                    │                                         │
└────────────────────────────────────┼─────────────────────────────────────────┘
                                     │ HTTPS
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              API GATEWAY / CDN                               │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  CDN (Static assets, PWA shell, images)                             │    │
│  │  Rate Limiting │ SSL Termination │ Request Routing                  │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
└────────────────────────────────────┬─────────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              APPLICATION LAYER                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      HALAVA API SERVER                               │    │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │    │
│  │  │ Auth        │ │ Consumer    │ │ Merchant    │ │ Admin       │   │    │
│  │  │ Module      │ │ Module      │ │ Module      │ │ Module      │   │    │
│  │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘   │    │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │    │
│  │  │ Directory   │ │ Marketplace │ │ POS         │ │ Notification│   │    │
│  │  │ Module      │ │ Module      │ │ Module      │ │ Module      │   │    │
│  │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘   │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
└────────────────────────────────────┬─────────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              DATA LAYER                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  PostgreSQL  │  │  Redis       │  │  Object      │  │  Search      │    │
│  │  (Primary)   │  │  (Cache/     │  │  Storage     │  │  (Postgres   │    │
│  │  + PostGIS   │  │   Sessions)  │  │  (S3/R2)     │  │   FTS/       │    │
│  │              │  │              │  │              │  │   Meilisearch)│   │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              EXTERNAL SERVICES                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  Email       │  │  Maps        │  │  Payment     │  │  Analytics   │    │
│  │  (Resend/    │  │  (Mapbox/    │  │  (Phase 2:   │  │  (Posthog/   │    │
│  │   SendGrid)  │  │   Google)    │  │   Stripe)    │  │   Plausible) │    │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Component Responsibilities

### 2.1 Frontend Applications

| Application | Users | Key Responsibilities |
|-------------|-------|---------------------|
| **Consumer Web App** | End consumers | Browse directory, search products, place orders, manage cart, view purchase history, group purchase coordination |
| **Merchant Dashboard** | Merchant owners, staff | Manage listings, products, inventory, orders, POS settings, capabilities, staff |
| **POS Interface** | Cashiers, staff | Process in-store sales, generate receipts, scan consumer QR codes, offline operation |
| **Admin Dashboard** | Admins, moderators | User management, content moderation, platform configuration, audit logs |

**Shared characteristics:**
- Progressive Web App (PWA) for installability
- Responsive design (mobile-first for Consumer and POS)
- Service worker for offline capability (critical for POS)
- Common component library for UI consistency

### 2.2 API Server Modules

| Module | Responsibilities |
|--------|-----------------|
| **Auth Module** | Magic link generation, OTP verification, JWT issuance/validation, session management, role-based access control |
| **Consumer Module** | User profiles, saved items, purchase history, consumer-facing search queries |
| **Merchant Module** | Business profiles, capability management, staff management, merchant-facing analytics |
| **Directory Module** | Place listings, geo-search, halal status disclosure, opening hours, photos |
| **Marketplace Module** | Product catalog, cart management, checkout flow, order lifecycle, group purchases |
| **POS Module** | Transaction processing, receipt generation, offline sync, consumer linking, quota management |
| **Notification Module** | In-app notifications, email dispatch, notification preferences |
| **Admin Module** | Moderation queue, user/merchant administration, audit logging, platform settings |

### 2.3 Data Stores

| Store | Purpose | Rationale |
|-------|---------|-----------|
| **PostgreSQL + PostGIS** | Primary database, relational data, geo-queries | Mature, reliable, excellent geo support, single-store simplicity |
| **Redis** | Session cache, rate limiting, job queues, POS sync buffer | Fast, well-understood, handles ephemeral data |
| **Object Storage (S3/R2)** | Product images, merchant logos, halal evidence documents | Scalable, cost-effective, CDN-friendly |
| **Search (Postgres FTS / Meilisearch)** | Product search, directory search | Postgres FTS for MVP; Meilisearch if search complexity grows |

---

## 3. Technology Stack

### 3.1 Frontend Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Framework** | Next.js 14+ (App Router) | SSR for SEO, React ecosystem, excellent DX, built-in API routes option |
| **Language** | TypeScript | Type safety, better IDE support, reduced runtime errors |
| **Styling** | Tailwind CSS | Utility-first, rapid prototyping, consistent design tokens |
| **UI Components** | shadcn/ui | Accessible, customizable, Tailwind-based |
| **State Management** | Zustand + TanStack Query | Lightweight client state + server state with caching |
| **Forms** | React Hook Form + Zod | Performant forms with schema validation |
| **Maps** | Mapbox GL JS or Google Maps | Geo-based discovery, merchant locations |
| **PWA** | next-pwa / Workbox | Offline capability, installability |

### 3.2 Backend Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Runtime** | Node.js 20+ | JavaScript ecosystem, async I/O, large talent pool |
| **Framework** | Hono or Fastify | Lightweight, fast, TypeScript-first |
| **Language** | TypeScript | Shared types with frontend, type safety |
| **ORM** | Drizzle ORM or Prisma | Type-safe database queries, migrations |
| **Validation** | Zod | Shared schemas between frontend and backend |
| **Authentication** | Custom (magic link + JWT) | Simple, passwordless, no third-party dependency |
| **Job Queue** | BullMQ (Redis-backed) | Background jobs: emails, sync, cleanup |
| **API Documentation** | OpenAPI / Swagger | Auto-generated from code, client SDK generation |

### 3.3 Infrastructure Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Hosting** | Vercel (frontend) + Railway/Render (API) | Easy deployment, auto-scaling, cost-effective for MVP |
| **Database** | Neon or Supabase (Postgres) | Managed Postgres with PostGIS, serverless scaling |
| **Cache** | Upstash Redis | Serverless Redis, pay-per-use, global edge |
| **Object Storage** | Cloudflare R2 or AWS S3 | Cost-effective, S3-compatible |
| **CDN** | Cloudflare or Vercel Edge | Static asset delivery, DDoS protection |
| **Email** | Resend or SendGrid | Transactional email, magic links, order notifications |
| **Monitoring** | Sentry (errors) + Axiom (logs) | Error tracking, structured logging |
| **Analytics** | PostHog or Plausible | Privacy-friendly, product analytics |

### 3.4 Alternative Stack Consideration

**Monorepo with full-stack framework:**

| Alternative | Technology | Trade-offs |
|-------------|------------|------------|
| **Full-stack** | Next.js API Routes | Simpler deployment, but tighter coupling; suitable for small team |
| **Backend** | Elixir/Phoenix | Better concurrency, but smaller talent pool |

**Decision:** PWA + separate API server for clean separation.

---

## 4. Deployment Architecture

### 4.1 Environment Topology

```
┌─────────────────────────────────────────────────────────────────┐
│                         PRODUCTION                               │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐         │
│  │  Frontend   │    │  API        │    │  Database   │         │
│  │  (Vercel)   │────│  (Railway)  │────│  (Neon)     │         │
│  │             │    │             │    │             │         │
│  │  cdn.halava │    │  api.halava │    │  postgres   │         │
│  └─────────────┘    └─────────────┘    └─────────────┘         │
│                            │                                    │
│                     ┌──────┴──────┐                            │
│                     │   Redis     │                            │
│                     │  (Upstash)  │                            │
│                     └─────────────┘                            │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                          STAGING                                 │
├─────────────────────────────────────────────────────────────────┤
│  Same topology as production, separate instances                 │
│  staging.halava.app / api-staging.halava.app                    │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                        DEVELOPMENT                               │
├─────────────────────────────────────────────────────────────────┤
│  Local development with Docker Compose                           │
│  - PostgreSQL + PostGIS container                               │
│  - Redis container                                              │
│  - MinIO (S3-compatible) for local object storage               │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 Deployment Pipeline

```
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│  Push    │────▶│  CI      │────▶│  Test    │────▶│  Deploy  │
│  to Git  │     │  Build   │     │  Suite   │     │  Preview │
└──────────┘     └──────────┘     └──────────┘     └────┬─────┘
                                                        │
                                                        ▼
                                                  ┌──────────┐
                                                  │  Manual  │
                                                  │  Approve │
                                                  └────┬─────┘
                                                        │
                                           ┌────────────┴────────────┐
                                           ▼                         ▼
                                     ┌──────────┐              ┌──────────┐
                                     │  Deploy  │              │  Deploy  │
                                     │  Staging │──────────────│  Prod    │
                                     └──────────┘   (after     └──────────┘
                                                    staging OK)
```

**CI/CD tooling:** GitHub Actions

**Deployment triggers:**
- `main` branch → Production (manual approval required)
- `staging` branch → Staging (auto-deploy)
- Pull requests → Preview deployments

### 4.3 Scaling Strategy

**MVP (Stage 1):**
- Single API instance (auto-scaled by platform)
- Single database with read replicas if needed
- CDN for static assets

**Growth (Stage 2+):**
- Horizontal API scaling (stateless design)
- Read replicas for database
- Redis cluster for high availability
- Consider regional deployments for latency

---

## 5. Security Architecture

### 5.1 Authentication Flow

```
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│  User    │────▶│  Enter   │────▶│  Send    │────▶│  User    │
│  Opens   │     │  Email   │     │  Magic   │     │  Clicks  │
│  App     │     │          │     │  Link    │     │  Link    │
└──────────┘     └──────────┘     └──────────┘     └────┬─────┘
                                                        │
                                                        ▼
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│  App     │◀────│  Store   │◀────│  Issue   │◀────│  Verify  │
│  Ready   │     │  JWT in  │     │  JWT     │     │  Token   │
│          │     │  Cookie  │     │          │     │          │
└──────────┘     └──────────┘     └──────────┘     └──────────┘
```

**Token structure:**
- Access token: Short-lived (15 minutes), stateless JWT
- Refresh token: Long-lived (7 days), stored in HTTP-only cookie

### 5.2 Authorization Model

```
┌─────────────────────────────────────────────────────────────┐
│                      ROLE HIERARCHY                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Admin ──────────────────────────────────────────┐          │
│    │                                             │          │
│    ├── Moderator ──────────────────────┐         │          │
│    │                                   │         │          │
│    │                           ┌───────┴───────┐ │          │
│    │                           │               │ │          │
│    ▼                           ▼               ▼ ▼          │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │Consumer │  │Merchant │  │Merchant │  │Platform │        │
│  │         │  │Owner    │  │Staff    │  │Config   │        │
│  └─────────┘  └────┬────┘  └─────────┘  └─────────┘        │
│                    │                                        │
│                    └── Staff inherits subset of Owner       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

**Permission checks:** Middleware-based, role + resource ownership validation

### 5.3 Data Security

| Concern | Implementation |
|---------|----------------|
| **Data in transit** | TLS 1.3 for all connections |
| **Data at rest** | Database encryption (managed service), encrypted object storage |
| **Secrets management** | Environment variables via platform secrets, never in code |
| **Input validation** | Zod schemas on all API inputs |
| **SQL injection** | ORM with parameterized queries |
| **XSS prevention** | React's automatic escaping, CSP headers |
| **CSRF protection** | SameSite cookies, origin validation |

---

## 6. POS Offline Architecture

### 6.1 Offline Sync Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    POS CLIENT (Browser)                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │  POS UI     │───▶│  Local      │───▶│  Service    │      │
│  │  (React)    │    │  IndexedDB  │    │  Worker     │      │
│  └─────────────┘    └─────────────┘    └──────┬──────┘      │
│                                                │             │
│                                          ┌─────┴─────┐       │
│                                          │ Online?   │       │
│                                          └─────┬─────┘       │
│                                    ┌───────────┴───────────┐ │
│                                    │                       │ │
│                               ┌────▼────┐            ┌─────▼─┐
│                               │ Sync to │            │ Queue │
│                               │ Server  │            │ Local │
│                               └─────────┘            └───────┘
│                                                              │
└─────────────────────────────────────────────────────────────┘
                                     │
                                     │ When online
                                     ▼
┌─────────────────────────────────────────────────────────────┐
│                         API SERVER                           │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │  Receive    │───▶│  Process    │───▶│  Detect     │      │
│  │  Batch      │    │  Transactions│   │  Conflicts  │      │
│  └─────────────┘    └─────────────┘    └──────┬──────┘      │
│                                                │             │
│                                    ┌───────────┴───────────┐ │
│                                    │                       │ │
│                               ┌────▼────┐            ┌─────▼─┐
│                               │ Apply   │            │ Flag  │
│                               │ Normal  │            │ Review│
│                               └─────────┘            └───────┘
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 6.2 Conflict Resolution Strategy

| Field Type | Resolution Strategy |
|------------|---------------------|
| **Stock quantities** | Merchant review required (alert generated) |
| **Product metadata** | Last-write-wins with timestamp |
| **Prices** | Server authoritative (POS refreshes on sync) |
| **Transaction data** | Append-only, no conflicts possible |

---

## 7. Non-Functional Requirements Implementation

| Requirement | Target | Implementation |
|-------------|--------|----------------|
| **Search p95 < 500ms** | 500ms | PostGIS geo-index, Postgres FTS index, Redis caching for hot queries |
| **POS actions p95 < 300ms** | 300ms | Local-first IndexedDB, async sync, optimistic UI updates |
| **Uptime 99.5%** | 99.5% | Managed services, health checks, auto-restart, POS offline mode |
| **RTO < 4 hours** | 4 hours | Automated backups, documented recovery procedures |
| **RPO < 1 hour** | 1 hour | Point-in-time recovery, transaction log backups |

---

## 8. Future Architecture Considerations

### 8.1 Phase 2 Additions

- **Payment provider integration:** Stripe Connect webhook handlers, connected account management
- **Real-time updates:** WebSocket or Server-Sent Events for order status, POS sync

### 8.2 Scaling Triggers

| Trigger | Action |
|---------|--------|
| API latency > 500ms p95 | Horizontal scaling, database read replicas |
| Database connections > 80% | Connection pooling (PgBouncer), read replicas |
| Search latency > 1s | Migrate to dedicated search (Meilisearch, Elasticsearch) |
| 10+ regions | Regional deployments, edge caching |

---

*This document should be updated as architectural decisions are made and validated.*

*Last updated: February 2026*
