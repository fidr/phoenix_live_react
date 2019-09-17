defmodule PhoenixLiveReact do
  import Phoenix.HTML
  import Phoenix.HTML.Tag

  @doc """
  Render a react component in a live view.

  ```
  <%= PhoenixLiveReact.live_react_component("Components.MyComponent", %{name: "Bob"}) %>
  ```

  ## Parameters

    - name: String with the module name of the component
    - props: Map with the props for the react component
    - options: Keyword list with render options

  It is possible to override both the receiver and the container div's attributes by passing
  a keyword list as `:container` and `:receiver` options.

  You can also override the tag type with the `:container_tag` and `:receiver_tag` options

  ```
  <%=
    PhoenixLiveReact.live_react_component("Components.MyComponent", %{},
      container: [class: "my-component"],
      container_tag: :p
    )
   %>
  ```
  """
  def live_react_component(name, props \\ %{}, options \\ []) do
    html_escape([
      receiver_element(name, props, options),
      container_element(options)
    ])
  end



  defp receiver_element(name, props, options) do
    attr = Keyword.get(options, :receiver, [])
    tag = Keyword.get(options, :receiver_tag, :div)

    default_attr = [
      style: "display: none;",
      data: [
        live_react_class: name,
        live_react_props: Jason.encode!(props)
      ],
      "phx-hook": "LiveReact"
    ]

    content_tag(tag, "", Keyword.merge(default_attr, attr))
  end

  defp container_element(options) do
    attr = Keyword.get(options, :container, [])
    tag = Keyword.get(options, :container_tag, :div)
    default_attr = ["phx-update": "ignore"]

    content_tag(tag, "", Keyword.merge(default_attr, attr))
  end
end
