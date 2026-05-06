---
description: Open the static preview/index.html in a browser to spot-check theme changes
---

Open `preview/index.html` so I can review the current visual direction without a running Discourse instance.

Steps:
1. Confirm `preview/index.html` exists.
2. Open it via `start preview/index.html` (Windows) so it loads in the default browser.
3. Remind me that the preview is a static approximation — it doesn't run Discourse JS, so plugin outlets and api-initializer behavior won't be exercised. For real validation, use `discourse_theme watch .` against a dev instance, or push and reload `meta.cyberfoundry.tech?preview_theme_id=10`.
