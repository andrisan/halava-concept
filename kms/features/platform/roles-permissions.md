# Roles & Permissions

> **Feature Type:** Platform (Cross-cutting)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[onboarding]] · [[admin-moderation]] · [[pos]] · [[marketplace]]

---

## Definition

**Roles & Permissions** is Halava's access control system that determines what each user type can see and do on the platform.

### Two Separate RBAC Systems

| Aspect | Platform Roles | Merchant Roles |
|--------|----------------|----------------|
| **Scope** | Entire platform | Within one merchant |
| **Managed by** | Halava admins | Merchant owner |
| **Roles** | Fixed (Consumer, Moderator, Admin) | Dynamic (Cashier, Inventory, custom...) |
| **Assignment** | At registration or by admin | By merchant owner invitation |
| **Customization** | None | Full (create, edit, delete roles) |

```
┌─────────────────────────────────────────────────────────────────┐
│                     HALAVA PLATFORM                             │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              PLATFORM ROLES (Fixed)                      │   │
│  │         Managed by: Halava Platform Admins               │   │
│  │                                                          │   │
│  │   ┌──────────┐   ┌───────────┐   ┌─────────┐            │   │
│  │   │ Consumer │   │ Moderator │   │  Admin  │            │   │
│  │   └──────────┘   └───────────┘   └─────────┘            │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              MERCHANT ROLES (Dynamic)                    │   │
│  │         Managed by: Each Merchant Owner                  │   │
│  │                                                          │   │
│  │   ┌─────────────────────────────────────────────────┐   │   │
│  │   │  Merchant A                                      │   │   │
│  │   │  ┌───────┐ ┌─────────┐ ┌───────────┐ ┌───────┐  │   │   │
│  │   │  │ Owner │ │ Cashier │ │ Inventory │ │ Custom│  │   │   │
│  │   │  └───────┘ └─────────┘ └───────────┘ └───────┘  │   │   │
│  │   └─────────────────────────────────────────────────┘   │   │
│  │                                                          │   │
│  │   ┌─────────────────────────────────────────────────┐   │   │
│  │   │  Merchant B                                      │   │   │
│  │   │  ┌───────┐ ┌─────────┐ ┌───────────────────────┐│   │   │
│  │   │  │ Owner │ │ Cashier │ │ Shift Manager (custom)││   │   │
│  │   │  └───────┘ └─────────┘ └───────────────────────┘│   │   │
│  │   └─────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Core principles:**
- **Least privilege** — Users only have access they need
- **Separation of concerns** — Platform vs merchant authorization
- **Feature-scoped** — Permissions tied to enabled capabilities

---

## Platform Roles (Fixed)

Platform roles are **fixed** and managed by **Halava administrators**. These determine platform-wide access.

> ⚠️ Platform roles cannot be created, modified, or deleted by merchants.

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
- Manage staff accounts and roles (Merchant RBAC)
- Upload halal evidence
- Configure POS settings
- Access merchant dashboard

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
- Manage platform roles
- Access admin dashboard
- View platform analytics and financials

---

## Merchant Roles (Dynamic)

Merchant roles are **dynamic** and managed by **each Merchant Owner**. Each merchant has its own independent role configuration.

> ✅ Owners can create, modify, and delete staff roles for their business.

### Owner vs Staff

| Aspect | Merchant Owner | Merchant Staff |
|--------|----------------|----------------|
| **Assignment** | When user registers merchant | Invited by owner |
| **Permissions** | Full merchant access | Role-based (dynamic) |
| **Can manage roles** | ✅ Yes | ❌ No |
| **Can manage staff** | ✅ Yes | ❌ No |
| **Limit per merchant** | 1 | Unlimited (consumption-based billing applies) |

Staff accounts are billed on a consumption basis — the first 2 staff accounts are free, additional accounts are metered monthly. See [[pricing/platform/staff-accounts]] for rates.

### How Staff Roles Work

1. **System provides default roles** — Ready-to-use templates (Cashier, Inventory, Part-time)
2. **Owner can customize** — Modify default permissions or create new roles
3. **Per-merchant scope** — Each merchant has its own role configuration
4. **Permission granularity** — Toggle individual permissions per role

### Default Staff Roles

| Role | Description | Key Permissions |
|------|-------------|-----------------|
| **Cashier** | Front-line sales | POS access, process sales, fulfill orders, receipts |
| **Inventory** | Stock management | View/adjust inventory, receiving, stock alerts |
| **Part-time** | Limited access | Basic POS, no admin, time-restricted |

### Available Permissions (Action-Based)

Halava defines the **permission strings** using `resource.action` format. Owners toggle individual permissions when creating staff roles.

> Backend stores permissions as string arrays. UI groups them by category for clarity.

#### POS Permissions

| Permission | Description |
|------------|-------------|
| `pos.process_sale` | Process sales transactions |
| `pos.view_history` | View transaction history |
| `pos.apply_discount` | Apply discounts to sales |
| `pos.process_refund` | Process refunds |
| `pos.void_transaction` | Void transactions |
| `pos.open_drawer` | Open cash drawer manually |
| `pos.reprint_receipt` | Reprint receipts |

#### Order Permissions

| Permission | Description |
|------------|-------------|
| `orders.view` | View incoming orders |
| `orders.update_status` | Update order status (preparing, ready, etc.) |
| `orders.edit_items` | Edit order items |
| `orders.edit_delivery` | Edit delivery details |
| `orders.add_notes` | Add notes to orders |
| `orders.cancel` | Cancel orders |

#### Inventory Permissions

| Permission | Description |
|------------|-------------|
| `inventory.view` | View stock levels |
| `inventory.adjust` | Adjust stock counts |
| `inventory.receive` | Record incoming stock |

#### Customer Permissions

| Permission | Description |
|------------|-------------|
| `customers.view` | View linked customers |
| `customers.link_purchase` | Link customer to purchase (QR scan) |

#### Operations Permissions

| Permission | Description |
|------------|-------------|
| `queue.view` | View order queue status |
| `queue.pause` | Pause/resume online order queue |
| `store.view_status` | View store online status |
| `store.toggle_online` | Enable/disable online ordering |
| `shift.close` | Close daily shift / end-of-day |
| `shift.view_history` | View shift closure history |
| `sync.force` | Force POS data sync |

#### Report Permissions

| Permission | Description |
|------------|-------------|
| `reports.daily` | View daily summary |
| `reports.sales` | View sales reports |
| `reports.inventory` | View inventory reports |

### Default Role Templates

| Role | Permissions |
|------|-------------|
| **Cashier** | `pos.process_sale`, `pos.view_history`, `pos.apply_discount`, `orders.view`, `orders.update_status`, `orders.add_notes`, `customers.view`, `customers.link_purchase`, `reports.daily` |
| **Inventory** | `inventory.view`, `inventory.adjust`, `inventory.receive`, `reports.daily`, `reports.inventory` |
| **Part-time** | `pos.process_sale`, `pos.view_history`, `orders.view`, `customers.view` |
| **Shift Manager** | All Cashier + `pos.process_refund`, `orders.cancel`, `queue.view`, `queue.pause`, `shift.close`, `shift.view_history`, `reports.sales` |

### Custom Role Creation

Owners create roles by toggling permissions grouped by category:

```
Merchant Dashboard → Settings → Staff Roles
  → [+ Create Role]
  → Name: "Senior Cashier"
  
  POS
  ☑ Process sales
  ☑ View transaction history
  ☑ Apply discounts
  ☑ Process refunds
  ☐ Void transactions
  ☑ Open cash drawer
  ☐ Reprint receipts
  
  Orders
  ☑ View orders
  ☑ Update order status
  ☐ Edit order items
  ☐ Edit delivery details
  ☑ Add notes to orders
  ☐ Cancel orders
  
  Inventory
  ☐ View stock levels
  ☐ Adjust stock counts
  ☐ Record incoming stock
  
  Customers
  ☑ View linked customers
  ☑ Link customer to purchase
  
  Operations
  ☑ View order queue status
  ☑ Pause/resume order queue    ← Can pause queue
  ☐ View store online status
  ☐ Toggle online ordering
  ☐ Close daily shift
  ☐ View shift history
  
  Reports
  ☑ View daily summary
  ☐ View sales reports
  ☐ View inventory reports
  
  → [Save Role]
