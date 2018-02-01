defmodule ApplePay.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :apple_pay,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ]
    ]
  end

  defp description do
    """
    Apple Pay Session Initializer
    """
  end

  defp package do
    [
      name: :apple_pay,
      files: ["lib", "mix.exs", "README*", "LICENSE"],
      maintainers: ["airatel Inc.", "Jonatan Männchen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jshmrtn/ex-apple-pay"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:httpoison, "~> 0.13"},
      {:exvcr, "~> 0.10.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:inch_ex, ">= 0.0.0", only: :docs, runtime: false},
      {:credo, "~> 0.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.4", only: [:dev, :test], runtime: false}
    ]
  end
end
