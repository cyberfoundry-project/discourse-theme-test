import themeSetting from "discourse/helpers/theme-setting";

export default <template>
  {{#if (themeSetting "show_custom_footer")}}
    <footer class="custom-theme-footer" aria-label="Community footer">
      <div class="custom-theme-footer__inner">
        <div>
          <strong class="custom-theme-footer__brand">
            {{themeSetting "brand_name"}}
          </strong>
          <p class="custom-theme-footer__tagline">
            {{themeSetting "footer_tagline"}}
          </p>
        </div>

        <nav class="custom-theme-footer__links" aria-label="Footer links">
          <a href="/about">About</a>
          <a href="/guidelines">Guidelines</a>
          <a href="/tos">Terms</a>
          <a href="/privacy">Privacy</a>
        </nav>
      </div>
    </footer>
  {{/if}}
</template>;
