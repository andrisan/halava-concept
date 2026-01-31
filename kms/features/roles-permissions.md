# Roles & Permissions

> **Feature Type:** Platform (Cross-cutting)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[onboarding]] · [[admin-moderation]] · [[pos]] · [[marketplace]]

---

## Definition

**Roles & Permissions** is Halava's access control system that determines what each user type can see and do on the platform. It uses Role-Based Access Control (RBAC) to manage authorization across all features.

**Core principles:**
- **Least privilege** — Users only have access they need
- **Role inheritance** — Higher roles include lower permissions
- **Feature-scoped** — Permissions tied to enabled capabilities

---

## Roles

### Consumer

Regular platform users who discover, browse, and purchase.

**Access:**
- Browse directory, products, menus
- Make purchases (online, in-store linking)
- Manage personal profile and preferences
- View purchase history
- Create and join group purchases
- Write reviews and ratings
- Save favorites
- Report issues

### Merchant Owner

Business operators who manage their merchant account and strategy.

**Access:**
- All Consumer permissions (as a user)
- Enable/disable capabilities
- Manage business profile and listings
- Add/edit products and menu items
- Configure pricing and inventory
- View orders and analytics
- Manage staff accounts
- Upload halal evidence
- Configure POS settings
- Access merchant dashboard

### Merchant Staff (Cashier)

Day-to-day operators who handle transactions and fulfillment.

**Access:**
- Access POS interface
- Process in-store sales
- View and fulfill orders
- Generate receipts
- View daily summaries
- Link customer purchases (QR scan)
- Update order status

**Restrictions:**
- Cannot enable/disable capabilities
- Cannot manage products or pricing
- Cannot view analytics or revenue
- Cannot manage other staff

### Moderator

Platform team members who maintain quality and handle reports.

**Access:**
- View and resolve user reports
- Review flagged content
- Warn users
- Edit/remove content (reviews, listings)
- View user/merchant profiles (limited)
- Access moderator dashboard
- View audit log (own actions)

**Restrictions:**
- Cannot suspend/delete accounts
- Cannot access platform settings
- Cannot view financial data

### Admin

Platform administrators with full access.

**Access:**
- All Moderator permissions
- Suspend/delete user accounts
- Suspend/delete merchant accounts
- Handle escalations
- Configure platform settings
- View all audit logs
- Manage roles and permissions
- Access admin dashboard
- View platform analytics and financials

---

## Permission Matrix

### Consumer Permissions

| Permission | Consumer | Owner | Staff | Mod | Admin |
|------------|----------|-------|-------|-----|-------|
| Browse directory | ✅ | ✅ | ✅ | ✅ | ✅ |
| Browse products | ✅ | ✅ | ✅ | ✅ | ✅ |
| Make purchases | ✅ | ✅ | ✅ | ✅ | ✅ |
| View purchase history | ✅ | ✅ | ✅ | ✅ | ✅ |
| Write reviews | ✅ | ✅ | ✅ | ❌ | ❌ |
| Create group purchase | ✅ | ✅ | ✅ | ✅ | ✅ |
| Report issues | ✅ | ✅ | ✅ | ✅ | ✅ |

### Merchant Permissions

| Permission | Consumer | Owner | Staff | Mod | Admin |
|------------|----------|-------|-------|-----|-------|
| Enable capabilities | ❌ | ✅ | ❌ | ❌ | ✅ |
| Manage business profile | ❌ | ✅ | ❌ | ❌ | ✅ |
| Manage products/menu | ❌ | ✅ | ❌ | ❌ | ✅ |
| Set pricing | ❌ | ✅ | ❌ | ❌ | ✅ |
| Manage inventory | ❌ | ✅ | ✅* | ❌ | ✅ |
| Access POS | ❌ | ✅ | ✅ | ❌ | ✅ |
| Process sales | ❌ | ✅ | ✅ | ❌ | ✅ |
| View orders | ❌ | ✅ | ✅ | ❌ | ✅ |
| Fulfill orders | ❌ | ✅ | ✅ | ❌ | ✅ |
| View analytics | ❌ | ✅ | ❌ | ❌ | ✅ |
| Manage staff | ❌ | ✅ | ❌ | ❌ | ✅ |
| Upload halal evidence | ❌ | ✅ | ❌ | ❌ | ✅ |

*Staff can only adjust stock counts, not create/delete items

### Platform Permissions

| Permission | Consumer | Owner | Staff | Mod | Admin |
|------------|----------|-------|-------|-----|-------|
| View reports queue | ❌ | ❌ | ❌ | ✅ | ✅ |
| Resolve reports | ❌ | ❌ | ❌ | ✅ | ✅ |
| Warn users | ❌ | ❌ | ❌ | ✅ | ✅ |
| Edit content | ❌ | ❌ | ❌ | ✅ | ✅ |
| Remove content | ❌ | ❌ | ❌ | ✅ | ✅ |
| Escalate to admin | ❌ | ❌ | ❌ | ✅ | — |
| Suspend users | ❌ | ❌ | ❌ | ❌ | ✅ |
| Delete users | ❌ | ❌ | ❌ | ❌ | ✅ |
| Suspend merchants | ❌ | ❌ | ❌ | ❌ | ✅ |
| Platform settings | ❌ | ❌ | ❌ | ❌ | ✅ |
| View all audit logs | ❌ | ❌ | ❌ | ❌ | ✅ |

