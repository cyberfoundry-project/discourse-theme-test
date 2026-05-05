# CyberFoundry Discourse Theme

CyberFoundry is a custom Discourse forum theme for a project community hub. It
uses a clean, modern interface language inspired by Next.js, shadcn/ui, and
community.vercel.com: white card surfaces, quiet borders, consistent radius
tokens, accessible focus rings, Geist headings, and Inter body copy.

## What is included

- `about.json` theme metadata for remote Git installation.
- `settings.yml` for editable copy, links, colors, and sidebar/footer content.
- `common/head_tag.html` for loading Geist and Inter from Google Fonts.
- Shared, desktop, and mobile light-mode SCSS in the Discourse theme file
  layout, with shared styles split into Horizon-style `scss/*.scss` modules.
- Shadcn-inspired design tokens for surfaces, buttons, inputs, cards, focus
  rings, topic lists, posts, composer, user profiles, and voting interfaces.
- Plugin outlet connector templates for:
  - `before-main-outlet` homepage hero and quick links
  - `after-sidebar-sections` promotional card
- A `common/footer.html` footer hook.
- A lightweight API initializer that hides homepage-only content away from
  non-homepage routes.
- Theme metadata for the bundled light color scheme, preview screenshot, and
  Discourse search-field default.
- TypeScript project metadata matching modern Discourse theme tooling.

## Install in Discourse

1. In Discourse, go to **Admin > Customize > Themes**.
2. Select **Install**.
3. Choose **From a git repository**.
4. Enter this repository URL.
5. Install the theme, then mark it as selectable or set it as the default theme.

Discourse checks remote themes for updates automatically. You can also use the
theme admin page's **Check for Updates** action after pushing changes.

## Customize

Most visible copy and URLs are controlled from **Admin > Customize > Themes >
CyberFoundry > Settings**:

- Brand name
- Hero eyebrow, title, subtitle, and call-to-action links
- Three quick-link cards
- Accent colors
- Optional top notice
- Sidebar card copy and URL
- Footer tagline

For deeper visual changes, edit:

- `common/common.scss` for shared layout and components
- `desktop/desktop.scss` for larger-screen refinements
- `mobile/mobile.scss` for narrow-screen refinements

## Preview

A static approximation of the current theme direction is available at
`preview/index.html`. Open it in a browser to review the light layout,
typography, sidebar, announcement bar, intro card, category cards, topic/post
surfaces, voting controls, composer, and profile cards without a running
Discourse instance.

## Component compatibility

The theme keeps custom selectors namespaced with `custom-theme-*` and avoids
styling component-owned classes directly. It has been reviewed for compatibility
with these Discourse components:

- DiscoTOC
- discourse-category-banners
- Discourse-easy-footer
- discourse-sidebar-theme-toggle
- discourse-tag-banners
- discourse-custom-header-links

Compatibility behavior:

- Homepage announcement, intro card, and quick links are hidden on category,
  tag, and topic routes so category/tag banners and DiscoTOC can own those
  layouts.
- The custom footer is controlled by `show_custom_footer`. Turn it off when
  using Discourse-easy-footer as the site footer.
- The sidebar card is controlled by `show_sidebar_card` and is inserted after
  sidebar sections, leaving the sidebar footer area available for
  discourse-sidebar-theme-toggle.
- Header styling is limited to core header surfaces, with only light spacing and
  hover polish for `.custom-header-links` links.

## Develop locally

For the fastest feedback loop, use Discourse's theme CLI with a running Discourse
development instance:

```sh
gem install discourse_theme
discourse_theme watch .
```

Alternatively, push changes to the Git branch connected to Discourse and update
the remote theme from the admin UI.