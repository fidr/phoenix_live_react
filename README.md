# PhoenixLiveReact

Render React.js components in Phoenix LiveView views.

## Installation

Add to your `mix.exs` and run `mix deps.get`:

```elixir
def deps do
  [
    {:phoenix_live_react, "~> 0.2.0"}
  ]
end
```

## Usage

Add your react components to the window scope (`app.js`):

```javascript
import { MyComponent } from "./components/my_components"

window.Components = {
  MyComponent
}
```

Connect the hooks to your liveview (`app.js`):

```javascript
import LiveReact, { initLiveReact } from "phoenix_live_react"

let hooks = { LiveReact }

let liveSocket = new LiveSocket("/live", Socket, { hooks })
liveSocket.connect()

// Optionally render the React components on page load as
// well to speed up the initial time to render.
// The pushEvent prop will not be passed here.
document.addEventListener("DOMContentLoaded", e => {
  initLiveReact()
})
```

Use in your live view:

```elixir
import PhoenixLiveReact, only: [live_react_component: 2]

def render(assigns) do
  ~L"""
  <%= live_react_component("Components.MyComponent", %{name: @name}) %>
  """
end
```

### Events

To push events back to the liveview the `pushEvent` function from Phoenix LiveView is passed as a prop
the the component.

* pushEvent(event, payload) - method to push an event from the client to the LiveView server

```javascript
const { pushEvent } = this.props;
pushEvent("button_click");
pushEvent("myevent", {"var": "value"});
```

## How to add react to your phoenix app

In your assets dir:

```bash
npm install react react-dom --save
npm install @babel/preset-env @babel/preset-react --save-dev
```

Create an `assets/.babelrc` file:

```
{
  "presets": [
    "@babel/preset-env",
    "@babel/preset-react"
  ]
}
```

For NPM users, you might need the add the following to your `assets/webpack.config.js` file:
```
module.exports = (env, options) => ({
  // add:
  resolve: {
    alias: {
      react: path.resolve(__dirname, './node_modules/react'),
      'react-dom': path.resolve(__dirname, './node_modules/react-dom')
    }
  }
  //
});
```

## React phoenix

This library is inspired by [react-phoenix](https://github.com/geolessel/react-phoenix).

Check it out if you want to use react components in regular views.
