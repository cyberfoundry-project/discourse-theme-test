---
description: Push the current theme to the connected Git remote and remind me to refresh the theme in the Discourse admin UI
---

Sync the current theme to the live preview at meta.cyberfoundry.tech.

Steps:
1. Run `git status` to confirm there are uncommitted changes worth pushing.
2. If there are unstaged changes, ask whether to commit them first (do NOT auto-commit).
3. Run `git push` for the current branch.
4. Remind me of the two ways to see the change live:
   - **Admin UI**: open `https://meta.cyberfoundry.tech/admin/customize/themes`, find the CyberFoundry theme, click **Check for Updates**, then **Update to Latest**.
   - **Preview without merging**: open `https://meta.cyberfoundry.tech/<route>?preview_theme_id=10` in an incognito window — Discourse fetches the latest commit on the configured branch.
5. If `discourse_theme watch .` is what I'd rather use locally, point that out as a faster feedback loop and stop.
