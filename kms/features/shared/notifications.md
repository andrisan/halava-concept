# Notifications

> **Feature Type:** Shared (Consumer & Merchant)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[marketplace]] · [[pos]] · [[restaurant-ops]] · [[admin-moderation]]

---

## Definition

**Notifications** is Halava's communication system that keeps consumers and merchants informed about relevant events — orders, updates, promotions, and platform announcements.

**Core channels:**
- **In-app notifications** — Real-time alerts within the Halava app
- **Email notifications** — Transactional and digest emails
- **Push notifications** — PWA push for mobile users (future)

---

## How It Works

### For Consumers

Consumers receive notifications for:
- Order confirmations and status updates
- Food ready for pickup/serving (restaurant)
- Group purchase invitations and updates
- Promotional offers from saved merchants
- Account and security alerts

### For Merchants

Merchants receive notifications for:
- New incoming orders
- Payment confirmations
- Low stock alerts
- Customer reviews and ratings
- Platform announcements and policy updates

---

## Notification Types

### Order Lifecycle

| Event | Consumer | Merchant |
|-------|----------|----------|
| Order placed | ✅ "Order confirmed!" | ✅ 🔔 New order alert |
| Payment received | ✅ "Payment confirmed" | ✅ "Payment received" |
| Order preparing | ✅ "Your order is being prepared" | — |
| Order shipped | ✅ "Your order has shipped" | — |
| Ready for pickup | ✅ "Ready for pickup!" | — |
| Food ready (restaurant) | ✅ "Your food is ready!" | — |
| Order fulfilled | ✅ "Order completed" | ✅ "Order fulfilled" |
| Order cancelled | ✅ "Order cancelled" | ✅ "Order cancelled" |

### Group Purchase

| Event | Initiator | Participant |
|-------|-----------|-------------|
| Invitation sent | — | ✅ "You're invited to join..." |
| Participant joined | ✅ "[Name] joined your group" | — |
| Group finalized | ✅ "Group order placed!" | ✅ "Group order confirmed" |

### Merchant Operations

| Event | Owner | Staff |
|-------|-------|-------|
| New order | ✅ | ✅ |
| Low stock alert | ✅ | — |
| New review | ✅ | — |
| Payout processed | ✅ | — |
| Capability activated | ✅ | — |

### Platform & Admin

| Event | Recipient |
|-------|-----------|
| Report resolved | Reporter (consumer) |
| Account warning | Affected user |
| Policy update | All users |
| Maintenance notice | All users |

---

## User Journey

### Consumer: Manage Notifications

```
Profile → Settings → Notifications
  → In-app Notifications: ✓ On
  → Email Notifications:
    ○ Order updates: ✓
    ○ Promotions: ✓
    ○ Weekly digest: ○
  → Push Notifications (if PWA installed):
    ○ Order ready: ✓
    ○ Group invites: ✓
  → [Save Preferences]
```

### Consumer: View Notifications

```
Header → 🔔 Bell icon (badge: 3)
  → Dropdown: Recent notifications
    • "Your order is ready for pickup" — 5m ago
    • "Halal Mart has a new promotion" — 2h ago
    • "[Friend] invited you to a group order" — 1d ago
  → [Mark all as read]
  → [View All] → /notifications
```

### Merchant: Configure Alerts

```
Merchant Dashboard → Settings → Notifications
  → New Order Alerts:
    ○ Sound: ✓ On
    ○ Email: ✓ On
  → Low Stock Alerts:
    ○ Threshold: 10 units
    ○ Email: ✓ On
  → Review Notifications: ✓ On
  → [Save]
```

---

## UI/UX Specification

