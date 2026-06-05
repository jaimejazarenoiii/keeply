# Design System Inspired by Marin Kurir

## 1. Visual Theme & Atmosphere

The Marin Kurir design system embodies a sophisticated, minimalist aesthetic rooted in Scandinavian design principles. It balances clean typography with bold geometric forms, emphasizing restraint and purposeful hierarchy. The atmosphere is professional yet approachable, combining deep charcoal accents with soft cool-toned neutrals to create visual breathing room. The design philosophy prioritizes content clarity, letting typography and whitespace guide user attention through deliberately sparse layouts. This system reflects the work of a senior digital designer who merges everyday usability with strong visual storytelling—every element serves a purpose, and every interaction feels intentional.

**Key Characteristics**
- Minimalist, Nordic-inspired aesthetic
- Typography-driven hierarchy with generous whitespace
- Cool, muted color palette with occasional electric blue accents
- Clean, geometric forms with subtle depth
- High contrast for readability and visual impact
- Focus on craft and intentional design decisions
- Restrained use of color for maximum emotional resonance

## 2. Color Palette & Roles (Updated for Keeply Green Theme)

### Primary

### Keeply Green

* **Primary:** `#22C55E`
* Purpose: Primary call-to-actions, active navigation states, interactive highlights, focus states, and key brand moments.
* Accessibility: White text on Primary meets WCAG AA standards.

### Primary Variants

* **Primary Hover:** `#16A34A`
* **Primary Pressed:** `#15803D`
* **Primary Light:** `#DCFCE7`
* **Primary Surface:** `#F0FDF4`

---

## Semantic Colors

### Success

* **Success:** `#22C55E`
* **Success Surface:** `#DCFCE7`

### Warning

* **Warning:** `#F59E0B`
* **Warning Surface:** `#FEF3C7`

### Error

* **Error:** `#EF4444`
* **Error Surface:** `#FEE2E2`

### Information

* **Info:** `#3B82F6`
* **Info Surface:** `#DBEAFE`

---

## Neutral Scale

### Charcoal Deep

* `#18191A`
* Primary headings and strongest visual anchors.

### Graphite

* `#212324`
* Primary body text and standard foreground content.

### Stone

* `#6B7280`
* Secondary text and supporting content.

### Pebble

* `#9CA3AF`
* Tertiary text, placeholders, helper labels.

### Silver

* `#D1D5DB`
* Borders, dividers, separators.

### Cloud

* `#F9FAFB`
* Subtle background regions.

### White

* `#FFFFFF`
* Primary application surfaces.

---

## Surface Roles

### Primary Surface

* `#FFFFFF`
* Default screen backgrounds.

### Secondary Surface

* `#F9FAFB`
* Alternative sections and grouped content.

### Brand Surface

* `#F0FDF4`
* Brand-colored containers, highlights, and featured sections.

### Elevated Surface

* `#FFFFFF`
* Cards, modals, sheets, and overlays.

---

## Interactive States

### Hover

* `#16A34A`

### Pressed

* `#15803D`

### Focus Ring

* `#22C55E`

### Selected Background

* `#DCFCE7`

### Disabled Background

* `#F3F4F6`

### Disabled Foreground

* `#9CA3AF`

---

## Quick Color Reference

| Usage          | Color     |
| -------------- | --------- |
| Primary CTA    | `#22C55E` |
| CTA Hover      | `#16A34A` |
| CTA Pressed    | `#15803D` |
| Brand Surface  | `#F0FDF4` |
| Selected State | `#DCFCE7` |
| Primary Text   | `#212324` |
| Secondary Text | `#6B7280` |
| Borders        | `#D1D5DB` |
| Success        | `#22C55E` |
| Warning        | `#F59E0B` |
| Error          | `#EF4444` |
| Background     | `#FFFFFF` |

---

## Global Replacement Rules

Replace every occurrence of:

* `#0000EE` → `#22C55E`
* `#D0E5E5` → `#DCFCE7`
* `#F2F6F7` → `#F0FDF4`
* `#D3FF35` → `#F59E0B`

Update all:

* Primary buttons
* Active navigation states
* Input focus borders
* Selected chips
* Active tabs
* Progress indicators
* Loading indicators
* Toggle switches

to use the Keeply Green palette.

The design system should feel organized, trustworthy, fresh, and storage-focused, using green as the dominant brand signal while preserving the minimalist Scandinavian-inspired typography and spacing system.


## 3. Typography Rules

