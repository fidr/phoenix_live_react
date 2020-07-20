# PhoenixLiveReact

Render React.js components in Phoenix LiveView views.

## Installation

Add to your `mix.exs` and run `mix deps.get`:

```elixir
def deps do
  [
    {:phoenix_live_react, "~> 0.3"}
  ]
end
```

Then add to your `assets/package.json` and run `npm i` or `yarn`:

```
{
  ...
  "dependencies": {
    ...
    "phoenix": "file:../deps/phoenix",
    "phoenix_html": "file:../deps/phoenix_html",
    "phoenix_live_view": "file:../deps/phoenix_live_view",
    "phoenix_live_react": "file:../deps/phoenix_live_react", # <-- ADD THIS!
    ...
  },
  ...
}
```

Note for umbrella projects the relative file paths should look like `"file:../../../deps/phoenix_live_react"`

Connect the hooks to your liveview (`app.js`):

```javascript
import LiveReact, { initLiveReact } from "phoenix_live_react"

let hooks = { LiveReact }

let liveSocket = new LiveSocket("/live", Socket, { hooks, params: { _csrf_token: csrfToken } })

// Optionally render the React components on page load as
// well to speed up the initial time to render.
// The pushEvent, pushEventTo and handleEvent props will not be passed here.
document.addEventListener("DOMContentLoaded", e => {
  initLiveReact()
})
```

## Usage

Add your react components to the window scope (`app.js`):

```javascript
import { MyComponent } from "./components/my_components"

window.Components = {
  MyComponent
}
```

Use in your live view:

```elixir
import PhoenixLiveReact

def render(assigns) do
  ~L"""
  <%= live_react_component("Components.MyComponent", [name: @name], id: "my-component-1") %>
  """
end
```

Instead of importing it in each view, you can also add it to your web module:

```elixir
defp view_helpers do
  quote do
    # ...
    import PhoenixLiveReact
    # ...
  end
end
```

### Events

To push events back to the liveview the `pushEvent`, `pushEventTo` and `handleEvent` functions from
Phoenix LiveView are passed as props to the component.

* pushEvent(event, payload) - push an event from the client to the LiveView
* pushEventTo(selector, event, payload) - push an event from the client to a specific LiveView component
* handleEvent(event, handler) - (phoenix_live_view >= 0.14) receive data directly through liveview `push_event`

```javascript
const { pushEvent, pushEventTo, handleEvent } = this.props;

pushEvent("button_click");
pushEvent("myevent", {"var": "value"});
pushEventTo("#component-1", "do_something")

handleEvent("some-event", (payload) => console.log(payload))
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
