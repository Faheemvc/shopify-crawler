defmodule Shopifyscrap.MixProject do
  use Mix.Project

  def project do
    [
      app: :shopifyscrap,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Shopifyscrap.Application, []},
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:crawly, "~> 0.17.0"},
      {:floki, "~> 0.33.0"},
      {:jason, "~> 1.4"}

    ]
  end
end