```

### Staff Restrictions (All Roles)

Regardless of permissions, staff **cannot**:
- Enable/disable merchant capabilities
- Manage products or pricing
- View revenue or analytics (unless granted)
- Manage other staff members
- Access merchant billing or settings

---

## Permission Matrices

### Platform Permissions (Fixed)

| Permission | Consumer | Moderator | Admin |
|------------|----------|-----------|-------|
| Browse directory | ✅ | ✅ | ✅ |
| Browse products | ✅ | ✅ | ✅ |
| Make purchases | ✅ | ✅ | ✅ |
| View purchase history | ✅ | ✅ | ✅ |
| Write reviews | ✅ | ❌ | ❌ |
| Create group purchase | ✅ | ✅ | ✅ |
| Report issues | ✅ | ✅ | ✅ |
| View reports queue | ❌ | ✅ | ✅ |
| Resolve reports | ❌ | ✅ | ✅ |
| Warn users | ❌ | ✅ | ✅ |
| Edit/remove content | ❌ | ✅ | ✅ |
| Suspend users | ❌ | ❌ | ✅ |
| Delete users | ❌ | ❌ | ✅ |
| Suspend merchants | ❌ | ❌ | ✅ |
| Platform settings | ❌ | ❌ | ✅ |
| View all audit logs | ❌ | ❌ | ✅ |

### Merchant Permissions (Owner vs Staff)

| Permission | Owner | Staff |
|------------|-------|-------|
| Enable/disable capabilities | ✅ | ❌ |
| Manage business profile | ✅ | ❌ |
| Manage products/menu | ✅ | ❌ |
| Set pricing | ✅ | ❌ |
| View analytics | ✅ | ❌ |
| Manage staff & roles | ✅ | ❌ |
| Upload halal evidence | ✅ | ❌ |
| Merchant billing | ✅ | ❌ |
| **Granular Permissions** | **All** | **Per-role** |
| POS operations | All `pos.*` | 🔧 |
| Order management | All `orders.*` | 🔧 |
| Inventory | All `inventory.*` | 🔧 |
| Customers | All `customers.*` | 🔧 |
| Operations | All `queue.*`, `store.*`, `shift.*` | 🔧 |
| Reports | All `reports.*` | 🔧 |

🔧 = Configured per role using `resource.action` permissions

---

## Role Assignment

### Platform Roles (by Halava)

| Role | How Assigned |
|------|--------------|
| Consumer | Automatically at registration (default) |
| Moderator | By Admin only (internal vetting required) |
| Admin | By existing Admin only (platform team) |

### Merchant Roles (by Owner)

| Role | How Assigned |
|------|--------------|
| Owner | When user registers merchant account |
| Staff | Invited by Owner via email |

---

## User Journey

### Owner: Invite Staff

```
Merchant Dashboard → Settings → Staff
  → [+ Add Staff Member]
  → Enter email address
  → Select role: [Cashier ▼] (Cashier, Inventory, Part-time, + Custom)
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

