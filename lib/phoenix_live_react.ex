defmodule PhoenixLiveReact do
  @moduledoc """
  Render React.js components in Phoenix LiveView views.
  """

  import Phoenix.HTML
  import Phoenix.HTML.Tag

  @doc """
  Render a react component in a live view.

  ```
  <%= PhoenixLiveReact.live_react_component("Components.MyComponent", %{name: "Bob"}, id: "my-component-1") %>
  ```

  ## Events

  To push events back to the liveview the `pushEvent` and `pushEventTo` functions from
  Phoenix LiveView are passed as props to the component.

  * pushEvent(event, payload) - push an event from the client to the LiveView
  * pushEventTo(selector, event, payload) - push an event from the client to a specific LiveView component
  * handleEvent(event, handler) - (phoenix_live_view >= 0.14) receive data directly through liveview `push_event`

  ```
  const { pushEvent, pushEventTo, handleEvent } = this.props;
  pushEvent("button_click");
  pushEvent("myevent", {"var": "value"});
  pushEventTo("#component-1", "do_something")

  handleEvent("some-event", (payload) => console.log(payload))
  ```

  ## Parameters

    - name: String with the module name of the component
    - props: Map or keyword list with the props for the react component
    - options: Keyword list with render options

  It is possible to override both the receiver and the container div's attributes by passing
  a keyword list as `:container` and `:receiver` options.

  You can also override the tag type with the `:container_tag` and `:receiver_tag` options

  By default, LiveView uses `phx-` as the binding prefix.  You can override this with the
  `:binding_prefix` option.

  ```
  <%=
    PhoenixLiveReact.live_react_component("Components.MyComponent", %{},
      id: "my-component-1",
      container: [class: "my-component"],
      container_tag: :p
    )
   %>
  ```
  """
  def live_react_component(name, props \\ %{}, options \\ [])

  def live_react_component(name, props_list, options) when is_list(props_list) do
    live_react_component(name, Map.new(props_list), options)
  end

  def live_react_component(name, props, options) do
    html_escape([
      receiver_element(name, props, options),
      container_element(options)
    ])
  end

  defp receiver_element(name, props, options) do
    attr = Keyword.get(options, :receiver, [])
    tag = Keyword.get(options, :receiver_tag, :div)
    binding_prefix = Keyword.get(options, :binding_prefix, "phx-")

    default_attr = [
      style: "display: none;",
      id: Keyword.get(options, :id),
      data: [
        live_react_class: name,
        live_react_props: Jason.encode!(props),
        live_react_merge: options[:merge_props] == true
      ],
      "#{binding_prefix}hook": "LiveReact"
    ]

    content_tag(tag, "", Keyword.merge(default_attr, attr))
  end

  defp container_element(options) do
    attr = Keyword.get(options, :container, [])
    tag = Keyword.get(options, :container_tag, :div)
    id = Keyword.get(options, :id)
    binding_prefix = Keyword.get(options, :binding_prefix, "phx-")

    default_attr = ["#{binding_prefix}update": "ignore", id: id]

    content_tag(tag, "", Keyword.merge(default_attr, attr))
  end
end
