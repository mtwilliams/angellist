defmodule AngelList.Page do
  @moduledoc ~S"""
  """

  defstruct ~w(results total per_page page last_page)a

  def decode(page) when is_binary(page) do
    page |> Poison.decode! |> decode
  end

  def decode(page) when is_map(page) do
    results_are_called =
      page
      |> Map.keys
      |> Enum.reject(&(&1 in ~w(total per_page page last_page)))
      |> List.first

    %AngelList.Page{
      results: page[results_are_called],
      total: page["total"],
      per_page: page["per_page"],
      page: page["page"],
      last_page: page["last_page"]
    }
  end
end

# TODO(mtwilliams): Fetch more pages until exhausted.
defimpl Enumerable, for: AngelList.Page do
  @type page :: %AngelList.Page{}

  @spec count(page) :: {:ok, non_neg_integer}
  def count(page), do: {:ok, length(page.results)} # {:ok, page.total}

  @spec member?(page, term) :: {:error, module}
  def member?(_page, _), do: {:error, __MODULE__}

  @spec reduce(page, Enumerable.acc, Enumerable.reducer) :: Enumerable.result
  def reduce(page, acc, reducer) do
    Enumerable.reduce(page.results, acc, reducer)
  end
end
