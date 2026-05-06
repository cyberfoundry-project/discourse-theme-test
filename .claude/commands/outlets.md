---
description: Reference list of common Discourse plugin outlets and how to discover more
---

Show me a quick reference of common Discourse plugin outlet names so I can pick the right one for a connector.

Pull the outlet table from `.claude/skills/discourse-theme-dev/SKILL.md` and present it. Then add these reminders:

1. The folder name under `javascripts/discourse/connectors/` MUST exactly match the outlet name. No wildcards.
2. To discover outlets that aren't in the reference table, install the **Plugin Outlet Locations** theme component on a dev instance — it overlays outlet names onto the rendered UI.
3. Or grep a Discourse checkout: `rg '<PluginOutlet @name="' app/assets/javascripts`.

If I name a specific area of the UI ("topic header", "homepage above topic list", "user card", etc.), suggest the most likely outlet from the table and flag confidence — don't guess silently.