> **Template Support:** Mobile + Desktop (see [[pages-navigation-ux-spec#1. Dual-Template Architecture]])

### Screens

| Screen | Path | Mobile | Desktop |
|--------|------|--------|---------|
| **Notifications List** | `/notifications` | Full-screen list | Dropdown or page |
| **Notification Settings** | `/settings/notifications` | Full-screen | Settings page |
| **Merchant Alerts** | `/dashboard/settings/notifications` | N/A (desktop only) | Settings page |

### Notification Bell (Header)

```
┌─────────────────────────────────────────┐
│ [Logo]  🔍 Search    [♡] [🛒] [🔔3]     │
└─────────────────────────────────────────┘
                                    ↓
                        ┌─────────────────────┐
                        │ Notifications       │
                        ├─────────────────────┤
                        │ 🍽️ Your food is     │
                        │    ready for pickup │
                        │    5 minutes ago    │
                        ├─────────────────────┤
                        │ 📦 Order shipped    │
                        │    Halal Mart       │
                        │    2 hours ago      │
                        ├─────────────────────┤
                        │ 👥 Group invite     │
                        │    from Ahmad       │
                        │    1 day ago        │
                        ├─────────────────────┤
                        │ [View All →]        │
                        └─────────────────────┘
```

### Notifications Page

```
┌──────────────────────────────────────────┐
│ [←] Notifications              [⚙️]     │
├──────────────────────────────────────────┤
│ [All] [Orders] [Social] [Promotions]    │
│                                          │
│ Today                                    │
│ ┌──────────────────────────────────────┐ │
│ │ 🍽️ Your food is ready!              │ │
│ │ Halal Bistro · Order #0087          │ │
│ │ 5 minutes ago                   [→] │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ 📦 Order shipped                     │ │
│ │ Halal Mart · Tracking: JP123456     │ │
│ │ 2 hours ago                     [→] │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Yesterday                                │
│ ┌──────────────────────────────────────┐ │
│ │ 👥 Ahmad invited you to group order │ │
│ │ Tap to view and join                │ │
│ │ 1 day ago                       [→] │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Earlier                                  │
│ ...                                      │
└──────────────────────────────────────────┘
```

### Notification Settings

```
┌──────────────────────────────────────────┐
│ [←] Notification Settings                │
├──────────────────────────────────────────┤
│                                          │
│ In-App Notifications                     │
│ ┌──────────────────────────────────────┐ │
│ │ Enable notifications          [ON]  │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Email Notifications                      │
│ ┌──────────────────────────────────────┐ │
│ │ Order updates                 [ON]  │ │
│ │ Shipping & delivery           [ON]  │ │
│ │ Promotions & offers          [OFF]  │ │
│ │ Weekly spending digest       [OFF]  │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ Push Notifications                       │
│ ┌──────────────────────────────────────┐ │
│ │ Order ready alerts            [ON]  │ │
│ │ Group purchase invites        [ON]  │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [ Save Preferences ]                     │
└──────────────────────────────────────────┘
```

---

## Data Model

### Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                       Notification                               │
├─────────────────────────────────────────────────────────────────┤
│  id              UUID PRIMARY KEY                               │
│  user_id         UUID FK → User                                 │
│  type            VARCHAR(50) NOT NULL                           │
│                  (order_placed, order_ready, group_invite,      │
│                   review_received, low_stock, etc.)             │
│  title           VARCHAR(255) NOT NULL                          │
│  body            TEXT                                           │
│  data            JSONB (order_id, merchant_id, etc.)            │
│  read_at         TIMESTAMP                                      │
│  created_at      TIMESTAMP NOT NULL                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                 NotificationPreference                           │
├─────────────────────────────────────────────────────────────────┤
│  user_id         UUID FK → User PRIMARY KEY                     │
│  in_app_enabled  BOOLEAN DEFAULT true                           │
│  email_orders    BOOLEAN DEFAULT true                           │
│  email_shipping  BOOLEAN DEFAULT true                           │
│  email_promos    BOOLEAN DEFAULT false                          │
│  email_digest    BOOLEAN DEFAULT false                          │
│  push_order_ready  BOOLEAN DEFAULT true                         │
│  push_group_invite BOOLEAN DEFAULT true                         │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│             MerchantNotificationPreference                       │
├─────────────────────────────────────────────────────────────────┤
│  merchant_id     UUID FK → Merchant PRIMARY KEY                 │
│  new_order_sound BOOLEAN DEFAULT true                           │
│  new_order_email BOOLEAN DEFAULT true                           │
│  low_stock_email BOOLEAN DEFAULT true                           │
│  low_stock_threshold  INT DEFAULT 10                            │
│  review_notification  BOOLEAN DEFAULT true                      │
│  updated_at      TIMESTAMP                                      │
└─────────────────────────────────────────────────────────────────┘
```

### Indexes

| Table | Index | Purpose |
|-------|-------|---------|
| `notification` | `user_id, created_at DESC` | User notifications list |
| `notification` | `user_id, read_at` | Unread count |
| `notification` | `type, created_at` | Analytics queries |

---

## API Endpoints

> Full API index: [[api-spec#8. Notification Module]]

### GET /v1/notifications

List user's notifications.

```
Query Parameters:
  type          string    Filter: order, social, promo (optional)
  unread_only   boolean   Only unread notifications
  limit         int       Results per page (default: 20)
  offset        int       Pagination offset
```

```json
// Response
{
  "notifications": [
    {
      "id": "uuid",
      "type": "order_ready",
      "title": "Your food is ready!",
      "body": "Halal Bistro · Order #0087",
      "data": { "order_id": "uuid" },
      "read_at": null,
      "created_at": "2026-01-28T12:30:00+09:00"
    }
  ],
  "total": 45,
  "unread_count": 3
}
```

### POST /v1/notifications/{id}/read

Mark a notification as read.

```json
// Response
{
  "id": "uuid",
  "read_at": "2026-01-28T12:35:00+09:00"
}
```

### POST /v1/notifications/read-all

Mark all notifications as read.

```json
// Response
{
  "marked_count": 3
}
```

### GET /v1/notifications/preferences

Get notification preferences.

```json
// Response
{
  "in_app_enabled": true,
  "email_orders": true,
  "email_shipping": true,
  "email_promos": false,
  "email_digest": false,
  "push_order_ready": true,
  "push_group_invite": true
}
```

### PUT /v1/notifications/preferences

Update notification preferences.

```json
// Request
{
  "email_promos": true,
  "push_order_ready": false
}

// Response
{
  "message": "Preferences updated"
}
```

### GET /v1/merchant/notifications/preferences

Get merchant notification preferences.

```json
// Response
{
  "new_order_sound": true,
  "new_order_email": true,
  "low_stock_email": true,
  "low_stock_threshold": 10,
  "review_notification": true
}
```

### PUT /v1/merchant/notifications/preferences

Update merchant notification preferences.

```json
// Request
{
  "new_order_sound": false,
  "low_stock_threshold": 5
}

// Response
{
  "message": "Preferences updated"
}
```

---

## Delivery Channels

### In-App

- Real-time via WebSocket/SSE
- Stored in database for persistence
- Badge count on bell icon
- Dropdown for quick view

### Email

- Transactional emails via SendGrid/SES
- Templates for each notification type
- Unsubscribe link in footer
- Rate-limited to prevent spam

### Push (Future - PWA)

- Service Worker registration
- Web Push API
- Permission prompt on first relevant action
- Fallback to in-app if denied

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Notification delivery rate | > 99% |
| Email open rate | > 40% |
| Push opt-in rate | > 30% |
| Click-through rate | > 15% |

---

## Dependencies

- [[marketplace]] — Order notifications
- [[restaurant-ops]] — Food ready notifications
- [[group-purchase]] — Group invite notifications
- [[admin-moderation]] — System/policy notifications

---

#halava #feature #notifications #consumer #merchant
