# CyberFoundry Discourse Theme

A custom Discourse theme (not a component). Light-mode, shadcn/Vercel-inspired surfaces, Geist headings + Inter body.

## File layout (Discourse-required)

- `about.json` — theme metadata + bundled color schemes. `component: false`.
- `settings.yml` — user-editable settings (read in templates via `{{theme-setting "key"}}`, in SCSS via `$key`).
- `common/`, `desktop/`, `mobile/` — SCSS entry points + HTML hooks (`head_tag.html`, `footer.html`, etc.).
- `scss/` — partials imported by `common/common.scss` (Horizon-style split).
- `javascripts/discourse/api-initializers/*.gjs` — runtime hooks. Use `apiInitializer("1.8.0", api => …)`.
- `javascripts/discourse/connectors/<outlet-name>/*.gjs` — plugin outlet templates. Folder name = outlet name. **Do not use `.hbs`** — Discourse deprecated it (deprecation id `discourse.hbs-extension`, see https://meta.discourse.org/t/398896). Use Glimmer JS template syntax: `import themeSetting from "discourse/helpers/theme-setting"; export default <template>…</template>;`
- `screenshots/` — referenced from `about.json`.
- `preview/index.html` — static preview, runnable without a Discourse instance.

## Conventions in this theme

- Custom selectors are namespaced `custom-theme-*` / `custom-sidebar-*` / `custom-quick-*`. Don't restyle Discourse's own classes directly except for documented surfaces (`.d-header`, `.topic-list`, `.fancy-title`, etc.).
- Colors come from the bundled `CyberFoundry Light` scheme in `about.json`; component CSS uses Discourse vars (`--primary`, `--secondary`, `--tertiary`, `--primary-low`, etc.) wrapped in `--custom-theme-*` aliases in `scss/variables.scss`.
- Border radius / shadows / spacing are tokenized — extend tokens in `scss/variables.scss` rather than hardcoding.
- Fonts: Geist for headings, Inter for body. Loaded in `common/head_tag.html`.
- Homepage-only content (hero + quick-links) is rendered via the `before-main-outlet` connector and hidden on non-homepage routes by `api-initializers/custom-theme.gjs`.
- The custom footer (`common/footer.html`) self-hides if Discourse-easy-footer's `.custom-footer` is present.

## Component compatibility (don't break these)

DiscoTOC · discourse-category-banners · Discourse-easy-footer · discourse-sidebar-theme-toggle · discourse-tag-banners · discourse-custom-header-links

Banners/TOCs need their own real estate on category/tag/topic routes — keep the homepage hero hidden there.

## Local development

```sh
gem install discourse_theme
discourse_theme watch .
```

Or push to the connected Git branch and click **Check for Updates** in the theme admin UI.

Live preview URL pattern: `https://meta.cyberfoundry.tech/<route>?preview_theme_id=10`.

## Don'ts

- Don't add npm build steps — Discourse compiles SCSS / .gjs / .hbs itself. `package.json` is for `@discourse/types` only.
- Don't write TypeScript `.ts` files; theme JS is `.gjs` (Glimmer).
- Don't bump `apiInitializer` version unless using newer api-only methods — 1.8.0 is fine.
- Don't reference assets that aren't in the repo or the theme's uploaded assets.
