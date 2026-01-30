# Halava Risk Assessment

> **Last updated:** January 2026
> **Status:** Active risk tracking document
>
> **Related documents:**
> - `halava_web_app_spec_canvas.md` — Detailed product specification
> - `halava_monetization_pricing_strategy_summary.md` — Pricing, fees, and investment staging
> - `halava_market_validation.md` — Market research and validation tracking

---

## 1. Business Risks

### 1.1 Revenue Collection Risks

| Risk | Likelihood | Impact | Mitigation | Owner | Status |
|------|-----------|--------|------------|-------|--------|
| **Honor-based fee collection fails (Phase 1)** | Medium | High | Early invoicing (day 1 of following month), relationship-based trust via B2B network, clear ToS with payment terms, escalation path for non-payment | Ops | Active |
| **Merchants route orders off-platform** | Medium | Medium | Build platform value (analytics, purchase history, trust signals), track order-to-listing ratio anomalies, merchant success outreach | Product | Active |
| **High GMV merchants negotiate unsustainable rates** | Low | Medium | Tiered pricing already accommodates volume; floor rate at 2.5%; enterprise negotiations require break-even analysis | Finance | Planned |

### 1.2 Growth Risks

| Risk | Likelihood | Impact | Mitigation | Owner | Status |
|------|-----------|--------|------------|-------|--------|
| **Low consumer adoption** | Medium | High | Group purchase virality, in-store QR exposure, SEO for halal discovery, B2B network for initial merchant quality | Growth | Active |
| **Insufficient merchant supply** | Medium | High | B2B halal supplier network relationships, low onboarding friction, assisted onboarding (not self-serve) | BD | Active |
| **Group purchase feature underutilized** | Medium | Medium | Clear UX, incentivize initiators, merchant minimum order thresholds, showcase savings | Product | Planned |
| **Geographic concentration limits growth** | Low | Medium | Start in Tokyo/Osaka; expand to other cities as density increases; track demand signals by region | Strategy | Planned |

### 1.3 Competitive Risks

| Risk | Likelihood | Impact | Mitigation | Owner | Status |
|------|-----------|--------|------------|-------|--------|
| **Competitor entry (larger platform adds halal)** | Low | High | First-mover advantage, community trust, niche focus, deep halal expertise, merchant relationships | Strategy | Monitoring |
| **Existing halal apps add commerce** | Medium | Medium | Superior merchant tools (POS, capability model), consumer features (group purchase, unified history) | Product | Monitoring |
| **Price war from funded competitors** | Low | Medium | Sustainable unit economics, focus on value over price, early adopter loyalty | Finance | Planned |

---

## 2. Regulatory Risks

### 2.1 Payment Intermediation

| Risk | Description | Phase | Mitigation |
|------|-------------|-------|------------|
| **Unlicensed fund handling** | Operating as a payment intermediary without proper license | Phase 1-2 | Phase 1: Off-platform settlement (no fund handling). Phase 2: Use licensed provider (Stripe Connect, PAY.JP) with connected accounts model. Halava never holds consumer funds. |
| **資金移動業 (Funds Transfer) license requirements** | Direct payment intermediation requires FSA license | Phase 3 | Phase 3 is long-term (3-5+ years). Only pursue after demonstrating scale and compliance track record. Maintain Phase 2 provider relationship as fallback. |
| **Payment provider compliance** | Provider may change terms, increase fees, or terminate | Phase 2 | Maintain relationships with multiple providers (Stripe, PAY.JP, GMO). Ensure contracts allow reasonable notice period. |

### 2.2 Consumer Protection

| Risk | Description | Mitigation |
|------|-------------|------------|
| **Misleading halal claims** | Merchants may falsely claim halal status | Clear disclaimer: "Halal status is declared by the merchant. Halava does not certify or guarantee halal compliance." Moderator review for reported claims. Evidence publication is optional. |
| **Refund/dispute resolution** | Consumer disputes in off-platform settlement | Phase 1: Halava provides mediation services, non-binding recommendations. Phase 2: Provider handles disputes with buyer protection. |
| **Product safety/quality** | Defective or unsafe products sold | Terms of service hold merchants responsible. Report mechanism for consumers. Repeat offenders suspended. |

