// `settings` is auto-injected in theme .gjs connectors — do not import a
// theme-setting helper. See https://meta.discourse.org/t/398896.

export default <template>
  <div class="custom-theme-home" data-custom-theme-home>
    {{#if settings.announcement_text}}
      <div
        class="custom-theme-announcement custom-theme-announcement--new-user"
        role="status"
        data-audience="new-user"
      >
        <span class="custom-theme-announcement__dot" aria-hidden="true"></span>
        <span class="custom-theme-announcement__text">
          {{settings.announcement_text}}
        </span>
        {{#if settings.announcement_cta_text}}
          <a
            class="custom-theme-announcement__cta"
            href={{settings.announcement_cta_url}}
          >
            {{settings.announcement_cta_text}}
            <span aria-hidden="true">→</span>
          </a>
        {{/if}}
      </div>
    {{/if}}

    {{#if settings.show_homepage_hero}}
      <section
        class="custom-theme-banner"
        aria-labelledby="custom-theme-banner-title"
      >
        <div class="custom-theme-banner__content">
          <p class="custom-theme-banner__eyebrow">
            {{settings.hero_eyebrow}}
          </p>
          <h1
            class="custom-theme-banner__title"
            id="custom-theme-banner-title"
          >
            {{settings.hero_title}}
          </h1>
          <p class="custom-theme-banner__description">
            {{settings.hero_subtitle}}
          </p>
        </div>

        <div class="custom-theme-banner__actions">
          <a
            class="custom-theme-button custom-theme-button--primary"
            href={{settings.hero_cta_url}}
          >
            {{settings.hero_cta_text}}
          </a>
          <a
            class="custom-theme-button custom-theme-button--secondary"
            href={{settings.hero_secondary_cta_url}}
          >
            {{settings.hero_secondary_cta_text}}
          </a>
        </div>
      </section>
    {{/if}}

    {{#if settings.show_quick_links}}
      <nav class="custom-quick-links" aria-label="Featured forum links">
        <a class="custom-quick-link" href={{settings.quick_link_1_url}}>
          <span class="custom-quick-link__label">
            {{settings.quick_link_1_label}}
          </span>
          <span class="custom-quick-link__text">
            {{settings.quick_link_1_text}}
          </span>
        </a>
        <a class="custom-quick-link" href={{settings.quick_link_2_url}}>
          <span class="custom-quick-link__label">
            {{settings.quick_link_2_label}}
          </span>
          <span class="custom-quick-link__text">
            {{settings.quick_link_2_text}}
          </span>
        </a>
        <a class="custom-quick-link" href={{settings.quick_link_3_url}}>
          <span class="custom-quick-link__label">
            {{settings.quick_link_3_label}}
          </span>
          <span class="custom-quick-link__text">
            {{settings.quick_link_3_text}}
          </span>
        </a>
      </nav>
    {{/if}}
  </div>
</template>;
