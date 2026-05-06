import { apiInitializer } from "discourse/lib/api";

// Body-class-based homepage gating is handled in scss/home.scss — see
// `.custom-theme-home` rules. We keep this initializer narrow: just hide our
// custom footer when Discourse Easy Footer is also installed so sites don't
// stack two footers, and add a brand body class for any per-route CSS hooks
// we want later.
export default apiInitializer("1.8.0", (api) => {
  document.documentElement.classList.add("cyberfoundry-theme");

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
