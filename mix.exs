defmodule PokemonApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :pokemon_api,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {PokemonApi.Application, []}
    ]
  end

  defp deps do
    [
      # for Tesla HTTP server
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"},

      # for ecto portion
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},

      # for testing
      {:hammox, "~> 0.5", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]
end
