# Halava Design System

> **Last updated:** February 2026
> **Status:** In Progress
>
> **Related documents:**
> - [[wireframes]] — Screen wireframes
> - [[pages-navigation-ux-spec]] — Page specifications
> - [[architecture]] — Technical stack (UI components)

---

## 1. Design Principles

1. **Halal First** — Trust indicators are prominent and clear
2. **Consumer Friendly** — Simple, intuitive shopping experience
3. **Merchant Empowering** — Powerful tools with minimal friction
4. **Mobile First** — Optimized for on-the-go usage
5. **Accessible** — WCAG 2.1 AA compliance target

---

## 2. Color Palette

### Primary Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Primary** | TBD | Buttons, links, accents |
| **Primary Dark** | TBD | Hover states |
| **Primary Light** | TBD | Backgrounds |

### Semantic Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Success** | TBD | Confirmations, positive actions |
| **Warning** | TBD | Alerts, low stock |
| **Error** | TBD | Errors, destructive actions |
| **Info** | TBD | Informational |

### Neutrals

| Name | Hex | Usage |
|------|-----|-------|
| **Gray 50-900** | TBD | Text, backgrounds, borders |

---

## 3. Typography

### Font Stack

| Role | Font | Fallback |
|------|------|----------|
| **Headings** | TBD | sans-serif |
| **Body** | TBD | sans-serif |
| **Monospace** | TBD | monospace |

### Type Scale

| Level | Size | Weight | Line Height |
|-------|------|--------|-------------|
| H1 | 2.25rem | 700 | 1.2 |
| H2 | 1.875rem | 700 | 1.25 |
| H3 | 1.5rem | 600 | 1.3 |
| H4 | 1.25rem | 600 | 1.4 |
| Body | 1rem | 400 | 1.5 |
| Small | 0.875rem | 400 | 1.5 |
| Caption | 0.75rem | 400 | 1.5 |

---

## 4. Spacing System

| Token | Value | Usage |
|-------|-------|-------|
| `space-1` | 0.25rem (4px) | Tight spacing |
| `space-2` | 0.5rem (8px) | Small gaps |
| `space-3` | 0.75rem (12px) | Default gaps |
| `space-4` | 1rem (16px) | Component padding |
| `space-6` | 1.5rem (24px) | Section spacing |
| `space-8` | 2rem (32px) | Large gaps |
| `space-12` | 3rem (48px) | Page sections |

---

## 5. Component Library

> Using shadcn/ui as base. See [[architecture#Frontend Stack]].

### Navigation Components

- [ ] Global Topbar
- [ ] Merchant Topbar
- [ ] Dashboard Sidebar
- [ ] Breadcrumbs
- [ ] Tab Navigation
- [ ] Bottom Navigation (mobile)

### Commerce Components

- [ ] Product Card
- [ ] Merchant Card
- [ ] Category Grid
- [ ] Add-to-Cart Button
- [ ] Quantity Selector
- [ ] Cart Drawer
- [ ] Order Summary
- [ ] Checkout Stepper

### POS Components

- [ ] POS Product Grid
- [ ] POS Cart Panel
- [ ] Payment Selector
- [ ] QR Scanner
- [ ] Quota Banner
- [ ] Receipt View

### Form Components

- [ ] Text Input
- [ ] Select Dropdown
- [ ] Checkbox / Radio
- [ ] Date/Time Picker
- [ ] File Upload

### Feedback Components

- [ ] Toast Notification
- [ ] Status Badge
- [ ] Loading Skeleton
- [ ] Empty State
- [ ] Progress Stepper

---

## 6. Accessibility Guidelines

### Touch Targets

- Minimum size: 44x44px
- Adequate spacing between targets
- Clear focus indicators

### Color Contrast

- Text: WCAG AA (4.5:1 minimum)
- Large text: 3:1 minimum
- UI components: 3:1 minimum

### Screen Reader Support

- Semantic HTML elements
- ARIA labels where needed
- Focus management for modals

---

## 7. Responsive Breakpoints

| Name | Width | Target |
|------|-------|--------|
| **sm** | 640px | Mobile landscape |
| **md** | 768px | Tablet portrait |
| **lg** | 1024px | Tablet landscape / Small laptop |
| **xl** | 1280px | Desktop |
| **2xl** | 1536px | Large desktop |

---

#halava #design #design-system
