import { apiInitializer } from "discourse/lib/api";
import { iconHTML } from "discourse-common/lib/icon-library";

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
      /* never let icon decoration break navigation */
    }
  });
}

function decorateUserToggle(currentUser) {
  if (!currentUser) {
    return;
  }
  const toggle = document.querySelector("#toggle-current-user");
  if (!toggle || toggle.querySelector(".cyberfoundry-username")) {
    return;
  }
  try {
    const span = document.createElement("span");
    span.className = "cyberfoundry-username";
    span.textContent = currentUser.username;
    toggle.appendChild(span);
  } catch (e) {
    /* defensive */
  }
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
    decorateUserToggle(currentUser);

    const footer = document.querySelector(".custom-theme-footer");
    if (footer) {
      footer.toggleAttribute(
        "hidden",
        Boolean(document.querySelector(".custom-footer"))
      );
    }
  });
});
