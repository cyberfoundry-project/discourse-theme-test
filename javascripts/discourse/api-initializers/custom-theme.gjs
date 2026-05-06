import { apiInitializer } from "discourse/lib/api";

// Tag the page with trust level + auth state so CSS can target experiences
// (e.g. show the new-user welcome banner only to anon + TL0). Hide our
// custom footer when Discourse Easy Footer is also present so the site
// doesn't end up with two stacked footers. Homepage gating itself lives
// in scss/home.scss via Discourse's built-in body classes.
export default apiInitializer("1.8.0", (api) => {
  const html = document.documentElement;
  html.classList.add("cyberfoundry-theme");

  const currentUser = api.getCurrentUser();
  if (!currentUser) {
    html.classList.add("cyberfoundry-anon");
  } else {
    html.classList.add(`cyberfoundry-tl-${currentUser.trust_level ?? 0}`);
  }

  // For brevity in CSS, mark TL0 + anon as "new-user".
  if (!currentUser || (currentUser.trust_level ?? 0) === 0) {
    html.classList.add("cyberfoundry-new-user");
  }

  api.onPageChange(() => {
    const footer = document.querySelector(".custom-theme-footer");
    if (footer) {
      footer.toggleAttribute(
        "hidden",
        Boolean(document.querySelector(".custom-footer"))
      );
    }
  });
});