---

## Role Assignment

### Consumer

- Assigned automatically at registration
- Default role for all users

### Merchant Owner

- Assigned when user registers as merchant
- Or when existing consumer creates a merchant account
- One owner per merchant account

### Merchant Staff

- Created by Merchant Owner
- Assigned to specific merchant
- Can be assigned to multiple merchants (future)

### Moderator

- Assigned by Admin only
- Requires internal vetting process
- Can be combined with Consumer role

### Admin

- Assigned by existing Admin only
- Requires highest trust level
- Limited number (platform team only)

---

## User Journey

### Owner: Invite Staff

```
Merchant Dashboard → Settings → Staff
  → [+ Add Staff Member]
  → Enter email address
  → Select role: Cashier
  → [Send Invitation]
  → Staff receives email → Creates account → Linked to merchant
```

### Owner: Manage Staff Permissions

```
Merchant Dashboard → Settings → Staff
  → View staff list:
    • Aisha (Cashier) — Active
    • Yusuf (Cashier) — Active
  → Tap staff member
  → Actions:
    • [Deactivate] — Revoke access
    • [Remove] — Delete from merchant
```

### Admin: Assign Moderator Role

```
Admin Dashboard → Users → Search user
  → User Profile
  → Roles: Consumer
  → [Assign Role] → Select: Moderator
  → Confirm
  → User now has Moderator access
```

---

## UI/UX Specification

### Staff Management (Merchant)

```
┌──────────────────────────────────────────┐
│ [←] Staff Management                     │
├──────────────────────────────────────────┤
│                                          │
│ Your Staff (2)                           │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 👤 Aisha Rahman                      │ │
│ │ Cashier · Active since Jan 15       │ │
│ │ Last active: Today, 2:30 PM         │ │
│ │                        [Manage →]   │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 👤 Yusuf Ahmad                       │ │
│ │ Cashier · Active since Jan 20       │ │
│ │ Last active: Yesterday              │ │
│ │                        [Manage →]   │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [ + Add Staff Member ]                   │
│                                          │
└──────────────────────────────────────────┘
```

### Role Assignment (Admin)

```
┌──────────────────────────────────────────┐
│ User: mod@halava.app                     │
├──────────────────────────────────────────┤
│                                          │
│ Current Roles:                           │
│ ┌──────────────────────────────────────┐ │
│ │ ☑ Consumer (default)                 │ │
│ │ ☑ Moderator                          │ │
│ │ ☐ Admin                              │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [ Save Changes ]                         │
│                                          │
└──────────────────────────────────────────┘
```

---

## Data Model

```
User
├── id: UUID
├── email: string
├── name: string
├── role: enum (consumer, merchant_owner, staff, moderator, admin)
├── ...

Staff
├── id: UUID
├── user_id: FK → User
├── merchant_id: FK → Merchant
├── role: enum (cashier) // expandable for future roles
├── status: enum (invited, active, deactivated)
├── invited_by: FK → User (owner)
├── invited_at: timestamp
├── activated_at: timestamp (nullable)
├── deactivated_at: timestamp (nullable)

RoleAssignment (for moderators/admins)
├── id: UUID
├── user_id: FK → User
├── role: enum (moderator, admin)
├── assigned_by: FK → User
├── assigned_at: timestamp
├── revoked_at: timestamp (nullable)
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/merchant/staff` | List merchant's staff |
| `POST` | `/api/v1/merchant/staff` | Invite staff member |
| `PUT` | `/api/v1/merchant/staff/{id}` | Update staff |
| `DELETE` | `/api/v1/merchant/staff/{id}` | Remove staff |
| `GET` | `/api/v1/admin/users/{id}/roles` | Get user roles |
| `PUT` | `/api/v1/admin/users/{id}/roles` | Update user roles |

---

## Authorization Flow

```
Request → Extract JWT → Get user_id
  → Load user with role
  → Check route permission
  → If merchant route: check merchant membership
  → If staff route: check staff assignment
  → Allow or deny (401/403)
```

---

## Future Enhancements

- **Custom roles** — Merchants define custom staff roles
- **Granular permissions** — Per-feature permission toggles
- **Multi-merchant staff** — Staff works at multiple locations
- **Role hierarchy** — Manager role between Owner and Cashier
- **Permission audit** — Track permission changes over time

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Staff invitation acceptance | > 80% |
| Unauthorized access attempts | < 0.1% |
| Permission errors (false denials) | < 0.01% |

---

## Dependencies

- [[onboarding]] — Role assigned at registration
- [[admin-moderation]] — Admin manages roles
- [[pos]] — Staff access POS
- [[order-management]] — Staff can view and fulfill orders

---

#halava #feature #roles #permissions #rbac #platform
