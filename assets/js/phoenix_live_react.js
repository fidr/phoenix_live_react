import React from "react"
import ReactDOM from "react-dom"

const render = function(el, target, componentClass, additionalProps = {}) {
  const props = el.dataset.liveReactProps ? JSON.parse(el.dataset.liveReactProps) : {};
  const reactElement = React.createElement(componentClass, {...props, ...additionalProps});
  ReactDOM.render(reactElement, target);
}

const initLiveReactElement = function(el, additionalProps) {
  const target = el.nextElementSibling;
  const componentClass = eval(el.dataset.liveReactClass);
  render(el, target, componentClass, additionalProps);
  return {target: target, componentClass: componentClass};
}

const initLiveReact = function() {
  const elements = document.querySelectorAll('[data-live-react-class]')
  Array.prototype.forEach.call(elements, el => {
    initLiveReactElement(el)
  });
}

const LiveReact = {
  mounted() {
    const { el } = this;
    const pushEvent = this.pushEvent.bind(this);
    const pushEventTo = this.pushEventTo && this.pushEventTo.bind(this);
    const { target, componentClass } = initLiveReactElement(el, { pushEvent });
    render(el, target, componentClass, { pushEvent, pushEventTo });
    Object.assign(this, { target, componentClass });
  },

  updated() {
    const { el, target, componentClass } = this;
    const pushEvent = this.pushEvent.bind(this);
    const pushEventTo = this.pushEventTo && this.pushEventTo.bind(this);
    render(el, target, componentClass, { pushEvent, pushEventTo })
  },

  destroyed() {
    const { target } = this;
    ReactDOM.unmountComponentAtNode(target);
  }
}

export { LiveReact as default, initLiveReact, initLiveReactElement };
