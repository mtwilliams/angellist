defmodule AngelList.Tag do
  @moduledoc ~S"""
  """

  defstruct ~w(id url type name pretty)a

  def decode(response) when is_binary(response) do
    decode(Poison.decode!(response))
  end

  def decode(tag) when is_map(tag) do
    %AngelList.Tag{
      id: tag["id"],
      type: decode_type(tag),
      url: tag["angellist_url"],
      name: tag["name"],
      pretty: tag["display_name"]
    }
  end

  @external_to_internal %{"MarketTag" => :market, "LocationTag" => :location, "RoleTag" => :role}
  defp decode_type(tag), do: @external_to_internal[tag["tag_type"]]
end
