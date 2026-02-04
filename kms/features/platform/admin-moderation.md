# Admin & Moderation

> **Feature Type:** Platform Operations
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[web-app-spec]] · [[directory]] · [[marketplace]]

---

## Definition

**Admin & Moderation** encompasses the platform governance tools used by Halava's internal team to maintain quality, resolve issues, and manage the platform.

**Two distinct roles:**
- **Moderators:** Handle user reports, content issues, and first-line merchant support
- **Admins:** Full platform access, configuration, escalations, and governance

---

## How It Works

### Moderation Flow

1. **Reports come in** from users (flagged content, merchant issues, policy violations)
2. **Moderator reviews** the report with context
3. **Takes action:** Dismiss, warn, suspend, or escalate
4. **Records decision** in audit log
5. **Notifies parties** as appropriate

### Admin Flow

1. **Monitor** platform health dashboards
2. **Manage** user and merchant accounts
3. **Configure** platform settings
4. **Handle** escalations from moderators
5. **Make** policy decisions

---

## User Journey

### Moderator: Handle Reports

```
Moderator Dashboard → Reports Queue
  → View Report #1234:
    - Reporter: Consumer
    - Subject: Merchant listing
    - Reason: "Halal status seems incorrect"
    - Evidence: Screenshot attached
  → Review merchant's listing and halal declaration
  → Contact merchant for clarification (optional)
  → Decision:
    ○ Dismiss (unfounded)
    ○ Warn merchant
    ○ Request evidence update
    ○ Suspend listing
    ○ Escalate to Admin
  → [Submit Decision]
  → Add notes to audit log
  → Reporter notified of resolution
```

### Moderator: Review Content

```
Moderator Dashboard → Content Review
  → Flagged reviews:
    - Review contains inappropriate language
    - [View Review] [View Profile]
  → Action:
    ○ Approve (false positive)
    ○ Edit/Redact
    ○ Remove review
    ○ Warn user
    ○ Suspend user
  → [Submit]
```

### Moderator: Maintain Platform Quality

```
Moderator Dashboard
  → Reports Queue (pending: 5)
  → Content Review (flagged: 3)
  → Merchant Verification Requests (2)
  → Recent Actions (audit log)
  
Daily workflow:
  1. Check Reports Queue → Process reports
  2. Review flagged content → Take action
  3. Handle verification requests → Verify documents
  4. Log all actions → Maintain audit trail
```

### Admin: Platform Governance

```
Admin Dashboard
  → Platform Overview:
    - Active users: 12,450
    - Active merchants: 234
    - Orders today: 567
    - Revenue (MTD): ¥2.3M
  → System Health:
    - API latency: 245ms (p95)
    - Error rate: 0.02%
    - Uptime: 99.98%
  → Alerts:
    - 2 escalations pending
    - 1 payment issue
```

### Admin: Manage Users

```
Admin Dashboard → Users
  → Search: "user@example.com"
  → User Profile:
    - Account status: Active
    - Role: Consumer
    - Created: Jan 15, 2026
    - Orders: 12
    - Reports filed: 0
    - Reports against: 0
  → Actions:
    - [Edit Profile]
    - [Suspend Account]
    - [Delete Account]
    - [View Activity Log]
```

### Admin: Manage Merchants

```
Admin Dashboard → Merchants
  → Search: "Halal Mart"
  → Merchant Profile:
    - Status: Active
    - Owner: merchant@example.com
    - Enabled capabilities: Directory, POS, Shop
    - Listings: 1
    - Products: 45
    - Orders (MTD): 89
    - Revenue (MTD): ¥234,500
  → Actions:
    - [Edit Merchant]
    - [Suspend Merchant]
    - [View Transactions]
    - [Contact Owner]
```

### Admin: Handle Escalations

```
Admin Dashboard → Escalations
  → Escalation #45:
    - From: Moderator Alice
    - Subject: Merchant disputes suspension
    - Context: Merchant claims halal certificate is valid
    - Moderator notes: "Certificate appears altered"
  → Review all evidence
  → Decision:
    - [Uphold Suspension]
    - [Overturn - Reinstate]
    - [Request Additional Info]
  → Document reasoning
  → [Resolve]
```

### Admin: Configure Platform