> **Template Support:** Desktop only — Staff management is not available on mobile (see [[pages-navigation-ux-spec#1. Dual-Template Architecture]])

### Staff Management (Merchant)

```
┌──────────────────────────────────────────┐
│ [←] Staff Management                     │
├──────────────────────────────────────────┤
│                                          │
│ Your Staff (3)                           │
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
│ │ Inventory · Active since Jan 20     │ │
│ │ Last active: Yesterday              │ │
│ │                        [Manage →]   │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 👤 Mei Tanaka                        │ │
│ │ Part-time · Active since Feb 1      │ │
│ │ Last active: Today, 10:00 AM        │ │
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

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         Staff                                    │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User                                 │
│  merchant_id     UUID FK → Merchant                             │
│  role_id         UUID FK → StaffRole                            │
│  invited_by      UUID FK → User                                 │
│  invited_at      TIMESTAMP NOT NULL                             │
│  accepted_at     TIMESTAMP                                      │
│  status          ENUM(invited, active, suspended, removed)      │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
│  UNIQUE(user_id, merchant_id)                                   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                       StaffRole                                  │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  merchant_id     UUID FK → Merchant                             │
│  name            VARCHAR(100) NOT NULL                          │
│  description     TEXT                                           │
│  permissions     TEXT[] NOT NULL                                │
│  is_system       BOOLEAN DEFAULT false                          │
│  created_at      TIMESTAMP NOT NULL                             │
│  updated_at      TIMESTAMP                                      │
│  UNIQUE(merchant_id, name)                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    RoleAssignment                                │
│                (platform moderators/admins)                      │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User                                 │
│  role            ENUM(moderator, admin)                         │
│  assigned_by     UUID FK → User                                 │
│  assigned_at     TIMESTAMP NOT NULL                             │
│  revoked_at      TIMESTAMP                                      │
│  revoked_by      UUID FK → User                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Permission Strings Format

Permissions use `resource.action` format:

```
pos.process_sale
pos.apply_discount
orders.view
orders.update_status
inventory.view
inventory.adjust
products.create
products.edit
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `staff` | `user_id, merchant_id` (unique) | Staff membership |
| `staff` | `merchant_id, status` | Active staff list |
| `staff_role` | `merchant_id, name` (unique) | Role lookup |
| `staff_role` | `merchant_id, is_system` | System roles |
| `role_assignment` | `user_id, role` | Platform role check |
| `role_assignment` | `role, revoked_at` | Active moderators/admins |

---

## API Endpoints

### Platform RBAC (Admin only)

### GET /v1/admin/users/{id}/roles

Get user's platform roles.

```json
// Response
{
  "user_id": "uuid",
  "roles": ["consumer", "moderator"]
}
```

### PUT /v1/admin/users/{id}/roles

Update user's platform roles.

```json
// Request
{
  "roles": ["consumer", "moderator", "admin"]
}

// Response
{
  "user_id": "uuid",
  "roles": ["consumer", "moderator", "admin"],
  "updated_at": "2026-01-28"
}
```

### Merchant RBAC (Owner only)

### GET /v1/merchant/roles

List merchant's staff roles.

```json
// Response
{
  "roles": [
    {
      "id": "uuid",
      "name": "Cashier",
      "description": "Front-line sales",
      "permissions": ["pos.process_sale", "pos.view_history", "orders.view"],
      "is_system": true
    },
    {
      "id": "uuid",
      "name": "Senior Cashier",
      "description": "Cashier with refund access",
      "permissions": ["pos.process_sale", "pos.process_refund", "orders.view"],
      "is_system": false
    }
  ]
}
```

### POST /v1/merchant/roles

Create a custom staff role.

```json
// Request
{
  "name": "Shift Manager",
  "description": "Manages daily operations",
  "permissions": [
    "pos.process_sale",
    "pos.process_refund",
    "orders.view",
    "orders.cancel",
    "shift.close"
  ]
}

// Response
{
  "id": "uuid",
  "name": "Shift Manager",
  "created_at": "2026-01-28"
}
```

### PUT /v1/merchant/roles/{id}

Update a staff role.

```json
// Request
{
  "name": "Shift Manager (Updated)",
  "permissions": ["pos.process_sale", "pos.process_refund", "orders.view", "orders.cancel", "shift.close", "reports.daily"]
}

// Response
{
  "id": "uuid",
  "updated_at": "2026-01-28"
}
```

### DELETE /v1/merchant/roles/{id}

Delete a custom role (system roles cannot be deleted).

```json
// Response
{
  "message": "Role deleted"
}
```

### GET /v1/merchant/staff

List merchant's staff members.

```json
// Response
{
  "staff": [
    {
      "id": "uuid",
      "user": { "name": "Aisha Rahman", "email": "aisha@email.com" },
      "role": { "id": "uuid", "name": "Cashier" },
      "status": "active",
      "last_active": "2026-01-28T14:30:00+09:00"
    }
  ],
  "total": 3,
  "limit": 5
}
```

### POST /v1/merchant/staff

Invite a staff member.

```json
// Request
{
  "email": "newstaff@email.com",
  "role_id": "uuid"
}

// Response
{
  "id": "uuid",
  "status": "invited",
  "invited_at": "2026-01-28"
}
```

### PUT /v1/merchant/staff/{id}

Update staff member (role, status).

```json
// Request
{
  "role_id": "uuid",
  "status": "suspended"
}

// Response
{
  "id": "uuid",
  "updated_at": "2026-01-28"
}
```

### DELETE /v1/merchant/staff/{id}

Remove staff member from merchant.

```json
// Response
{
  "message": "Staff removed"
}
```

---

## Authorization Flow

```
Request → Extract JWT → Get user_id
  → Load user with platform_role
  → Check route permission:
    
    Platform route?
      → Check platform_role (consumer/moderator/admin)
    
    Merchant route?
      → If owner: allow all merchant operations
      → If staff:
          → Load staff record with role
          → Get permissions = role.permissions + staff.permission_overrides
          → Check: permissions.includes("resource.action")
    
  → Allow or deny (401/403)
```

### Backend Implementation

```typescript
// Permission check middleware
function requirePermission(permission: string) {
  return async (req, res, next) => {
    const { userId, merchantId } = req;
    
    // Owner has all permissions
    if (await isOwner(userId, merchantId)) {
      return next();
    }
    
    // Staff: check specific permission
    const staff = await getStaff(userId, merchantId);
    if (!staff || staff.status !== 'active') {
      return res.status(403).json({ error: "Forbidden" });
    }
    
    const permissions = [
      ...staff.role.permissions,
      ...(staff.permission_overrides || [])
    ];
    
    if (permissions.includes(permission)) {
      return next();
    }
    
    res.status(403).json({ error: "Forbidden" });
  };
}

// Route usage
router.patch("/orders/:id/status", 
  requirePermission("orders.update_status"),
  updateOrderStatus
);

router.post("/orders/:id/cancel",
  requirePermission("orders.cancel"),
  cancelOrder
);

router.post("/queue/pause",
  requirePermission("queue.pause"),
  pauseQueue
);
```

---

## Future Enhancements

- **Custom roles** — Merchants define fully custom staff roles beyond defaults
- **Granular permissions** — Per-feature permission toggles within roles
- **Multi-merchant staff** — Staff works at multiple locations
- **Role hierarchy** — Manager role between Owner and Staff
- **Permission audit** — Track permission changes over time
- **Role templates** — Share role configurations between merchants

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