### 2.3 Data Privacy (APPI Compliance)

| Requirement | Status | Implementation |
|-------------|--------|----------------|
| **Purpose limitation** | Planned | Clear data collection purposes at signup; no secondary use without consent |
| **Consent collection** | Planned | Explicit opt-in for marketing communications; implicit consent for service delivery |
| **Data access rights** | Planned | User dashboard for viewing collected data; export functionality |
| **Data deletion rights** | Planned | Account deletion removes personal data; anonymized transaction records retained for merchant accounting |
| **Third-party disclosure** | Planned | Merchant receives only order-relevant data; payment provider receives payment-relevant data; no data sales |
| **Security measures** | Planned | Encryption at rest and in transit; access controls; audit logging |

**APPI Compliance Checklist:**
- [ ] Privacy policy drafted and reviewed
- [ ] Cookie consent banner implemented
- [ ] Data processing records maintained
- [ ] Data breach notification procedure documented
- [ ] Cross-border transfer safeguards (if applicable)

---

## 3. Operational Risks

### 3.1 Team & Execution

| Risk | Likelihood | Impact | Mitigation | Status |
|------|-----------|--------|------------|--------|
| **Single founder dependency** | High | Critical | Document key processes, establish co-founder relationship, plan for Stage 2 hires | Active |
| **Founder visa status constraints** | Medium | High | Co-founder serves as legal representative (Stage 1); Operating Founder transitions to employee visa (Stage 2) | Active |
| **Burnout / capacity limits** | Medium | High | Realistic milestone planning, part-time contractor rate (Stage 1), full-time salary (Stage 2+) | Active |
| **Key person unavailability** | Medium | High | Co-founder can maintain basic operations; critical documentation maintained | Planned |

### 3.2 Technical Risks

| Risk | Likelihood | Impact | Mitigation | Status |
|------|-----------|--------|------------|--------|
| **Technical debt accumulation** | Medium | Medium | Code review practices, refactoring allocated in sprints, MVP-first but clean architecture | Active |
| **POS offline sync conflicts** | Medium | Medium | Conflict resolution protocol (merchant review for stock discrepancies), clear UI for conflict states | Planned |
| **Platform outages** | Low | High | 99.5% uptime target, monitoring and alerting, POS offline capability as resilience | Planned |
| **Data loss** | Low | Critical | Daily automated backups, 30-day retention, point-in-time recovery, RTO <4hr / RPO <1hr | Planned |
| **Security breach** | Low | Critical | Security best practices, no PCI scope in Phase 1, regular security review, incident response plan | Planned |

### 3.3 Merchant Support

| Risk | Likelihood | Impact | Mitigation | Status |
|------|-----------|--------|------------|--------|
| **Support capacity exceeded** | Medium | Medium | Self-serve documentation, FAQ, tiered support (Growth/Pro get priority), capacity planning tied to merchant count | Planned |
| **Merchant onboarding bottleneck** | Medium | Medium | Assisted onboarding for initial merchants; develop scalable onboarding as patterns emerge | Active |
| **Merchant churn due to poor experience** | Medium | High | Regular check-ins with pilot merchants, fast issue resolution, feature requests tracked | Active |

---

## 4. Financial Risks

### 4.1 Runway Scenarios

**Stage 1 Capital: ¥3M (7-month runway)**

| Scenario | Monthly Burn | Runway | Key Assumptions |
|----------|-------------|--------|-----------------|
| **Optimistic** | ¥380k | 8 months | Faster development, lower infra costs |
| **Realistic** | ¥430k | 7 months | Base plan execution |
| **Pessimistic** | ¥500k | 6 months | Delays, unexpected costs |

**Stage 1 Allocation:**
- ¥1.5M: Operating Founder compensation
- ¥800k: Infrastructure and tools
- ¥500k: Promotion kits
- ¥200k: Legal setup

### 4.2 Break-Even Analysis

**Phase 1 (MVP) — Monthly break-even:**

| Cost Category | Monthly Amount |
|---------------|----------------|
| Infrastructure (hosting, tools) | ¥50,000 |
| Founder salary (post-Stage 2) | ¥250,000 |
| Operations (support, misc) | ¥50,000 |
| **Total monthly costs** | ¥350,000 |

