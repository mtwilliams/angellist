defmodule AngelList.Slug do
  @moduledoc ~S"""
  """

  def extract("http://angel.co/" <> slug), do: slug
  def extract("https://angel.co/" <> slug), do: slug
  def extract(_), do: nil
end
