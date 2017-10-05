const DOM_COMPONENT_PREVENTED = 'DOMComponentPrevented';

const DOMComponent = (function() {
  let __components = {};

  function initComponent(name, $el, props = {}) {
    if (!__components[name]) throw new Error(`Unknown component ${name}`);

    $el.attr('data-component-inited', true);

    __components[name]($el, props);
  }

  function live() {
    $(document).find('[data-component]:not([data-component-inited])').each((i, el) => {
      const $el   = $(el);
      const props = $el.data('props');

      $el.data('component').split(' ').forEach((name) => {
        initComponent(name, $el, props);
      });
    });
  }

  function register(name, func) {
    __components[name] = func;
  }

  return { register, live }
})();

export default DOMComponent;
export { DOM_COMPONENT_PREVENTED };