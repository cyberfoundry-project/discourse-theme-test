// `settings` is auto-injected in theme .gjs connectors.

export default <template>
  {{#if settings.show_custom_footer}}
    <footer class="custom-theme-footer" aria-label="Community footer">
      <div class="custom-theme-footer__inner">
        <div>
          <strong class="custom-theme-footer__brand">
            {{settings.brand_name}}
          </strong>
          <p class="custom-theme-footer__tagline">
            {{settings.footer_tagline}}
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
