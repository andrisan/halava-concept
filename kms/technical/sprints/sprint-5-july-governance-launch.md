# Sprint 5 — Governance and Launch (July 2026)

> **Period:** July 1 – July 31, 2026
> **Goal:** complete internal operations, platform governance, and production launch readiness
> **Strategy:** [[sprint-strategy]]

```mermaid
gantt
    title Sprint 5 — July 2026
    dateFormat YYYY-MM-DD
    axisFormat %d

    section Governance
    Moderator Workspace                 :a1, 2026-07-01, 2026-07-08
    Admin Operations                    :a2, 2026-07-05, 2026-07-14
    Escalations and Announcements       :a3, 2026-07-10, 2026-07-18

    section Launch Readiness
    Full Feature Revalidation           :b1, 2026-07-12, 2026-07-25
    End-to-End QA and Hardening         :b2, 2026-07-12, 2026-07-26
    Data Migration and Seed Imports     :b3, 2026-07-18, 2026-07-27
    Go-live Readiness                   :b4, 2026-07-24, 2026-07-31
```

| Workstream | Feature Coverage | Target Outcomes |
|------------|------------------|-----------------|
| Moderator workspace | Admin & Moderation (moderator) | Reports queue, content review, moderation actions, audit log |
| Admin operations | Admin & Moderation (admin) | User management, merchant management, platform health views |
| Escalations and announcements | Admin governance | Escalation handling, platform settings, announcements, maintenance controls |
| Full feature revalidation | All features in [[sprint-strategy#Sprint Coverage Matrix]] | Every feature is rechecked with integration tests, contract checks, data integrity checks, and cross-role scenario validation |
| End-to-end QA and hardening | Cross-product | Regression suite, performance, security, i18n completeness, operational monitoring |
| Data migration and seed imports | Launch readiness | Merchant import, place data, catalog seeding, starter app catalog, staged rollout data |
| Go-live readiness | Launch readiness | Runbooks, support handoff, incident response, release checklist, production cutover |

## Sprint 5 Recheck Matrix

| Domain | Required Recheck in Sprint 5 |
|--------|-------------------------------|
| Shared features | Integration tests for authentication, onboarding, RBAC, capabilities, notifications, and i18n across consumer and merchant paths |
| Consumer features | End-to-end tests for directory, marketplace checkout, group order, BOPU, saved items, reviews, messaging, and purchase record linking |
| Merchant features | Integration tests for products, order management, inventory, POS, promotions, restaurant operations, accounting, reservations, and advanced POS |
| Platform and apps | Integration tests for app platform, Expense Insight, launch apps, billing and membership, moderation, and admin operations |
| Cross-cutting | API contract checks, migration verification, data consistency checks, monitoring and alert checks, and role-permission regression tests |

## Sprint 5 Exit Criteria

- Moderators and admins can operate the platform without direct database intervention.
- Every feature in [[sprint-strategy#Sprint Coverage Matrix]] passes Sprint 5 integration recheck.
- Core user, merchant, POS, restaurant, analytics, billing, and app flows pass end-to-end validation.
- Blocking defects from full-feature recheck are resolved or explicitly deferred with approved risk notes.
- Launch runbooks, support readiness, and rollback paths are complete.

---

#halava #sprint #july #governance #launch
