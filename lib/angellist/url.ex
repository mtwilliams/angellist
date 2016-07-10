defmodule AngelList.URL do
  @moduledoc ~S"""
  """

  def normalize(nil), do: nil
  def normalize(""), do: nil
  def normalize(url) when is_binary(url), do: url
end
