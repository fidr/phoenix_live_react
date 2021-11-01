defmodule PhoenixLiveReact.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_live_react,
      version: "0.4.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: description(),
      docs: docs(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:phoenix_html, "~> 3.0"},
      {:jason, "~> 1.1"}
    ]
  end

  def description do
    """
    A helper library for easily rendering React components in
    Phoenix LiveView views.
    """
  end

  defp package do
    [
      name: :phoenix_live_react,
      files: ["lib", "priv", "mix.exs", "package.json", "README*", "LICENSE*"],
      maintainers: ["Robin Fidder"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/fidr/phoenix_live_react"}
    ]
  end

  defp docs do
    [
      name: "PhoenixLiveReact",
      source_url: "https://github.com/fidr/phoenix_live_react",
      homepage_url: "https://github.com/fidr/phoenix_live_react",
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
