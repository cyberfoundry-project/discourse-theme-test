---
name: discourse-theme-dev
description: Use when editing this Discourse theme — SCSS, .gjs api-initializers, .hbs plugin-outlet connectors, settings.yml, about.json, color schemes, and the theme upload/sync workflow. Triggers on "theme", "outlet", "connector", "api-initializer", "settings.yml", "color scheme", "discourse_theme" CLI.
---

# Discourse Theme Development

For the canonical Discourse theme dev guide, see https://meta.discourse.org/t/93648.
For the REST API (when scripting against the live site), see the `discourse-api` skill.

## File layout (Discourse-required, do not invent new top-level dirs)

```
about.json                                 metadata + bundled color_schemes
settings.yml                               admin-editable settings
common/                                    shared CSS + HTML hooks
  common.scss                              imports scss/* partials
  head_tag.html                            <head> injection (fonts, meta)
  header.html / footer.html / etc.         optional layout hooks
desktop/                                   desktop-only SCSS overrides
mobile/                                    mobile-only SCSS overrides
scss/                                      partials imported by common.scss
javascripts/discourse/
  api-initializers/*.gjs                   runtime hooks; one initializer per file
  connectors/<outlet-name>/*.gjs           plugin outlet templates; folder = outlet
  components/                              custom Glimmer components
screenshots/                               referenced from about.json
```

## settings.yml types

```yaml
brand_name:                 # string (default)
  default: "CyberFoundry"
  description: "..."
show_homepage_hero:         # boolean
  default: true
hero_position:              # enum
  default: "above"
  choices: ["above", "below"]
quick_links:                # list
  default: "a|b|c"
  type: list
  list_type: simple
hero_image:                 # upload (returns URL)
  type: upload
```

Read in templates: `{{theme-setting "brand_name"}}`.
Read in SCSS: `$brand_name` (interpolated at build) — quote when used in CSS values: `content: "#{$brand_name}";`.

## about.json essentials

- `component: false` for full themes, `true` for theme components.
- `color_schemes`: ship at least one. Keys are Discourse color names (`primary`, `secondary`, `tertiary`, `quaternary`, `header_background`, `header_primary`, `highlight`, `hover`, `selected`, `danger`, `success`, `love`).
- `theme_site_settings` lets a theme set safe site settings on install (e.g. `search_experience: "search_field"`).
- `screenshots`: paths to PNGs in repo.

## SCSS conventions in this theme

- All component CSS reads from `--custom-theme-*` aliases declared in `scss/variables.scss`. Those alias Discourse-provided vars (`--primary`, `--secondary`, `--tertiary`, `--primary-low`, `--primary-medium`, `--primary-very-low`, `--tertiary-very-low`, `--danger-low`, etc.). Add new tokens in `variables.scss`, not inline.
- Namespace selectors: `custom-theme-*`, `custom-sidebar-*`, `custom-quick-*`. Touching Discourse's own classes is allowed for known surfaces (`.d-header`, `.topic-list`, `.fancy-title`, `.sidebar-section`, etc.) but keep changes targeted.
- Import order in `common/common.scss`: variables → typography → surfaces → component partials. Plugin-compat last so it overrides our own rules when needed.

## api-initializers (.gjs)

```js
import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("1.8.0", (api) => {
  api.onPageChange((url) => { /* … */ });
  api.modifyClass("component:topic-list-item", { /* … */ });
  api.decorateCookedElement(($el, helper) => { /* … */ });
});
```

- Version `1.8.0` is fine for this theme. Only bump when using newer api-only methods; document the reason in the file.
- `onPageChange` runs for every Ember route transition — keep work cheap and idempotent.
- `document.querySelector` is fine in `onPageChange` callbacks but DOM may not yet be painted; use `requestAnimationFrame` if you need layout.

## Plugin outlets — `.gjs` only

Discourse exposes hundreds of `<PluginOutlet @name="…" />` slots. Folder name under `connectors/` MUST match the outlet name. There is no wildcard.

Connector files MUST use the `.gjs` extension. `.hbs` connectors are deprecated (deprecation id `discourse.hbs-extension`, see https://meta.discourse.org/t/398896) and emit a console warning per-load.

A connector that just renders markup with theme settings looks like:

```js
// `settings` is AUTO-INJECTED in theme .gjs connectors. Do NOT import a
// theme-setting helper — Discourse will throw "The theme-setting helper is
// not supported in this context" and the entire main-outlet stops rendering.
// Use `{{settings.key}}` directly.
import icon from "discourse/helpers/d-icon";

export default <template>
  {{#if settings.show_homepage_hero}}
    <section class="custom-theme-banner">
      <h1>{{settings.hero_title}}</h1>
      <a href={{settings.hero_cta_url}}>
        {{icon "arrow-right"}}
        {{settings.hero_cta_text}}
      </a>
    </section>
  {{/if}}
</template>;
```

If you need component state, args, or lifecycle, wrap in a class component:

```js
import Component from "@glimmer/component";

export default class extends Component {
  <template>
    <div>…uses {{@outletArgs.someArg}}…</div>
  </template>
}
```

How to find the right outlet:
1. Install the **Plugin Outlet Locations** theme component on a dev instance — it overlays outlet names on the rendered UI.
2. Or grep core: `rg '<PluginOutlet @name="' app/assets/javascripts` in a Discourse checkout.

Outlets used by this theme:

- `before-main-outlet` → wraps homepage hero + quick links (hidden on non-home routes by `custom-theme.gjs`).
- `after-sidebar-sections` → renders the sidebar promo card.

Common outlets worth knowing for future work:

| Outlet | Where it renders |
|---|---|
| `above-site-header` | top of every page, above `.d-header` |
| `home-logo-after` | inside header, after the logo |
| `discovery-list-controls-above` | above the topic-list controls (Latest/New/Top) |
| `topic-above-posts` | above the post stream on a topic |
| `topic-above-post-stream` | similar; below the topic title |
| `user-card-additional-controls` | user mini-card |
| `category-custom-banner` | category header |
| `composer-fields` | composer form |

## Color schemes & dark mode

A theme can ship multiple schemes in `about.json`. Discourse renders CSS for each scheme as a separate stylesheet; CSS uses Discourse vars (`--primary`, etc.) which resolve per scheme. Don't hardcode hex values in component CSS — use `--custom-theme-*` aliases that read from those vars.

## Local development

```sh
gem install discourse_theme
discourse_theme watch .         # auto-syncs file changes to a dev instance
discourse_theme upload .        # one-shot upload
```

For `meta.cyberfoundry.tech`, push to the connected branch and click **Check for Updates** in admin, OR preview unmerged work via `?preview_theme_id=10`.

## Common gotchas

- Editing `settings.yml` requires a manual refresh in the admin UI even with `discourse_theme watch`.
- Removing a setting that's referenced in a template will hard-fail the theme. Remove the template reference first.
- Connector folder name typos silently render nothing — verify the outlet exists.
- `apiInitializer` callbacks throw → the theme's JS bundle is dropped for that user. Wrap risky work in `try/catch`.
- Don't use TypeScript (`.ts`) — Discourse compiles `.gjs`/`.hbs`/`.scss` directly with no build step from this repo. `package.json` is for `@discourse/types` only.
