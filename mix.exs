defmodule AngelList.Mixfile do
  use Mix.Project

  def project do
    [name: "AngelList",
     app: :angellist,
     version: version,
     description: "AngelList for Alchemists.",
     homepage_url: homepage_url,
     source_url: github_url,
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package,
     docs: docs,
     test_coverage: [tool: ExCoveralls]]
  end

  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(_), do: ~w()a ++ applications
  defp applications, do: ~w(logger httpoison)a

  defp homepage_url, do: github_url
  defp github_url, do: "https://github.com/mtwilliams/angellist"
  defp documentation_url, do: "https://github.com/mtwilliams/angellist"

  defp version do
    case System.cmd("git", ["describe", "--tags"], stderr_to_stdout: true) do
      {tag, 0} ->
        String.strip(tag)
      _ ->
        "0.0.0"
    end
  end

  defp elixirc_paths(:test), do: ~w(test/support) ++ elixirc_paths
  defp elixirc_paths(_), do: elixirc_paths
  defp elixirc_paths, do: ~w(lib)

  defp deps do [
    {:httpoison, "~> 0.8"},
    {:poison, ">= 1.0.0"},

    # Testing
    {:excoveralls, "~> 0.4", only: :test},

    # Documentation
    {:ex_doc, "~> 0.10", only: :docs},
    {:earmark, "~> 0.1", only: :docs},
    {:inch_ex, ">= 0.0.0", only: :docs}
  ] end

  defp package do
    [maintainers: ["Michael Williams"],
     licenses: ["Public Domain"],
     links: %{"GitHub" => github_url, "Docs" => documentation_url},
     files: ~w(mix.exs lib README* LICENSE*)]
  end

  defp docs do
    [main: "AngelList",
     canonical: "http://hexdocs.pm/angellist",
     source_ref: version,
     source_url: github_url]
  end
end
