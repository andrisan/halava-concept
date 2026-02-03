# Authentication

> **Feature Type:** Shared (Consumer & Merchant)
> **Version:** MVP (v1)
> **Status:** Active
>
> **Related:** [[onboarding]] · [[roles-permissions]] · [[web-app-spec]]

---

## Definition

**Authentication** is Halava's identity and access management system. It uses **passwordless authentication** (OTP/magic link) as the primary method, with optional social login providers.

**Core principles:**
- **Passwordless first** — No passwords to remember or leak
- **Unified identity** — One account system for consumers, merchants, and staff
- **Role-based access** — Permissions determined by role, not account type

---

## Authentication Methods

| Method | Description | Use Case |
|--------|-------------|----------|
| **Email OTP** | 6-digit code sent to email | Primary method |
| **Magic Link** | One-click login link via email | Alternative to OTP |
| **Google OAuth** | Sign in with Google account | Social login option |
| **Apple Sign-In** | Sign in with Apple ID | iOS users |

---

## How It Works

### Passwordless Flow

```
User enters email
  → System checks if account exists
  → If new: Create account, send OTP
  → If existing: Send OTP
  → User enters OTP (or clicks magic link)
  → System verifies, issues session token
  → User authenticated
```

### Session Management

| Aspect | Value |
|--------|-------|
| Session duration | 7 days (sliding) |
| Refresh token | 30 days |
| Concurrent sessions | Unlimited |
| Session storage | HTTP-only secure cookies + JWT |

### Token Structure

```
Access Token (JWT, 15 min expiry)
├── sub: user_id
├── email: string
├── role: consumer | merchant_owner | staff | moderator | admin
├── merchant_id: UUID (if merchant/staff)
├── staff_permissions: string[] (if staff)
├── iat, exp: timestamps

Refresh Token (opaque, 30 day expiry)
├── Stored server-side
├── Rotated on use
├── Revocable
```

---

## User Roles & Access

> See [[roles-permissions]] for detailed permission matrix.

| Role | Description | Access Level |
|------|-------------|--------------|
| **Consumer** | End user | Browse, purchase, reviews |
| **Merchant Owner** | Business operator | Full merchant dashboard |
| **Staff** | Merchant employee | Role-limited merchant access |
| **Moderator** | Platform team | Reports, content moderation |
| **Admin** | Platform admin | Full platform access |

### Staff Authentication

Staff members authenticate with their own email but access is scoped to their assigned merchant:

```
Staff login
  → Verify email/OTP
  → Check Staff record exists
  → Load merchant_id and staff_role
  → Issue token with staff_permissions
  → Redirect to merchant dashboard (limited view)
```

---

## User Journey

### Consumer/Merchant: Login (Returning User)

```
Home → [Sign In]
  → Enter email
  → "We sent a code to your email"
  → Enter 6-digit OTP
  → ✅ Logged in
  → Redirect to previous page or dashboard
```

### Staff: Login

```
Merchant Staff Login → [Sign In]
  → Enter email
  → Enter OTP
  → ✅ Logged in as Staff
  → Redirect to Merchant Dashboard (limited by role)
  → See only permitted sections (e.g., POS only for Cashier)
```

### User: Logout

```
Profile Menu → [Sign Out]
  → Clear session token
  → Revoke refresh token
  → Redirect to Home
```

### User: Switch Account

```
Profile Menu → [Switch Account]
  → Show linked accounts (if any)
  → Select account or [Add Account]
  → Re-authenticate if needed
```

---

## UI/UX Specification

### Screens

| Screen | Path | Purpose |
|--------|------|---------|
| **Sign In** | `/login` | Returning user login |
| **Verify Code** | `/verify` | OTP entry |
| **Check Email** | `/check-email` | Magic link sent confirmation |

### Sign In Screen

```
┌──────────────────────────────────────────┐
│ Sign In                                  │
├──────────────────────────────────────────┤
│                                          │
│ Welcome back to Halava.                  │
│                                          │
│ ┌──────────────────────────────────────┐ │
│ │ Email                                │ │
│ └──────────────────────────────────────┘ │
│                                          │
│ [ Continue ]                             │
│                                          │
│ ─────────── or ───────────               │
│                                          │
│ [ Continue with Google ]                 │
│ [ Continue with Apple ]                  │
│                                          │
│ Don't have an account? [Sign Up]         │
│                                          │
└──────────────────────────────────────────┘
```

### OTP Entry Screen

```
┌──────────────────────────────────────────┐
│ Enter Code                               │
├──────────────────────────────────────────┤
│                                          │
│ We sent a 6-digit code to:               │
│ user@example.com                         │
│                                          │
│ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐│
│ │  1 │ │  2 │ │  3 │ │  4 │ │  5 │ │  6 ││
│ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘│
│                                          │
│ Code expires in 10:00                    │
│                                          │
│ Didn't receive it?                       │
│ [Resend Code] · [Try Magic Link Instead] │
│                                          │
│ [← Back]                                 │
└──────────────────────────────────────────┘
```