```
Admin Dashboard → Settings
  → General:
    - Platform name
    - Support email
    - Default language
  → Features:
    - Enable/disable feature flags
    - Maintenance mode
  → Pricing:
    - Transaction fee rates
    - Subscription tiers
    - POS quota limits
  → Policies:
    - Terms of Service
    - Privacy Policy
    - Content Guidelines
```

---

## UI/UX Specification

> **Template Support:** Desktop only — Admin and moderator features are not available on mobile (see [[pages-navigation-ux-spec#1. Dual-Template Architecture]])

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Mod Dashboard** | `/mod` | Moderator home |
| **Reports Queue** | `/mod/reports` | Pending reports |
| **Content Review** | `/mod/content` | Flagged content |
| **Audit Log** | `/mod/audit` | Action history |
| **Admin Dashboard** | `/admin` | Admin home |
| **Users Management** | `/admin/users` | User admin |
| **Merchants Management** | `/admin/merchants` | Merchant admin |
| **Escalations** | `/admin/escalations` | Escalated issues |
| **Settings** | `/admin/settings` | Platform config |

### Moderator Dashboard

```
┌─────────────────────────────────────────────────────────────────┐
│ Moderator Dashboard                              [Alice] [⚙️]   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐              │
│ │ Reports      │ │ Content      │ │ Verification │              │
│ │     5        │ │     3        │ │      2       │              │
│ │   pending    │ │   flagged    │ │   requests   │              │
│ └──────────────┘ └──────────────┘ └──────────────┘              │
│                                                                 │
│ Recent Reports                                    [View All →]  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ #1234 │ Halal status dispute  │ Merchant │ 2h ago │ [View] │ │
│ │ #1233 │ Offensive review      │ Content  │ 3h ago │ [View] │ │
│ │ #1232 │ Fake listing          │ Merchant │ 5h ago │ [View] │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ My Recent Actions                                               │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Dismissed #1230 (unfounded) │ Today 10:30 AM                │ │
│ │ Warned user@email.com       │ Today 9:15 AM                 │ │
│ │ Removed review #456         │ Yesterday 4:00 PM             │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### Report Detail

```
┌─────────────────────────────────────────────────────────────────┐
│ [←] Report #1234                                                │
├─────────────────────────────────────────────────────────────────┤
│ Type: Halal Status Dispute                                      │
│ Status: Pending                                                 │
│ Created: Jan 28, 2026, 2:30 PM                                 │
│                                                                 │
│ Reporter                                                        │
│ ├── User: consumer@email.com                                    │
│ └── History: 2 reports filed, 0 dismissed                       │
│                                                                 │
│ Subject                                                         │
│ ├── Merchant: Halal Mart Shibuya                               │
│ ├── Listing: /places/halal-mart-shibuya                        │
│ └── Halal Status: "Certified Halal"                            │
│                                                                 │
│ Report Details                                                  │
│ ├── Reason: "Certificate looks expired/fake"                   │
│ └── Evidence: [View Attached Screenshot]                        │
│                                                                 │
│ Merchant's Declaration                                          │
│ ├── Certificate: [View Uploaded PDF]                           │
│ └── Uploaded: Dec 15, 2025                                     │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│ Action                                                          │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Decision:                                                   │ │
│ │ ○ Dismiss - Report unfounded                                │ │
│ │ ○ Request update - Ask merchant to update certificate       │ │
│ │ ○ Warn merchant - Issue warning                             │ │
│ │ ○ Suspend listing - Hide until resolved                     │ │
│ │ ○ Escalate - Send to Admin                                  │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ Notes:                                                          │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │                                                             │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ [Cancel]                                      [Submit Decision] │
└─────────────────────────────────────────────────────────────────┘
```

### Admin Dashboard

```
┌─────────────────────────────────────────────────────────────────┐
│ Admin Dashboard                                  [Admin] [⚙️]   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│ Platform Overview                                               │
│ ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐    │
│ │ Users      │ │ Merchants  │ │ Orders     │ │ Revenue    │    │
│ │  12,450    │ │    234     │ │   567      │ │  ¥2.3M     │    │
│ │  +5% ▲     │ │  +12% ▲    │ │  today     │ │  this mo   │    │
│ └────────────┘ └────────────┘ └────────────┘ └────────────┘    │
│                                                                 │
│ Alerts                                           [View All →]   │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🔴 2 escalations pending review                             │ │
│ │ 🟡 1 payment processing issue                               │ │
│ │ 🟢 System health: Normal                                    │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│ Quick Actions                                                   │
│ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐                │
│ │ 👥 Users    │ │ 🏪 Merchants│ │ ⚙️ Settings │                │
│ └─────────────┘ └─────────────┘ └─────────────┘                │
│                                                                 │
│ System Health                                                   │
│ ├── API Latency (p95): 245ms ✓                                 │
│ ├── Error Rate: 0.02% ✓                                        │
│ ├── Uptime (30d): 99.98% ✓                                     │
│ └── Database: Healthy ✓                                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         Report                                   │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  reporter_id     UUID FK → User                                 │
│  subject_type    ENUM(user, merchant, place, product, review,   │
│                       order)                                    │
│  subject_id      UUID NOT NULL                                  │
│  reason          ENUM(spam, fake, inappropriate, halal_issue,   │
│                       fraud, harassment, other)                 │
│  description     TEXT                                           │
│  evidence_urls   TEXT[]                                         │
│  status          ENUM(pending, in_review, resolved, escalated)  │
│  priority        ENUM(low, normal, high, urgent)                │
│  assigned_to     UUID FK → User (moderator)                     │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    ReportResolution                              │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  report_id       UUID FK → Report                               │
│  resolved_by     UUID FK → User                                 │
│  decision        ENUM(dismissed, warning_issued, content_removed│
│                       account_suspended, escalated)             │
│  notes           TEXT                                           │
│  action_taken    JSONB (details of action)                      │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                        AuditLog                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  actor_id        UUID FK → User                                 │
│  action          VARCHAR(100) NOT NULL                          │
│                  (user.suspend, merchant.edit, content.remove,  │
│                   setting.update, etc.)                         │
│  target_type     VARCHAR(50) NOT NULL                           │
│  target_id       UUID NOT NULL                                  │
│  details         JSONB (before/after state, reason)             │
│  ip_address      INET                                           │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    PlatformSetting                               │
├─────────────────────────────────────────────────────────────────┤
│  key             VARCHAR(100) PRIMARY KEY                       │
│  value           JSONB NOT NULL                                 │
│  description     TEXT                                           │
│  updated_by      UUID FK → User                                 │
│  updated_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘
```

### Platform Settings Examples

```json
{
  "transaction_fee_rate": 0.03,
  "pos_free_tier_limit": 300,
  "maintenance_mode": false,
  "feature_flags": {
    "group_purchase": true,
    "multi_language": false
  }
}
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `report` | `status, priority, created_at` | Moderation queue |
| `report` | `assigned_to, status` | Moderator workload |
| `report` | `subject_type, subject_id` | Reports on entity |
| `report_resolution` | `report_id` | Resolution lookup |
| `audit_log` | `actor_id, created_at DESC` | User actions |
| `audit_log` | `target_type, target_id, created_at` | Entity history |
| `audit_log` | `action, created_at` | Action analytics |

---

## API Endpoints

> Full API index: [[api-spec#11. Admin Module]] | [[api-spec#12. Moderation Module]]

### Moderation Endpoints

#### GET /v1/mod/reports

List pending reports.

```
Query Parameters:
  status        string    Filter: pending, resolved, escalated
  type          string    Filter: content, user, merchant
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "reports": [
    {
      "id": "uuid",
      "type": "content",
      "target_type": "review",
      "target_id": "uuid",
      "reason": "inappropriate_content",
      "description": "Contains offensive language",
      "reporter_id": "uuid",
      "status": "pending",
      "created_at": "2026-02-01T10:00:00Z"
    }
  ],
  "total": 15,
  "pending": 8
}
```

#### GET /v1/mod/reports/{id}

Get report details.

```json
// Response
{
  "id": "uuid",
  "type": "content",
  "target_type": "review",
  "target_id": "uuid",
  "target_content": {
    "text": "This place is...",
    "author_id": "uuid",
    "author_name": "User123",
    "created_at": "2026-01-30T14:00:00Z"
  },
  "reason": "inappropriate_content",
  "description": "Contains offensive language",
  "reporter": {
    "id": "uuid",
    "name": "Reporter Name"
  },
  "status": "pending",
  "previous_reports": 0,
  "created_at": "2026-02-01T10:00:00Z"
}
```

#### POST /v1/mod/reports/{id}/resolve

Resolve a report.

```json
// Request
{
  "action": "remove_content",
  "reason": "Violates community guidelines",
  "notify_reporter": true,
  "warn_author": true,
  "internal_note": "Repeated offense"
}

// Response
{
  "id": "uuid",
  "status": "resolved",
  "action_taken": "remove_content",
  "resolved_by": "uuid",
  "resolved_at": "2026-02-01T12:00:00Z"
}
```

#### POST /v1/mod/reports/{id}/escalate

Escalate report to admin.

```json
// Request
{
  "reason": "Potential fraud pattern detected",
  "priority": "high"
}

// Response
{
  "id": "uuid",
  "status": "escalated",
  "escalated_by": "uuid",
  "escalated_at": "2026-02-01T12:00:00Z"
}
```

#### GET /v1/mod/content/flagged

List flagged content.

```
Query Parameters:
  type          string    Filter: review, listing, message
  status        string    Filter: pending, actioned
```

```json
// Response
{
  "content": [
    {
      "id": "uuid",
      "type": "review",
      "flag_reason": "auto_detected_spam",
      "confidence_score": 0.92,
      "preview": "Buy cheap...",
      "author_id": "uuid",
      "flagged_at": "2026-02-01T10:00:00Z"
    }
  ],
  "total": 5
}
```

#### POST /v1/mod/content/{id}/action

Take action on flagged content.

```json
// Request
{
  "action": "remove",
  "reason": "spam",
  "warn_author": true
}

// Response
{
  "content_id": "uuid",
  "action": "remove",
  "actioned_by": "uuid",
  "actioned_at": "2026-02-01T12:00:00Z"
}
```

#### GET /v1/mod/audit

View moderation audit log.

```
Query Parameters:
  moderator_id  string    Filter by moderator
  action_type   string    Filter: resolve, escalate, warn, remove
  date_from     string    Start date (ISO 8601)
  date_to       string    End date (ISO 8601)
  limit         int       Results per page (default: 50)
```

```json
// Response
{
  "entries": [
    {
      "id": "uuid",
      "moderator_id": "uuid",
      "moderator_name": "Mod User",
      "action_type": "resolve",
      "target_type": "report",
      "target_id": "uuid",
      "details": {
        "action_taken": "remove_content",
        "reason": "spam"
      },
      "timestamp": "2026-02-01T12:00:00Z"
    }
  ],
  "total": 124
}
```

### Admin Endpoints

#### GET /v1/admin/dashboard

Get admin dashboard stats.

```json
// Response
{
  "users": {
    "total": 5420,
    "active_today": 312,
    "new_this_week": 89
  },
  "merchants": {
    "total": 245,
    "active": 198,
    "pending_verification": 12
  },
  "orders": {
    "today": 156,
    "this_week": 892,
    "revenue_today": 234500
  },
  "moderation": {
    "pending_reports": 8,
    "escalations": 2
  }
}
```

#### GET /v1/admin/users

List/search users.

```
Query Parameters:
  q             string    Search query (name, email)
  status        string    Filter: active, suspended, banned
  role          string    Filter: consumer, merchant, moderator
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "users": [
    {
      "id": "uuid",
      "name": "User Name",
      "email": "user@example.com",
      "role": "consumer",
      "status": "active",
      "created_at": "2025-12-01T10:00:00Z",
      "last_active": "2026-02-01T14:00:00Z"
    }
  ],
  "total": 5420
}
```

#### GET /v1/admin/users/{id}

Get user details.

```json
// Response
{
  "id": "uuid",
  "name": "User Name",
  "email": "user@example.com",
  "phone": "+81...",
  "role": "consumer",
  "status": "active",
  "created_at": "2025-12-01T10:00:00Z",
  "last_active": "2026-02-01T14:00:00Z",
  "orders_count": 23,
  "reviews_count": 8,
  "warnings_count": 0,
  "moderation_history": []
}
```

#### PUT /v1/admin/users/{id}

Update user.

```json
// Request
{
  "role": "moderator",
  "note": "Promoted to moderator"
}

// Response
{
  "id": "uuid",
  "updated_at": "2026-02-01T12:00:00Z"
}
```

#### POST /v1/admin/users/{id}/suspend

Suspend user account.

```json
// Request
{
  "reason": "Terms of service violation",
  "duration_days": 7,
  "notify_user": true
}

// Response
{
  "id": "uuid",
  "status": "suspended",
  "suspended_until": "2026-02-08T12:00:00Z"
}
```

#### GET /v1/admin/merchants

List/search merchants.

```
Query Parameters:
  q             string    Search query (name, email)
  status        string    Filter: active, suspended, pending
  verified      boolean   Filter by verification status
  limit         int       Results per page (default: 20)
```

```json
// Response
{
  "merchants": [
    {
      "id": "uuid",
      "name": "Salam Kitchen",
      "owner_email": "owner@example.com",
      "status": "active",
      "is_verified": true,
      "created_at": "2025-11-01T10:00:00Z",
      "orders_count": 456
    }
  ],
  "total": 245
}
```

#### GET /v1/admin/merchants/{id}

Get merchant details (admin view).

```json
// Response
{
  "id": "uuid",
  "name": "Salam Kitchen",
  "owner": {
    "id": "uuid",
    "name": "Owner Name",
    "email": "owner@example.com"
  },
  "status": "active",
  "is_verified": true,
  "verification_date": "2025-11-15T10:00:00Z",
  "created_at": "2025-11-01T10:00:00Z",
  "stats": {
    "total_orders": 456,
    "total_revenue": 1234500,
    "avg_rating": 4.6,
    "reviews_count": 89
  },
  "moderation_history": []
}
```

#### POST /v1/admin/merchants/{id}/suspend

Suspend merchant.

```json
// Request
{
  "reason": "Multiple customer complaints",
  "duration_days": 30,
  "notify_owner": true,
  "hide_listings": true
}

// Response
{
  "id": "uuid",
  "status": "suspended",
  "suspended_until": "2026-03-01T12:00:00Z"
}
```

#### GET /v1/admin/escalations

List escalated issues.

```
Query Parameters:
  priority      string    Filter: high, medium, low
  status        string    Filter: pending, resolved
```

```json
// Response
{
  "escalations": [
    {
      "id": "uuid",
      "original_report_id": "uuid",
      "reason": "Potential fraud pattern detected",
      "priority": "high",
      "escalated_by": "uuid",
      "escalated_at": "2026-02-01T10:00:00Z",
      "status": "pending"
    }
  ],
  "total": 2
}
```

#### POST /v1/admin/escalations/{id}/resolve

Resolve escalation.

```json
// Request
{
  "action": "suspend_merchant",
  "details": {
    "merchant_id": "uuid",
    "duration_days": 30
  },
  "internal_note": "Confirmed fraudulent activity"
}

// Response
{
  "id": "uuid",
  "status": "resolved",
  "resolved_by": "uuid",
  "resolved_at": "2026-02-01T14:00:00Z"
}
```

#### GET /v1/admin/settings

Get platform settings.

```json
// Response
{
  "platform_name": "Halava",
  "maintenance_mode": false,
  "signup_enabled": true,
  "default_language": "ja",
  "supported_languages": ["ja", "en", "ar"],
  "commission_rate": 0.05,
  "min_order_amount": 500,
  "max_order_amount": 100000
}
```

#### PUT /v1/admin/settings

Update platform settings.

```json
// Request
{
  "maintenance_mode": true,
  "maintenance_message": "Scheduled maintenance until 06:00 JST"
}

// Response
{
  "updated_at": "2026-02-01T04:00:00Z"
}

---

## Permissions Matrix

| Action | Moderator | Admin |
|--------|-----------|-------|
| View reports | ✅ | ✅ |
| Resolve reports | ✅ | ✅ |
| Escalate to admin | ✅ | — |
| Handle escalations | ❌ | ✅ |
| Warn users | ✅ | ✅ |
| Suspend users | ❌ | ✅ |
| Delete users | ❌ | ✅ |
| View merchants | ✅ | ✅ |
| Suspend merchants | ❌ | ✅ |
| Platform settings | ❌ | ✅ |
| View audit log | Own actions | All |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Report resolution time | < 24 hours |
| Escalation rate | < 10% of reports |
| False positive rate | < 5% |
| Audit log coverage | 100% of actions |

---

## Dependencies

- [[web-app-spec#Roles & Permissions]] — Role definitions
- [[directory]] — Place moderation
- [[marketplace]] — Product/order issues
- All feature files — Content that may require moderation

---

#halava #feature #admin #moderation #platform #governance
