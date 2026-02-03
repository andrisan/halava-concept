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

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Notifications List** | `/notifications` | All notifications |
| **Notification Settings** | `/settings/notifications` | Preferences |
| **Merchant Alerts** | `/merchant/settings/notifications` | Merchant config |

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

```
Notification
├── id: UUID
├── user_id: FK → User
├── type: enum (order, group, review, promo, system, alert)
├── title: string
├── body: text
├── data: JSONB
│   └── { order_id, merchant_id, action_url, ... }
├── read_at: timestamp (nullable)
├── created_at: timestamp

NotificationPreference
├── user_id: FK → User (unique)
├── in_app_enabled: boolean (default: true)
├── email_orders: boolean (default: true)
├── email_promos: boolean (default: false)
├── email_digest: boolean (default: false)
├── push_order_ready: boolean (default: true)
├── push_group_invite: boolean (default: true)
├── updated_at: timestamp

MerchantNotificationPreference
├── merchant_id: FK → Merchant (unique)
├── new_order_sound: boolean (default: true)
├── new_order_email: boolean (default: true)
├── low_stock_email: boolean (default: true)
├── low_stock_threshold: int (default: 10)
├── review_notification: boolean (default: true)
├── updated_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/notifications` | List user's notifications |
| `PUT` | `/api/v1/notifications/{id}/read` | Mark as read |
| `PUT` | `/api/v1/notifications/read-all` | Mark all as read |
| `GET` | `/api/v1/notifications/preferences` | Get preferences |
| `PUT` | `/api/v1/notifications/preferences` | Update preferences |
| `GET` | `/api/v1/merchant/notifications/preferences` | Merchant prefs |
| `PUT` | `/api/v1/merchant/notifications/preferences` | Update merchant prefs |

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
