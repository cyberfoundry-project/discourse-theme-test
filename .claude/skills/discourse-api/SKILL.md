---
name: discourse-api
description: Use when calling the Discourse REST API against a live instance — listing topics/posts/users/categories, creating/updating content, managing tags/badges/site-settings, or admin actions. Triggers on "Discourse API", "API key", "Api-Username", curl/HTTP calls to a Discourse host. Canonical reference is https://docs.discourse.org/.
---

# Discourse REST API

Canonical reference: **https://docs.discourse.org/** (interactive Swagger).
OpenAPI schema: **https://docs.discourse.org/openapi.json**.
Most endpoints accept and return JSON; append `.json` to the path when in doubt.

## Authentication

Two header pair, both required for API key auth:

```
Api-Key: <admin-or-user-api-key>
Api-Username: <username-the-call-acts-as>     # use `system` for automated tasks
```

- API keys are created at `/admin/api/keys`. Scope them by route when possible.
- For per-user keys (mobile-app style), use User API Keys (`/user-api-key/new`) with a registered RSA pubkey.
- CSRF: not required for `Api-Key` header auth. It IS required for session-cookie auth.

Never put keys in URLs, repo files, or screenshots. Use `.env` + the user's secret manager.

## Base URL for this project

`https://meta.cyberfoundry.tech` — when scripting, set it as `DISCOURSE_BASE` so calls are portable.

## Endpoint groups (top level)

The API is wide. The groups Claude is most likely to touch:

| Group | Examples |
|---|---|
| **Topics** | `GET /t/{id}.json`, `POST /t/{id}/invite`, `PUT /t/{slug}/{id}.json`, `DELETE /t/{id}.json` |
| **Posts** | `POST /posts.json` (create topic or reply), `GET /posts/{id}.json`, `PUT /posts/{id}.json`, `DELETE /posts/{id}.json` |
| **Categories** | `GET /categories.json`, `POST /categories.json`, `PUT /categories/{id}.json`, `GET /c/{slug}/{id}.json` |
| **Tags** | `GET /tags.json`, `GET /tag/{tag}.json`, `POST /tags/upload.json` |
| **Users** | `GET /users/{username}.json`, `PUT /users/{username}.json`, `POST /users.json`, `GET /admin/users/list/{flag}.json` |
| **Search** | `GET /search.json?q=…`, `GET /search/query.json?term=…&type_filter=…` |
| **Site settings** | `GET /admin/site_settings.json`, `PUT /admin/site_settings/{name}.json` |
| **Themes** | `GET /admin/themes.json`, `POST /admin/themes/import.json`, `PUT /admin/themes/{id}.json` |
| **Notifications** | `GET /notifications.json`, `PUT /notifications/mark-read.json` |
| **Badges** | `GET /admin/badges.json`, `POST /admin/badges.json` |
| **Backups** | `GET /admin/backups.json`, `POST /admin/backups.json` |
| **Groups** | `GET /groups.json`, `POST /groups.json`, `PUT /groups/{id}.json` |
| **Uploads** | `POST /uploads.json` (multipart) |
| **Webhooks** | `GET /admin/api/web_hooks.json`, `POST /admin/api/web_hooks.json` |

When in doubt, open `https://docs.discourse.org/#tag/<Group>` — every group has an anchor.

## Calling patterns

### Create a topic
```sh
curl -sS -X POST "$DISCOURSE_BASE/posts.json" \
  -H "Api-Key: $DISCOURSE_API_KEY" \
  -H "Api-Username: system" \
  -H "Content-Type: application/json" \
  -d '{"title":"Release 1.2","raw":"…","category":4,"tags":["release"]}'
```

### List latest topics in a category
```sh
curl -sS "$DISCOURSE_BASE/c/announcements/5.json" \
  -H "Api-Key: $DISCOURSE_API_KEY" \
  -H "Api-Username: system"
```

### Update a site setting
```sh
curl -sS -X PUT "$DISCOURSE_BASE/admin/site_settings/title.json" \
  -H "Api-Key: $DISCOURSE_API_KEY" \
  -H "Api-Username: system" \
  -d 'title=CyberFoundry'
```

### Search
```sh
curl -sS "$DISCOURSE_BASE/search.json?q=docker+%23security"
```

## Pagination

- Topic lists: `?page=N` (zero-indexed) on `/latest.json`, `/categories/{slug}/{id}.json`, etc.
- Post streams: each `/t/{id}.json` returns `post_stream.stream` (full ID list); fetch chunks with `/t/{id}/posts.json?post_ids[]=…`.
- User lists (admin): `?page=N&show_emails=true`.

## Rate limits

- Default admin API: 60 req/min per key, 600/hour. Configurable via site settings (`max_admin_api_reqs_per_minute`).
- 429 responses include `Retry-After`. Always read it; don't fixed-sleep.
- Bulk imports: prefer the Discourse import scripts in `script/import_scripts/` rather than pounding the REST API.

## Webhooks (when receiving from Discourse)

- Configured at `/admin/api/web_hooks`.
- Verify the `X-Discourse-Event-Signature` header: HMAC-SHA256 of the raw body using the webhook secret. Compare with `crypto.timingSafeEqual`.
- Header `X-Discourse-Event-Type` tells you the event family (`post`, `topic`, `user`, …); `X-Discourse-Event` is the specific event (`post_created`, …).

## What this skill is NOT for

- **Theme code** (SCSS, `.gjs`, `.hbs` connectors, `settings.yml`, `about.json`) — that's the `discourse-theme-dev` skill. The REST API is for talking to a running Discourse instance, not for shipping a theme.
- **Plugin development** — plugins ship Ruby + JS into core; that's a different surface.
