defmodule WaniKani.MixProject do
  use Mix.Project

  def project do
    [
      app: :wanikani,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {WaniKani.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:absinthe, "~> 1.6.6"},
      {:absinthe_plug, "~> 1.5.8"},
      {:dataloader, "~> 1.0.0"},
      {:jason, "~> 1.0"},
      {:finch, "~> 0.8.2"},

      # DEVELOPMENT
      {:exsync, "~> 0.2", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
