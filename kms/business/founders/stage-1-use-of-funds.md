# Halava Stage 1 Use of Funds (JPY 3M)

> Last updated: March 9, 2026
> Status: Working budget proposal
>
> Related documents:
> - [[founder-structure]]
> - [[milestone-earn-in-schedule]]

---

## 1. Budget Purpose

Stage `1` funding (`JPY 3,000,000`) is for build-to-launch execution from **March 2026 through August 2026**.

Primary uses:

- Founder part-time salary
- Cloud and operating services for MVP development and launch readiness
- Additional part-time contributor when founder capacity is no longer sufficient for agreed milestones

If any portion of the `JPY 3,000,000` is not used by launch, the remainder stays in Halava as company reserve for post-launch operations.

---

## 2. Labor Rate Assumptions

- Founder part-time rate: `JPY 1,500/hour`
- Additional part-time rate: `JPY 1,200/hour`
- Weekly limit per person: `28 hours/week`
- Month conversion used for estimates: exact annual average `52/12 = 4.333333... weeks/month`

Estimated monthly labor cost at cap:

- Founder (`28h/week`): `JPY 182,000/month`
- Additional part-time (`28h/week`): `JPY 145,600/month`

---

## 3. Cloud and Service Cost Estimate (Realistic MVP)

This estimate is aligned with the current architecture assumptions (frontend hosting, API hosting, managed Postgres, cache, object storage, email, maps, and monitoring).

| Cost Item                   | Baseline Monthly       | Typical Range                 |
| --------------------------- | ---------------------- | ----------------------------- |
| Frontend hosting and CDN    | `JPY 3,000`            | `JPY 2,000-6,000`             |
| API compute and runtime     | `JPY 8,000`            | `JPY 5,000-15,000`            |
| Managed Postgres and backup | `JPY 7,000`            | `JPY 5,000-12,000`            |
| Redis/cache                 | `JPY 2,000`            | `JPY 1,000-4,000`             |
| Object storage and egress   | `JPY 2,000`            | `JPY 1,000-5,000`             |
| Email service               | `JPY 2,000`            | `JPY 1,000-5,000`             |
| Maps/geocoding              | `JPY 3,000`            | `JPY 0-8,000`                 |
| Monitoring/logging          | `JPY 4,000`            | `JPY 2,000-8,000`             |
| Domain/DNS/misc tooling     | `JPY 2,000`            | `JPY 1,000-4,000`             |
| **Total**                   | **`JPY 33,000/month`** | **`JPY 20,000-67,000/month`** |

Working planning baseline for Stage `1`: `JPY 33,000/month`.

---

## 4. Stage 1 March-August Spend Scenarios (6 Months)

| Scenario | Monthly Burn | Total Spend (Mar-Aug) | Remaining from `JPY 3M` at Launch |
|---------|---------------|-----------------------|-------------------------------------|
| Founder only (`28h/week`) + cloud baseline | `JPY 215,000` | `JPY 1,290,000` | `JPY 1,710,000` |
| Founder (`28h/week`) + additional part-time (`14h/week`) + cloud baseline | `JPY 287,800` | `JPY 1,726,800` | `JPY 1,273,200` |
| Founder (`28h/week`) + additional part-time (`20h/week`) + cloud baseline | `JPY 319,000` | `JPY 1,914,000` | `JPY 1,086,000` |
| Founder (`28h/week`) + additional part-time (`28h/week`) + cloud baseline | `JPY 360,600` | `JPY 2,163,600` | `JPY 836,400` |

---

## 5. Funding Priority and Control Rules

Priority order for Stage `1` spending:

1. Founder part-time salary within approved hour cap
2. Cloud and operating services required for MVP delivery and launch
3. Additional part-time contributor, only if projected runway remains sufficient for launch plan

Control rule:

- Default Stage `1` staffing model is founder-only from March to August.
- Additional part-time support is added when the founder cannot sustain delivery against agreed milestones.
- Any decision to add another part-time contributor should be made after discussion between founder and co-founder and recorded in writing by message or meeting note.
- Additional part-time hours should be increased only when projected remaining budget is still aligned with the launch timeline and agreed milestones.
- Founder Stage `1` part-time rate is fixed at `JPY 1,500/hour` for March-August 2026.
- Any change to founder salary rate is reviewed at Stage `2` and requires written approval by both founder and co-founder.
- Co-founder receives no Stage `1` salary by default; co-founder economics in Stage `1` are through equity earn-in under [[milestone-earn-in-schedule]].

Reserve rule:

- Unused Stage `1` balance at launch is retained by Halava as operating reserve and is not distributed as founder payout.

---

## 6. Monthly Budget Tracking

Monthly review should include:

- actual founder hours and payout
- actual additional part-time hours and payout
- actual cloud/services spend vs baseline
- updated runway projection based on remaining Stage `1` balance
- launch ETA vs runway

---

#halava #business #founders #budget #use-of-funds
