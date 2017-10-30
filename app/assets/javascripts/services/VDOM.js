import { Component, h, render } from 'preact';
// import 'preact/devtools';

function VDOMComponent(initComponent) {
  function preactComponent() {
    Component.apply(this, arguments);

    this.constructor.displayName = initComponent.name;

    Object
      .entries(initComponent({
        setState:    this.setState.bind(this),
        forceUpdate: this.forceUpdate.bind(this),
        getDOMNode:  () => this.base,
        getProps:    () => this.props,
        getState:    () => this.state
      }))
      .forEach(([key, value]) => {
        if (typeof value === 'function') this[key] = value;
      });
  }

  preactComponent.prototype = Object.create(Component.prototype);
  preactComponent.prototype.constructor = preactComponent;

  return preactComponent;
}

export { VDOMComponent, h, render };
