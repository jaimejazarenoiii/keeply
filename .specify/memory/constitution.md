<!--
Sync Impact Report
Version change: N/A -> 1.0.0
Modified principles:
- Template principle 1 -> I. Code Quality and Flutter Style
- Template principle 2 -> II. Testable Design
- Template principle 3 -> III. Testing Standards
- Template principle 4 -> IV. User Experience Consistency
- Template principle 5 -> V. Performance and Lifecycle Safety
Added sections:
- Flutter Engineering Standards
- Quality Gates
Removed sections: None
Templates requiring updates:
- .specify/templates/plan-template.md - updated
- .specify/templates/spec-template.md - updated
- .specify/templates/tasks-template.md - updated
Follow-up TODOs: None
-->
# Keeply Constitution

## Core Principles

### I. Code Quality and Flutter Style

All Dart and Flutter code MUST follow Google Dart style, Flutter framework
conventions, and project lint rules. Code MUST use two-space indentation and
MUST be formatted with `dart format` or the project formatter before review.
Lines or expressions that become hard to read MUST be split, extracted, or
renamed instead of being left as long chained statements. Widgets, services,
and models MUST have a single clear responsibility and names that explain
their role without requiring comments.

Rationale: Consistent style reduces review noise, makes Flutter widget trees
readable, and keeps future changes local.

### II. Testable Design

Every user-facing behavior MUST be designed as an independently testable unit
or journey before implementation starts. Business logic MUST be separated from
Flutter widget construction when practical, dependencies MUST be injectable or
replaceable in tests, and time, network, storage, and platform behavior MUST be
mockable. Requirements that cannot be verified by an automated or explicit
manual check MUST be clarified before planning proceeds.

Rationale: Testable architecture prevents fragile UI-only verification and
keeps feature slices safe to change.

### III. Testing Standards

Each feature MUST include automated tests appropriate to its risk: unit tests
for logic and state, widget tests for UI behavior, and integration tests for
cross-screen, persistence, platform, or backend flows. Tests MUST be written
or updated with the feature, MUST cover success, failure, and boundary states,
and MUST be runnable from documented project commands. A feature is incomplete
until the relevant test suite passes.

Rationale: Testing is a delivery requirement, not a polish task, because
Keeply must remain reliable as features accumulate.

### IV. User Experience Consistency

User interfaces MUST reuse shared design tokens, components, navigation
patterns, copy style, loading states, empty states, and error treatments.
New screens MUST support accessibility basics including semantic labels,
usable focus order, sufficient contrast, and system text scaling unless a
documented platform limitation prevents it. Feature specs MUST define the
primary user journey and measurable success criteria before UI work begins.

Rationale: A consistent experience makes the app easier to learn, test, and
maintain across screens.

### V. Performance and Lifecycle Safety

Features MUST define performance expectations for startup, rendering, network,
storage, and memory where relevant. Flutter code MUST avoid unnecessary
rebuilds, unbounded lists, expensive synchronous work on the UI isolate, and
uncontrolled image or stream usage. Any object with a lifecycle, including
controllers, subscriptions, timers, animations, focus nodes, and listeners,
MUST be disposed, canceled, or otherwise released by its owner. Code MUST NOT
retain stale `BuildContext` values across unsafe asynchronous gaps.

Rationale: Performance problems and memory leaks directly degrade trust and
are cheaper to prevent during creation than to diagnose after release.

## Flutter Engineering Standards

Flutter features MUST prefer simple composition over deep inheritance or broad
global state. State management choices MUST be justified in the implementation
plan and kept as local as the feature allows. Public APIs, persisted data, and
backend contracts MUST preserve compatibility unless a migration is explicitly
planned. Generated files MUST not be hand-edited. Secrets MUST remain outside
source control and outside committed configuration.

Long widget trees, conditionals, and asynchronous flows MUST be decomposed into
small widgets, helpers, or services when that improves readability or testing.
All code paths that allocate lifecycle-bound resources MUST document ownership
through structure, naming, or tests.

## Quality Gates

Plans MUST pass a constitution check before research and again after design.
The check MUST confirm:

- Flutter style, two-space formatting, and line readability are enforceable.
- Each user story has an independent verification path.
- Required unit, widget, and integration tests are identified.
- UX states and accessibility requirements are specified.
- Performance targets and memory leak risks are named with mitigations.

Code review MUST reject changes that skip required tests, leave lifecycle
resources unmanaged, introduce avoidable UI inconsistency, or add complexity
without a documented reason.

## Governance

This constitution supersedes informal project practices. Feature specs, plans,
tasks, and code reviews MUST comply with these principles. Any exception MUST
be recorded in the feature plan with the reason, expected risk, and follow-up
owner.

Amendments require a documented change to this file, a version bump following
semantic versioning, and updates to affected templates or guidance. MAJOR
versions redefine or remove principles, MINOR versions add or materially
expand principles or required sections, and PATCH versions clarify wording
without changing governance meaning.

Compliance is reviewed during planning, task generation, and code review.
Unresolved constitution violations block implementation unless the plan records
an approved exception.

**Version**: 1.0.0 | **Ratified**: 2026-06-02 | **Last Amended**: 2026-06-02
