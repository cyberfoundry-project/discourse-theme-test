import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("1.8.0", (api) => {
  api.onPageChange(() => {
    const homepageContent = document.querySelector(".custom-theme-home");

    if (homepageContent) {
      homepageContent.toggleAttribute(
        "hidden",
        !["/", "/latest", "/categories"].includes(window.location.pathname)
      );
    }

    const footer = document.querySelector(".custom-theme-footer");

    if (footer) {
      footer.toggleAttribute("hidden", Boolean(document.querySelector(".custom-footer")));
    }
  });
});
