# Data Model: Keeply Mobile Storage App

## Overview

The app uses API DTOs that mirror backend JSON exactly and domain entities that
are easier for UI/state code to consume. Repositories map DTOs to entities and
map API exceptions into `Failure` values.

## API Error and Failure

### ApiErrorDto

- `code`: string error code from backend.
- `message`: human-readable backend message.
- `details`: optional object with additional backend details.

### ApiException

- `statusCode`: HTTP status code when available.
- `error`: `ApiErrorDto`.
- `requestPath`: optional path for diagnostics.

### Failure

- `message`: user-facing message.
- `code`: optional backend error code for diagnostics/support.
- `isAuthenticationFailure`: true when the session must be cleared.

Validation rules:

- Token-related failures include `AUTHENTICATION_REQUIRED`, `INVALID_TOKEN`,
  `TOKEN_EXPIRED`, and `SESSION_REVOKED`.
- Non-empty Space delete failures map to: "Move or delete the contents first."
- Non-empty Container delete failures map to: "Move or delete the contents first."

## Auth Models

### AuthUserDto / AuthUser

- `id`: unique user id.
- `email`: user email address.
- `name`: display name.
- `profileImageUrl`: optional profile image URL.

Validation rules:

- `email`, `name`, and password inputs are required for registration.
- `email` and password inputs are required for login.
- Empty optional image URLs are treated as absent by the UI.

### AuthTokenResponseDto / AuthSession

- `accessToken`: short-lived Bearer token.
- `refreshToken`: rotated refresh token.
- `tokenType`: expected to be `Bearer`.
- `expiresIn`: access token lifetime in seconds.
- `user`: authenticated user.

State transitions:

- No stored tokens -> unauthenticated.
- Login/register success -> authenticated.
- Refresh success -> authenticated with replaced tokens.
- Refresh failure/logout -> unauthenticated.

## Storage Models

### NodeType

- `space`
- `container`
- `item`

API values are `SPACE`, `CONTAINER`, and `ITEM`; domain values use Dart enum
names.

### NodeImageDto / NodeImage

- `id`: backend image id when returned.
- `url`: image URL.
- `altText`: optional accessible description.
- `sortOrder`: display order.
- `createdAt`: creation timestamp when returned.

Validation rules:

- Image input for create/update includes `url`, optional `altText`, and
  `sortOrder`.
- Missing image arrays become empty lists.

### NodeDto / StorageNode

- `id`: node id.
- `type`: Space, Container, or Item.
- `name`: display name.
- `parentId`: null for top-level Spaces; otherwise parent Space or Container.
- `spaceId`: owning Space id.
- `images`: ordered image metadata.
- `metadata`: arbitrary backend-provided object.
- `createdAt`: creation timestamp.
- `updatedAt`: update timestamp.

Relationships:

- Space is top-level.
- Container belongs to a Space or another Container.
- Item belongs to a Space or Container.
- Item never has children.

Validation rules:

- Names are required for create/update.
- Space and Container delete operations are valid only when empty.
- Item delete operations do not require emptiness checks.

### TreeNodeDto / StorageTreeNode

Includes all `NodeDto` fields plus:

- `children`: list of child `TreeNodeDto`.

Relationships:

- Space trees contain nested Containers and Items.
- Container trees contain nested Containers and Items.
- Item nodes have no children.

Validation rules:

- Missing children arrays become empty lists.
- UI renders with lazy list/tree widgets for large hierarchies.

### PathSegmentDto / PathSegment

- `id`: segment node id.
- `type`: Space, Container, or Item.
- `name`: segment display name.
- `images`: optional segment images.

### ItemPathDto / ItemPath

- `itemId`: id of the item whose path was requested.
- `path`: ordered list from Space to Item.

Validation rules:

- Last segment should be the Item.
- Breadcrumb taps navigate by segment type.

## Subscription Models

### SubscriptionEntitlementDto / SubscriptionEntitlement

- `entitlementKey`: entitlement key such as `pro`.
- `status`: `ACTIVE`, `INACTIVE`, `EXPIRED`, `REVOKED`, or `UNKNOWN`.
- `provider`: provider name, currently `REVENUECAT`.
- `externalProductId`: optional product id.
- `currentPeriodEndsAt`: optional period end timestamp.
- `lastEventAt`: optional last event timestamp.

### SubscriptionStatusDto / SubscriptionStatus

- `entitlements`: list of entitlements.

Derived UI state:

- Any entitlement with `ACTIVE` status -> active paid state.
- Empty entitlement list -> free/inactive state.
- Non-active entitlements -> inactive state with latest known status.

## Screen State Objects

### AuthState

- `unknown`: app is checking stored session.
- `unauthenticated`: user must sign in.
- `authenticated`: user and valid session are available.
- `failure`: auth check failed and user-facing message is available.

### Form Cubit State

- `initial`
- `submitting`
- `success`
- `error`

Fields:

- form values.
- validation messages.
- submission failure message.

### Resource Cubit State

- `initial`
- `loading`
- `loaded`
- `empty`
- `error`
- `submitting`
- `success`

Fields:

- current entity or entity list.
- selected node id where applicable.
- disabled destination ids for move picker.
- user-facing message.

## Move Destination Rules

- Items are never valid destination parents.
- Item moves allow Space and Container destinations.
- Container moves allow Space and Container destinations except:
  - the moving Container itself.
  - any descendant of the moving Container.
- API move rejection messages are shown directly when friendly enough; unknown
  errors fall back to a generic move failure message.

## Lifecycle Ownership

- Text editing controllers are owned and disposed by form pages/widgets.
- Cubits/Blocs own async subscriptions and close them in `close()`.
- Dio cancellation tokens are scoped to requests or Cubit operations when used.
- Animation controllers, focus nodes, timers, and listeners are owned by the
  widget or Cubit that creates them and must be disposed or canceled.
