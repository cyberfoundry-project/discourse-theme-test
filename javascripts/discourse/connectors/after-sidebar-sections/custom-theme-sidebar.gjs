import icon from "discourse/helpers/d-icon";
import themeSetting from "discourse/helpers/theme-setting";

export default <template>
  {{#if (themeSetting "show_sidebar_card")}}
    <section
      class="custom-sidebar-card"
      aria-labelledby="custom-sidebar-card-title"
    >
      <div class="custom-sidebar-card__icon" aria-hidden="true">
        {{icon (themeSetting "sidebar_card_icon")}}
      </div>
      <div class="custom-sidebar-card__content">
        <h2
          class="custom-sidebar-card__title"
          id="custom-sidebar-card-title"
        >
          {{themeSetting "sidebar_card_title"}}
        </h2>
        <p class="custom-sidebar-card__text">
          {{themeSetting "sidebar_card_text"}}
        </p>
        <a
          class="custom-theme-button custom-theme-button--sidebar"
          href={{themeSetting "sidebar_card_url"}}
        >
          {{themeSetting "sidebar_card_cta"}}
        </a>
      </div>
    </section>
  {{/if}}
</template>;