### Magic Link Sent

```
┌──────────────────────────────────────────┐
│ Check Your Email                         │
├──────────────────────────────────────────┤
│                                          │
│         ┌─────────────────┐              │
│         │     ✉️           │              │
│         └─────────────────┘              │
│                                          │
│ We sent a login link to:                 │
│ user@example.com                         │
│                                          │
│ Click the link in your email to sign in. │
│ The link expires in 15 minutes.          │
│                                          │
│ [Open Email App]                         │
│                                          │
│ Didn't receive it? [Resend]              │
│ Prefer a code? [Use OTP Instead]         │
│                                          │
└──────────────────────────────────────────┘
```

---

## Data Model

```
User
├── id: UUID
├── email: string (unique, indexed)
├── name: string
├── phone: string (nullable)
├── role: enum (consumer, merchant_owner, staff, moderator, admin)
├── email_verified_at: timestamp
├── last_login_at: timestamp
├── created_at: timestamp

Session
├── id: UUID
├── user_id: FK → User
├── refresh_token_hash: string
├── device_info: JSONB
│   └── { user_agent, ip, device_type }
├── expires_at: timestamp
├── revoked_at: timestamp (nullable)
├── created_at: timestamp

OTPCode
├── id: UUID
├── email: string (indexed)
├── code_hash: string
├── purpose: enum (login, verify_email)
├── attempts: int (max 5)
├── expires_at: timestamp
├── used_at: timestamp (nullable)
├── created_at: timestamp

MagicLink
├── id: UUID
├── email: string
├── token_hash: string
├── expires_at: timestamp
├── used_at: timestamp (nullable)
├── created_at: timestamp

OAuthConnection
├── id: UUID
├── user_id: FK → User
├── provider: enum (google, apple)
├── provider_user_id: string
├── email: string
├── created_at: timestamp
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/v1/auth/login` | Initiate login (send OTP) |
| `POST` | `/api/v1/auth/verify-otp` | Verify OTP code |
| `GET` | `/api/v1/auth/magic-link/{token}` | Verify magic link |
| `POST` | `/api/v1/auth/refresh` | Refresh access token |
| `POST` | `/api/v1/auth/logout` | Logout (revoke session) |
| `GET` | `/api/v1/auth/sessions` | List active sessions |
| `DELETE` | `/api/v1/auth/sessions/{id}` | Revoke specific session |
| `POST` | `/api/v1/auth/oauth/google` | Google OAuth callback |
| `POST` | `/api/v1/auth/oauth/apple` | Apple Sign-In callback |

### Login Request

```json
// POST /api/v1/auth/login
{
  "email": "user@example.com",
  "method": "otp"  // or "magic_link"
}

// Response
{
  "message": "Code sent to email",
  "expires_in": 600,
  "method": "otp"
}
```

### Verify OTP

```json
// POST /api/v1/auth/verify-otp
{
  "email": "user@example.com",
  "code": "123456"
}

// Response
{
  "access_token": "eyJ...",
  "refresh_token": "abc...",
  "expires_in": 900,
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "name": "Ahmad",
    "role": "consumer"
  }
}
```

---

## Security Considerations

### Rate Limiting

| Action | Limit |
|--------|-------|
| OTP requests per email | 5 per 15 min |
| OTP verification attempts | 5 per code |
| Login attempts per IP | 20 per 15 min |
| Magic link requests | 3 per 15 min |

### OTP Security

- 6-digit numeric code
- Valid for 10 minutes
- Single use
- Max 5 attempts before code invalidation
- Codes are hashed (not stored plain)

### Token Security

- Access tokens: Short-lived (15 min)
- Refresh tokens: Rotated on each use
- HTTP-only cookies for web
- Secure flag in production
- CSRF protection for cookie-based auth

### Session Security

- Sessions can be viewed and revoked
- Last login time tracked
- Device info stored for recognition
- Suspicious login alerts (future)

---

## Edge Cases

| Scenario | Handling |
|----------|----------|
| User enters wrong OTP 5 times | Code invalidated, must request new |
| Magic link clicked twice | Second click shows "already used" |
| Email not found (login) | Create account flow suggested |
| OAuth email mismatch | Link accounts or create new |
| Staff removed while logged in | Next API call returns 403, forced logout |
| Session expired during checkout | Preserve cart, prompt re-login |

---

## Success Metrics

| Metric | Target (MVP) |
|--------|--------------|
| Login success rate | > 95% |
| OTP delivery time | < 30 seconds |
| Average login time | < 45 seconds |
| Session security incidents | 0 |

---

## Dependencies

- [[onboarding]] — Registration flow (first-time users)
- [[roles-permissions]] — Permission matrix
- [[notifications]] — OTP/magic link delivery

---

#halava #feature #authentication #security #shared