**Revenue required (at 2% MVP fee rate):**
- Break-even GMV: ¥350,000 / 0.02 = ¥17.5M monthly GMV
- With 50 merchants averaging ¥350k GMV each

**Phase 2 (Payment integration) — Monthly break-even:**

| Cost Category | Monthly Amount |
|---------------|----------------|
| Infrastructure | ¥100,000 |
| Team (3-5 people) | ¥1,000,000 |
| Operations | ¥150,000 |
| **Total monthly costs** | ¥1,250,000 |

**Revenue required (at 5% Phase 2 fee rate):**
- Break-even GMV: ¥1,250,000 / 0.05 = ¥25M monthly GMV
- Plus membership revenue reduces GMV requirement

### 4.3 Contingency Plans

**If Stage 2 funding doesn't proceed:**

| Trigger | Contingency Action |
|---------|-------------------|
| Milestones not met | Extend Stage 1 runway with reduced burn; pivot to consulting/services if needed |
| Co-founder exits | Operating Founder retains 90% equity; seek alternative funding or bootstrap |
| Market conditions change | Adjust go-to-market; consider geographic pivot |

**If Stage 3 funding doesn't proceed:**

| Trigger | Contingency Action |
|---------|-------------------|
| Traction plateaus | Focus on profitability over growth; delay Phase 2 payment integration |
| Competitive pressure | Double down on niche; consider partnership/acquisition |

**Emergency reserves:**
- Maintain 2-month operating buffer at all times
- Co-founder commitment to bridge financing if needed (terms TBD)

---

## 5. Risk Matrix Summary

### High Priority (High Likelihood × High Impact)

| Risk | Category | Status |
|------|----------|--------|
| Single founder dependency | Operational | Active mitigation |
| Low consumer adoption | Business | Active mitigation |
| Honor-based fee collection fails | Business | Active mitigation |

### Medium Priority (Medium × High or High × Medium)

| Risk | Category | Status |
|------|----------|--------|
| Insufficient merchant supply | Business | Active mitigation |
| Merchants route orders off-platform | Business | Active mitigation |
| Technical debt accumulation | Operational | Active mitigation |
| Founder visa constraints | Operational | Active mitigation |

### Monitor (Low Likelihood but High Impact)

| Risk | Category | Status |
|------|----------|--------|
| Competitor entry (large platform) | Competitive | Monitoring |
| Security breach | Operational | Planned mitigation |
| Data loss | Operational | Planned mitigation |
| Regulatory changes | Regulatory | Monitoring |

---

## 6. Mitigation Action Items

| Priority | Action | Risk Addressed | Owner | Deadline | Status |
|----------|--------|----------------|-------|----------|--------|
| 1 | Draft and review Terms of Service with fee collection provisions | Honor-based collection | Legal | Stage 1 Month 2 | Not started |
| 2 | Document key processes and architecture decisions | Single founder dependency | Tech | Ongoing | Not started |
| 3 | Implement basic analytics for order tracking and anomaly detection | Off-platform routing | Product | Stage 1 Month 5 | Not started |
| 4 | Draft privacy policy compliant with APPI | Data privacy | Legal | Stage 1 Month 3 | Not started |
| 5 | Set up automated backup system with recovery testing | Data loss | Tech | Stage 1 Month 4 | Not started |
| 6 | Create merchant onboarding documentation and FAQ | Support capacity | Ops | Stage 1 Month 5 | Not started |
| 7 | Establish security baseline and incident response plan | Security breach | Tech | Stage 1 Month 4 | Not started |
| 8 | Research and select payment provider for Phase 2 | Payment compliance | Finance | Stage 2 Month 3 | Not started |

---

## 7. Risk Review Schedule

| Review Type | Frequency | Participants | Focus |
|-------------|-----------|--------------|-------|
| **Weekly risk check** | Weekly | Founders | High-priority risks, blockers |
| **Monthly risk review** | Monthly | Founders + advisors | Full risk matrix, new risks, mitigation progress |
| **Quarterly deep dive** | Quarterly | Founders + advisors + stakeholders | Strategic risks, regulatory changes, market shifts |

---

*This document should be reviewed and updated monthly. All new risks should be logged immediately upon identification.*

*Last updated: January 2026*
