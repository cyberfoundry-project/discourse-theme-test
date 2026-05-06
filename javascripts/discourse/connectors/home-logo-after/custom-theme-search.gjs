// Custom search field rendered to the right of the logo, replacing the
// Discourse welcome-banner search (we hide that one because it conflicts with
// the homepage hero). Submits to /search via plain GET — no JS required.
export default <template>
  <form
    class="custom-theme-search"
    action="/search"
    method="get"
    role="search"
  >
    <input
      type="search"
      name="q"
      class="custom-theme-search__input"
      placeholder="Search topics, tags, members…"
      aria-label="Search"
      autocomplete="off"
    />
  </form>
</template>;
