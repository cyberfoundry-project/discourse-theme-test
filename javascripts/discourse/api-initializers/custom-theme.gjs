import { apiInitializer } from "discourse/lib/api";
import { iconHTML } from "discourse-common/lib/icon-library";

// Tag the page with trust level + auth state so CSS can target experiences
// (e.g. show the new-user welcome banner only to anon + TL0). Hide our
// custom footer when Discourse Easy Footer is also present so the site
// doesn't end up with two stacked footers. Inject Discourse SVG d-icons
// in front of each top-level nav-pill (Latest / New / Hot / Top / Categories
// / Unread) — we can't do this with CSS `content:` because Discourse uses
// SVG icons, not a FontAwesome webfont.
const NAV_PILL_ICONS = {
  "/latest": "clock",
  "/new": "star",
  "/unread": "envelope",
  "/top": "arrow-up",
  "/hot": "fire",
  "/categories": "layer-group",
};

function decorateNavPills() {
  const pills = document.querySelectorAll(".nav-pills > li > a");
  pills.forEach((a) => {
    if (a.querySelector(".cyberfoundry-tab-icon")) {
      return;
    }
    const href = a.getAttribute("href") || "";
    let iconName = null;
    for (const [path, name] of Object.entries(NAV_PILL_ICONS)) {
      if (href.endsWith(path) || href.includes(`${path}?`)) {
        iconName = name;
        break;
      }
    }
    if (!iconName) {
      return;
    }
    try {
      const span = document.createElement("span");
      span.className = "cyberfoundry-tab-icon";
      span.setAttribute("aria-hidden", "true");
      span.innerHTML = iconHTML(iconName);
      a.prepend(span);
    } catch (e) {
      // Defensive: never let icon decoration break navigation.
    }
  });
}

export default apiInitializer("1.8.0", (api) => {
  const html = document.documentElement;
  html.classList.add("cyberfoundry-theme");

  const currentUser = api.getCurrentUser();
  if (!currentUser) {
    html.classList.add("cyberfoundry-anon");
  } else {
    html.classList.add(`cyberfoundry-tl-${currentUser.trust_level ?? 0}`);
  }

  if (!currentUser || (currentUser.trust_level ?? 0) === 0) {
    html.classList.add("cyberfoundry-new-user");
  }

  api.onPageChange(() => {
    decorateNavPills();

    const footer = document.querySelector(".custom-theme-footer");
    if (footer) {
      footer.toggleAttribute(
        "hidden",
        Boolean(document.querySelector(".custom-footer"))
      );
    }
  });
});
