# CyberFoundry Discourse Theme

CyberFoundry is a custom Discourse forum theme that starts from a clean,
light-mode community layout inspired by community.vercel.com. It favors white
surfaces, subtle borders, compact alert-style intro content, tidy quick-link
cards, restrained navigation/topic-list styling, Geist headings, and Inter body
copy.

## What is included

- `about.json` theme metadata for remote Git installation.
- `settings.yml` for editable copy, links, colors, and sidebar/footer content.
- `common/head_tag.html` for loading Geist and Inter from Google Fonts.
- Shared, desktop, and mobile light-mode SCSS in the Discourse theme file
  layout.
- Plugin outlet connector templates for:
  - `before-main-outlet` homepage hero and quick links
  - `after-sidebar-sections` promotional card
- A `common/footer.html` footer hook.
- A lightweight API initializer that hides homepage-only content away from
  non-homepage routes.

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
typography, sidebar, announcement bar, intro card, and category cards without a
running Discourse instance.

## Develop locally

For the fastest feedback loop, use Discourse's theme CLI with a running Discourse
development instance:

```sh
gem install discourse_theme
discourse_theme watch .
```

Alternatively, push changes to the Git branch connected to Discourse and update
the remote theme from the admin UI.