### Font Family
**Primary:** Roc Grotesk Variable (https://fonts.googleapis.com/)
Fallback stack: `Roc Grotesk Variable, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif`

**Secondary:** Same as primary; system utilizes a single geometric sans-serif family for absolute consistency.

### Hierarchy

| Role | Font | Size | Weight | Line Height | Letter Spacing | Notes |
|------|------|------|--------|-------------|-----------------|-------|
| Display / Hero | Roc Grotesk Variable | 230px | 500 | 230px | 0px | Maximum impact; reserved for primary page header or hero statement |
| Heading 1 | Roc Grotesk Variable | 30px | 400 | 33px | 0px | Section headings and major title blocks |
| Heading 2 | Roc Grotesk Variable | 26px | 400 | 34px | 0px | Subsection headings and card titles |
| Body Large | Roc Grotesk Variable | 24px | 400 | 36px | 0px | Introduction text, featured paragraphs, navigation links |
| Body Regular | Roc Grotesk Variable | 16px | 400 | 22px | 0px | Standard body copy and form inputs |
| Label / Button | Roc Grotesk Variable | 16px | 600 | 22px | 0px | Button labels, form labels, emphasis text |
| Caption | Roc Grotesk Variable | 14px | 400 | 20px | 0px | Metadata, timestamps, secondary information |
| Code | Roc Grotesk Variable | 12px | 400 | 18px | 0px | Monospace-equivalent for technical content |

### Principles
- **Intentional Scale:** Typography jumps follow geometric proportions; each size serves a distinct hierarchical purpose with no redundant steps.
- **Weight Restraint:** System uses only weight 400 (regular) and 600 (semibold) to maintain visual consistency and prevent complexity.
- **Generous Line Height:** All line heights exceed font size to support comfortable reading and visual breathing room.
- **Single Family:** Roc Grotesk Variable provides geometric clarity across all sizes; its variable nature enables smooth scaling without font switching.
- **All Caps Sparingly:** Uppercase reserved for small emphasis text (labels, buttons) only; body copy remains sentence-case for readability.

## 4. Component Stylings

### Buttons

#### Primary Button
- **Background:** `#FFFFFF`
- **Text Color:** `#0000EE`
- **Padding:** `12px 24px`
- **Border:** `1px solid #D0E5E5`
- **Border Radius:** `100px`
- **Font Size:** `24px`
- **Font Weight:** `400`
- **Height:** `46px`
- **Line Height:** `36px`
- **Hover State:** Background `#F2F6F7`, text color `#0000EE`, border `1px solid #D0E5E5`
- **Active State:** Background `#D0E5E5`, text color `#0000EE`
- **Disabled State:** Opacity `0.5`, cursor `not-allowed`

#### Secondary Button (Text Link)
- **Background:** `transparent`
- **Text Color:** `#212324`
- **Padding:** `20px 20px`
- **Border:** `none`
- **Border Radius:** `0px`
- **Font Size:** `24px`
- **Font Weight:** `400`
- **Height:** `auto`
- **Line Height:** `36px`
- **Hover State:** Text color `#0000EE`, underline `1px solid #0000EE`
- **Active State:** Text color `#0000EE`

#### Ghost Button
- **Background:** `transparent`
- **Text Color:** `#D0E5E5`
- **Padding:** `16px 20px`
- **Border:** `1px solid #D0E5E5`
- **Border Radius:** `100px`
- **Font Size:** `16px`
- **Font Weight:** `600`
- **Height:** `44px`
- **Line Height:** `22px`
- **Hover State:** Background `#D0E5E5`, text color `#FFFFFF`, border `1px solid #D0E5E5`
- **Active State:** Background `#96A6A6`, text color `#FFFFFF`

### Cards & Containers

#### Hero Card (Full Width Content Block)
- **Background:** `#FFFFFF`
- **Padding:** `48px 40px`
- **Border:** `1px solid #D0E5E5`
- **Border Radius:** `0px`
- **Box Shadow:** `none`
- **Text Color:** `#212324`
- **Heading Font Size:** `26px`
- **Body Font Size:** `24px`

#### Content Section Card
- **Background:** `#F2F6F7`
- **Padding:** `40px 36px`
- **Border:** `1px solid #D0E5E5`
- **Border Radius:** `0px`
- **Box Shadow:** `none`
- **Text Color:** `#212324`

#### Media Container (Image / Video)
- **Background:** `#212324` (for dark contexts)
- **Border Radius:** `1200px` (circular/pill for avatars and featured media)
- **Border:** `none`
- **Overflow:** `hidden`

### Inputs & Forms

#### Text Input
- **Background:** `#FFFFFF`
- **Text Color:** `#212324`
- **Padding:** `12px 16px`
- **Border:** `1px solid #B7BBBD`
- **Border Radius:** `0px`
- **Font Size:** `16px`
- **Font Weight:** `400`
- **Line Height:** `22px`
- **Placeholder Color:** `#96A6A6`
- **Focus State:** Border `1px solid #0000EE`, box-shadow `none`
- **Disabled State:** Background `#F2F6F7`, color `#96A6A6`, border `1px solid #B7BBBD`

#### Form Label
- **Text Color:** `#212324`
- **Font Size:** `16px`
- **Font Weight:** `600`
- **Line Height:** `22px`
- **Margin Bottom:** `8px`

### Navigation

#### Header Navigation (Desktop)
- **Background:** `transparent`
- **Text Color:** `#D0E5E5`
- **Font Size:** `24px`
- **Font Weight:** `400`
- **Line Height:** `36px`
- **Padding:** `0px`
- **Border:** `none`
- **Height:** `auto`
- **Hover State:** Text color `#0000EE`
- **Active State:** Text color `#0000EE`, border-bottom `2px solid #0000EE`

#### Logo / Branding
- **Text:** "MARIN_KURIR"
- **Font Size:** `16px`
- **Font Weight:** `400`
- **Background:** `rgba(255, 255, 255, 0.95)`
- **Padding:** `8px 16px`
- **Border Radius:** `100px`
- **Border:** `1px solid #D0E5E5`
- **Text Color:** `#212324`

### Navigation Link (Pill Style)
- **Background:** `#FFFFFF`
- **Text Color:** `#212324`
- **Font Size:** `16px`
- **Font Weight:** `400`
- **Padding:** `12px 24px`
- **Border Radius:** `100px`
- **Border:** `1px solid #D0E5E5`
- **Height:** `40px`
- **Line Height:** `16px`
- **Hover State:** Background `#F2F6F7`, border `1px solid #D0E5E5`
- **Active State:** Background `#D0E5E5`, text color `#FFFFFF`

### Accent Elements

#### Divider / Separator
- **Border:** `1px solid #B7BBBD`
- **Height:** `1px`
- **Margin:** `32px 0px`

#### Asterisk / Marker Icon
- **Font Size:** `24px`
- **Color:** `#212324`
- **Font Weight:** `700`

#### Metadata / Caption Text
- **Font Size:** `14px`
- **Font Weight:** `400`
- **Color:** `#96A6A6`
- **Line Height:** `20px`

## 5. Layout Principles

### Spacing System

**Base Unit:** `4px`

**Spacing Scale:**
- `4px` - Micro spacing within components (icon-to-text gaps)
- `8px` - Small padding within form inputs or tight groupings
- `12px` - Small component padding
- `16px` - Standard gap between inline elements and form field padding
- `20px` - Medium padding within cards and navigation elements
- `24px` - Standard padding for buttons and component interiors
- `28px` - Large padding between content blocks
- `32px` - Margin between sections
- `36px` - Extra-large margin for major layout shifts
- `40px` - Hero section and container padding
- `44px` - Gap between major content sections
- `48px` - Maximum margin between page regions and hero blocks

**Usage Context:**
- Internal component spacing: `4px–8px`
- Standard padding: `16px–24px`
- Section margins: `32px–48px`
- Grid gaps: `16px–44px` depending on density

### Grid & Container

**Max Width:** `1280px`
- Primary content container maximum width for optimal readability and visual balance.

**Column Strategy:** 12-column fluid grid with 16px gutters
- Adapts fluidly across breakpoints without discrete column changes.
- Enables 1-column mobile, 2–3 column tablet, and multi-column desktop layouts.

**Section Patterns:**
- Full-width hero (no max-width constraint)
- Centered container with symmetric margins on desktop
- Left-aligned content on mobile with 16px safe margins
- Alternating content and image sections with 44px gaps

**Container Padding:**
- Desktop: `40px` horizontal
- Tablet: `28px` horizontal
- Mobile: `16px` horizontal

### Whitespace Philosophy

Whitespace is an active design element, not a void. The system emphasizes generous spacing around typography and interactive elements to support visual hierarchy and cognitive processing. Large margins between sections prevent information overload and create intentional pauses. Internal padding within components (buttons, inputs) follows a conservative scale, while inter-section margins scale dramatically to establish clear content regions. This approach mirrors Scandinavian design principles: clarity through restraint.

### Border Radius Scale

- `0px` - All primary containers, cards, and form inputs (sharp, geometric edges)
- `100px` - Pill-shaped buttons, soft navigation elements, and slightly rounded inputs for affordance
- `1200px` - Circular or extreme rounding for avatar images, featured media containers, and geometric focal points

## 6. Depth & Elevation

| Level | Treatment | Use |
|-------|-----------|-----|
| Surface (L0) | No shadow, flat | Base containers, main content areas, default state |
| Raised (L1) | `box-shadow: 0 2px 8px rgba(33, 35, 36, 0.08)` | Hover states on cards, elevated buttons |
| Floating (L2) | `box-shadow: 0 4px 16px rgba(33, 35, 36, 0.12)` | Modals, dropdowns, overlays, interactive focus states |
| Deep (L3) | `box-shadow: 0 8px 24px rgba(33, 35, 36, 0.16)` | Top-level modals, full-page overlays |

**Shadow Philosophy:**

This design system maintains a predominantly flat aesthetic with minimal shadow use. Elevation is achieved primarily through contrast, layering, and spatial positioning rather than dramatic drop shadows. Subtle shadows (when applied) signal interactivity or modal states, reserving visual depth for functional purpose. The cool-toned neutral palette reduces shadow harshness; shadows are applied sparingly to preserve the minimalist atmosphere. For most interfaces, rely on border treatment (`1px solid #D0E5E5`) to signal clickable regions rather than shadows.

## 7. Do's and Don'ts

### Do

- **Use the color palette consistently:** Stick to the 10 defined colors; introduce new colors only with explicit design rationale.
- **Maintain generous whitespace:** Leave space around content blocks equal to or greater than the content itself; whitespace aids comprehension.
- **Prioritize typography for hierarchy:** Use size and weight changes (not color) to establish primary visual emphasis; color accents are secondary.
- **Apply Roc Grotesk Variable at defined sizes:** Never interpolate between hierarchy steps; use exact pixel values from the typography table.
- **Use `border-radius: 100px` for all interactive elements:** Buttons, nav pills, and soft affordances benefit from pill-shaped treatment.
- **Default to flat, borderless containers:** Reserve shadows for exceptional focus or modal states only.
- **Leverage the cool-toned neutral scale:** Use `#D0E5E5` and `#F2F6F7` for layering without introducing warmth.
- **Maintain 1:1 aspect ratio for circular media:** Images with `border-radius: 1200px` should be square crops.
- **Test contrast ratios for accessibility:** Primary text on all backgrounds must meet WCAG AA standards (minimum 4.5:1).
- **Use the Electric Blue (`#0000EE`) for all interactive affordances:** Links, primary buttons, and focus states remain visually consistent.

### Don't

- **Don't introduce new colors outside the palette:** Every color serves a semantic function; adding ad-hoc colors fragments the visual language.
- **Don't mix font families:** Roc Grotesk Variable is the sole typeface; system fonts are fallback only.
- **Don't use color alone to convey meaning:** Always pair color with additional context (icon, label, or positioning) for accessible communication.
- **Don't apply shadows by default:** Flat design is the foundation; only apply shadows for exceptional interactive or modal states.
- **Don't mix rounded and sharp corners on related components:** Maintain consistency within a feature area (e.g., all buttons in a section have identical radius).
- **Don't exceed 2–3 font weights in a single interface:** Stick to weight 400 and 600; avoid weight 700 or other intermediate values.
- **Don't center-align body copy blocks:** Left-align paragraphs for optimal readability; center-align only headings and accent elements.
- **Don't use more than 2 accent colors per page:** Electric Blue is primary; Neon Lime is reserved for warnings only.
- **Don't reduce padding below `12px` in interactive components:** Minimum touch targets and clickable areas require `44px` height and adequate padding.
- **Don't apply harsh drop shadows on text:** Text remains flat; shadows apply only to container backgrounds in exceptional cases.

## 8. Responsive Behavior

### Breakpoints

| Name | Width | Key Changes |
|------|-------|-------------|
| Mobile | 320px–767px | Single column, 16px padding, 24px section margins, full-width hero, hidden desktop nav |
| Tablet | 768px–1023px | 2–3 column layouts, 28px padding, 32px section margins, toggle navigation |
| Desktop | 1024px–1920px | Multi-column layouts, 40px padding, 48px section margins, full horizontal nav |
| Wide | 1920px+ | Content width capped at 1280px with symmetric margins, enhanced spacing |

### Touch Targets

- **Minimum Height:** `44px` for all interactive elements (buttons, links, form inputs)
- **Minimum Width:** `44px` for icon buttons and small affordances
- **Padding:** `12px–24px` around clickable regions to meet touch-friendly spacing (48px total minimum)
- **Spacing Between Elements:** `16px` minimum gap between adjacent interactive elements to prevent accidental activation

### Collapsing Strategy

**Typography Scaling:**
- Display size: `230px` (desktop) → `48px` (mobile)
- Heading 1 / H2: `30px` (desktop) → `24px` (tablet) → `20px` (mobile)
- Body Large (navigation): `24px` (desktop) → `18px` (tablet) → `16px` (mobile)
- Body Regular: `16px` (desktop) → `16px` (all sizes, no reduction)

**Layout Collapsing:**
- Hero section: Full-width container (desktop) → Stacked text + image (tablet) → Single column (mobile)
- Navigation: Horizontal pill buttons (desktop) → Horizontal scroll or dropdown (tablet) → Hamburger menu (mobile)
- Multi-column sections: Collapse to single column below 768px; image-text blocks stack vertically
- Grid gaps: Reduce from `44px` (desktop) to `32px` (tablet) to `16px` (mobile)

**Container Adjustments:**
- Remove max-width constraint on mobile; allow full bleed for hero media
- Reduce padding from `40px` (desktop) to `28px` (tablet) to `16px` (mobile)
- Stack card layouts vertically; avoid side-by-side cards on mobile
- Full-width buttons on mobile; maintain fixed width only on desktop (150px minimum)

**Image Optimization:**
- Circular images maintain aspect ratio at all sizes
- Hero images scale down but maintain focal point (centered composition)
- Reduce animation duration on mobile for performance (remove parallax effects below 768px)

## 9. Agent Prompt Guide

### Quick Color Reference

- **Primary CTA:** Electric Blue (`#0000EE`)
- **Primary Surface Background:** White (`#FFFFFF`)
- **Primary Text:** Graphite (`#212324`)
- **Secondary Text:** Stone (`#A0A2A3`)
- **Interactive Hover:** Sky Mist (`#D0E5E5`)
- **Light Background:** Soft Cloud (`#F2F6F7`)
- **Borders & Dividers:** Silver (`#B7BBBD`)
- **Alert / Warning:** Neon Lime (`#D3FF35`)
- **Darkest Text:** Charcoal Deep (`#18191A`)
- **Tertiary Text:** Pebble (`#96A6A6`)

### Iteration Guide

1. **Typography First:** All hierarchy changes begin with the size and weight table; never interpolate between defined sizes. Use exact pixel values from section 3.

2. **Color Semantics:** Every color application maps to one of the 10 palette colors. If a need arises for a new color, revise the entire palette rather than introducing isolated hex values.

3. **Spacing Consistency:** All margins, padding, and gaps use the spacing scale defined in section 5. Never apply arbitrary px values; snap to `4px`, `8px`, `12px`, `16px`, `20px`, `24px`, `28px`, `32px`, `36px`, `40px`, `44px`, or `48px`.

4. **Border Radius Uniformity:** Apply only `0px` (sharp), `100px` (pill), or `1200px` (circular). No intermediate radius values exist in this system.

5. **Interactive Affordance:** Primary buttons always have background `#FFFFFF`, border `1px solid #D0E5E5`, border-radius `100px`, and text color `#0000EE`. Secondary links are text-only with no background.

6. **Elevation Restraint:** Default all containers to flat (no shadow). Apply shadows from the elevation table only for modals, floating UI, or explicit focus states.

7. **Whitespace as Content:** Preserve generous margins between sections (32px–48px). Do not compress spacing to fit more content; redesign content hierarchy instead.

8. **Mobile-First Scaling:** Start with mobile typography and spacing, then apply breakpoint increases at 768px and 1024px. Never reduce base sizes below tablet; maintain minimum 16px body copy at all sizes.

9. **Single Font Family:** Roc Grotesk Variable covers all use cases. Do not introduce alternative fonts; rely on weight (400 or 600) and size variation exclusively.

10. **Accessibility Baseline:** Maintain 4.5:1 contrast ratio minimum for body text. Test all text-on-background combinations before implementation; prioritize readability over aesthetic refinement.