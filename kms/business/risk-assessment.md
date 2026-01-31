# Halava Risk Assessment

> **Last updated:** February 2026
> **Status:** Active risk tracking document
>
> **Related documents:**
> - [[web-app-spec]] — Detailed product specification
> - [[monetization]] — Pricing, fees, and investment staging
> - [[market-validation]] — Market research and validation tracking

---

## 1. Business Risks

### 1.1 Revenue Collection Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| **Honor-based fee collection fails (Phase 1)** | Medium | High | Early invoicing, relationship-based trust via B2B network, clear ToS |
| **Merchants route orders off-platform** | Medium | Medium | Build platform value (analytics, purchase history), track anomalies |
| **High GMV merchants negotiate unsustainable rates** | Low | Medium | Tiered pricing with floor rate at 2.5% |

### 1.2 Growth Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| **Low consumer adoption** | Medium | High | Group purchase virality, in-store QR exposure, SEO |
| **Insufficient merchant supply** | Medium | High | B2B network relationships, assisted onboarding |
| **Group purchase feature underutilized** | Medium | Medium | Clear UX, incentivize initiators |

### 1.3 Competitive Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| **Competitor entry (larger platform adds halal)** | Low | High | First-mover advantage, community trust |
| **Existing halal apps add commerce** | Medium | Medium | Superior merchant tools, consumer features |

---

## 2. Regulatory Risks

### 2.1 Payment Intermediation

| Risk | Description | Mitigation |
|------|-------------|------------|
| **Unlicensed fund handling** | Operating as payment intermediary without license | Phase 1: Off-platform. Phase 2: Use licensed provider (Stripe Connect) |
| **資金移動業 license requirements** | Direct payment intermediation requires FSA license | Phase 3 is 3-5+ years. Maintain Phase 2 as fallback |

### 2.2 Consumer Protection

| Risk | Description | Mitigation |
|------|-------------|------------|
| **Misleading halal claims** | Merchants may falsely claim halal status | Disclaimer: "Halal status is declared by the merchant" |
| **Refund/dispute resolution** | Consumer disputes in off-platform settlement | Halava provides mediation services |

### 2.3 Data Privacy (APPI Compliance)

| Requirement | Status |
|-------------|--------|
| Purpose limitation | Planned |
| Consent collection | Planned |
| Data access/deletion rights | Planned |
| Security measures | Planned |

---

## 3. Operational Risks

### 3.1 Team & Execution

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| **Single founder dependency** | High | Critical | Document processes, co-founder relationship |
| **Founder visa status constraints** | Medium | High | Co-founder as legal representative (Stage 1) |
| **Burnout / capacity limits** | Medium | High | Realistic milestone planning |

### 3.2 Technical Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| **Technical debt accumulation** | Medium | Medium | Code review, refactoring in sprints |
| **POS offline sync conflicts** | Medium | Medium | Conflict resolution protocol |
| **Platform outages** | Low | High | 99.5% uptime target, POS offline capability |
| **Security breach** | Low | Critical | Security best practices, incident response plan |

---

## 4. Financial Risks

### 4.1 Runway Scenarios

**Stage 1 Capital: ¥3M (7-month runway)**

| Scenario | Monthly Burn | Runway |
|----------|-------------|--------|
| Optimistic | ¥380k | 8 months |
| Realistic | ¥430k | 7 months |
| Pessimistic | ¥500k | 6 months |

### 4.2 Break-Even Analysis

> See [[monetization#Transaction Fee Model]] for fee rates.

**Phase 1 (MVP):**
- Monthly costs: ¥350,000
- Break-even GMV at 2%: ¥17.5M monthly

**Phase 2:**
- Monthly costs: ¥1,250,000
- Break-even GMV at 5%: ¥25M monthly

### 4.3 Contingency Plans

**If Stage 2 funding doesn't proceed:**
- Operating Founder retains 90% equity
- Bootstrap on transaction fee revenue
- Consider alternative funding or pivot

---

## 5. Risk Matrix Summary

### High Priority (High Likelihood × High Impact)

| Risk | Category | Status |
|------|----------|--------|
| Single founder dependency | Operational | Active mitigation |
| Low consumer adoption | Business | Active mitigation |
| Honor-based fee collection fails | Business | Active mitigation |

### Medium Priority

| Risk | Category | Status |
|------|----------|--------|
| Insufficient merchant supply | Business | Active mitigation |
| Merchants route orders off-platform | Business | Active mitigation |
| Technical debt accumulation | Operational | Active mitigation |

### Monitor (Low Likelihood but High Impact)

| Risk | Category | Status |
|------|----------|--------|
| Competitor entry | Competitive | Monitoring |
| Security breach | Operational | Planned mitigation |
| Regulatory changes | Regulatory | Monitoring |

---

## 6. Mitigation Action Items

| Priority | Action | Risk Addressed | Deadline | Status |
|----------|--------|----------------|----------|--------|
| 1 | Draft Terms of Service | Honor-based collection | Stage 1 Month 2 | Not started |
| 2 | Document key processes | Single founder | Ongoing | Not started |
| 3 | Implement analytics tracking | Off-platform routing | Stage 1 Month 5 | Not started |
| 4 | Draft privacy policy (APPI) | Data privacy | Stage 1 Month 3 | Not started |
| 5 | Set up automated backups | Data loss | Stage 1 Month 4 | Not started |

---

## 7. Risk Review Schedule

| Review Type | Frequency | Focus |
|-------------|-----------|-------|
| **Weekly risk check** | Weekly | High-priority risks, blockers |
| **Monthly risk review** | Monthly | Full matrix, new risks |
| **Quarterly deep dive** | Quarterly | Strategic risks, market shifts |

---

*Update this document monthly. Log new risks immediately upon identification.*

#halava #business #risk
