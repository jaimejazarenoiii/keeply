# API Contract: Keeply Mobile Client

## Base URL

The app configures a base URL in `AppConfig`.

- Default local development: `http://localhost:3000`
- Android emulator note: use `http://10.0.2.2:3000` when host localhost is
  needed from the emulator.
- iOS simulator note: `http://localhost:3000` usually maps to the host machine.

## Response Envelope

Success responses:

```json
{
  "data": {}
}
```

Error responses:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}
```

No-content responses return HTTP 204 with no response body.

## Authentication Header

Protected requests include:

```text
Authorization: Bearer <accessToken>
```

The app refreshes once on token-related 401 responses and retries the original
request after a successful refresh.

## Auth Endpoints

### Register

`POST /auth/register`

Request fields:

- `email`: required.
- `password`: required.
- `name`: required.
- `profileImageUrl`: optional.

Response: `AuthTokenResponse`.

### Login

`POST /auth/login`

Request fields:

- `email`: required.
- `password`: required.

Response: `AuthTokenResponse`.

### Refresh

`POST /auth/refresh`

Request fields:

- `refreshToken`: required.

Response: `AuthTokenResponse`. The returned refresh token replaces the stored
refresh token.

### Logout

`POST /auth/logout`

Request fields:

- `refreshToken`: required when available.

Response: 204 No Content.

### Current User

`GET /auth/me`

Protected: yes.

Response: `AuthUser`.

## Spaces Endpoints

### List Spaces

`GET /spaces`

Protected: yes.

Response: list of `Node`.

### Create Space

`POST /spaces`

Protected: yes.

Request fields:

- `name`: required.
- `metadata`: optional object.
- `images`: optional list of image inputs.

Response: `Node`.

### Update Space

`PATCH /spaces/{spaceId}`

Protected: yes.

Request fields: at least one of `name`, `metadata`, or `images`.

Response: `Node`.

### Delete Empty Space

`DELETE /spaces/{spaceId}`

Protected: yes.

Response: 204 No Content.

Client behavior: if deletion fails because the Space is non-empty, show
"Move or delete the contents first."

### Get Space Tree

`GET /spaces/{spaceId}/tree`

Protected: yes.

Response: `TreeNode`.

## Containers Endpoints

### Create Container

`POST /containers`

Protected: yes.

Request fields:

- `name`: required.
- `parentId`: required Space or Container id.
- `metadata`: optional object.
- `images`: optional list of image inputs.

Response: `Node`.

### Update Container

`PATCH /containers/{containerId}`

Protected: yes.

Request fields: at least one of `name`, `metadata`, or `images`.

Response: `Node`.

### Delete Empty Container

`DELETE /containers/{containerId}`

Protected: yes.

Response: 204 No Content.

Client behavior: if deletion fails because the Container is non-empty, show
"Move or delete the contents first."

### Move Container

`PATCH /containers/{containerId}/move`

Protected: yes.

Request fields:

- `parentId`: required Space or Container id.

Response: `Node`.

Client validation:

- Disable Item destinations.
- Disable the moving Container.
- Disable descendants of the moving Container.
- Show API rejection messages for invalid moves.

### Get Container Tree

`GET /containers/{containerId}/tree`

Protected: yes.

Response: `TreeNode`.

### List Items Under Container Subtree

`GET /containers/{containerId}/items`

Protected: yes.

Response: list of `Node`.

## Items Endpoints

### Create Item

`POST /items`

Protected: yes.

Request fields:

- `name`: required.
- `parentId`: required Space or Container id.
- `metadata`: optional object.
- `images`: optional list of image inputs.

Response: `Node`.

### Get Item

`GET /items/{itemId}`

Protected: yes.

Response: `Node`.

### Update Item

`PATCH /items/{itemId}`

Protected: yes.

Request fields: at least one of `name`, `metadata`, or `images`.

Response: `Node`.

### Delete Item

`DELETE /items/{itemId}`

Protected: yes.

Response: 204 No Content.

### Move Item

`PATCH /items/{itemId}/move`

Protected: yes.

Request fields:

- `parentId`: required Space or Container id.

Response: `Node`.

Client validation:

- Disable Item destinations.

### Get Item Path

`GET /items/{itemId}/path`

Protected: yes.

Response: `ItemPath`.

Client behavior: render the ordered path as clickable breadcrumbs.

## Subscription Endpoint

### Get Subscription Status

`GET /subscription/status`

Protected: yes.

Response: `SubscriptionStatus`.

Client behavior: empty entitlements are displayed as free/inactive, not as an
error.
