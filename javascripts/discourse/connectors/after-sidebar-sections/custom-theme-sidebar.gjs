// `settings` is auto-injected in theme .gjs connectors.
import icon from "discourse/helpers/d-icon";

export default <template>
  {{#if settings.show_sidebar_card}}
    <section
      class="custom-sidebar-card"
      aria-labelledby="custom-sidebar-card-title"
    >
      <div class="custom-sidebar-card__icon" aria-hidden="true">
        {{icon settings.sidebar_card_icon}}
      </div>
      <div class="custom-sidebar-card__content">
        <h2
          class="custom-sidebar-card__title"
          id="custom-sidebar-card-title"
        >
          {{settings.sidebar_card_title}}
        </h2>
        <p class="custom-sidebar-card__text">
          {{settings.sidebar_card_text}}
        </p>
        <a
          class="custom-theme-button custom-theme-button--sidebar"
          href={{settings.sidebar_card_url}}
        >
          {{settings.sidebar_card_cta}}
        </a>
      </div>
    </section>
  {{/if}}
</template>;
