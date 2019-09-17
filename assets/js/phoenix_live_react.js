import React from "react"
import ReactDOM from "react-dom"

const render = function(el, target, componentClass, additionalProps) {
  const props = el.dataset.liveReactProps ? JSON.parse(el.dataset.liveReactProps) : {};
  const reactElement = React.createElement(componentClass, {...props, ...additionalProps});
  ReactDOM.render(reactElement, target);
}

export default {
  mounted() {
    const { el } = this;
    const target = el.nextElementSibling;
    const pushEvent = this.pushEvent.bind(this);
    const componentClass = eval(el.dataset.liveReactClass);
    render(el, target, componentClass, { pushEvent });
    Object.assign(this, { target, componentClass });
  },

  updated() {
    const { el, target, componentClass } = this;
    const pushEvent = this.pushEvent.bind(this);
    render(el, target, componentClass, { pushEvent })
  },

  destroyed() {
    const { target } = this;
    ReactDOM.unmountComponentAtNode(target);
  }
}
