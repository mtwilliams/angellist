defmodule AngelList.Tag do
  @moduledoc ~S"""
  """

  defstruct ~w(type id slug url name pretty)a

  def get(id: id), do: get(AngelList.client, id: id)
  def get(client, id: id) do
    AngelList.Client.get!(client, "1/tags/#{id}", %{}).body |> decode
  end

  def decode(response) when is_binary(response) do
    response |> Poison.decode! |> decode
  end

  @types %{
    "LocationTag" => :location,
    "MarketTag" => :market,
    "RoleTag" => :role,
    "SkillTag" => :skill
  }

  def decode(tag) when is_map(tag) do
    %AngelList.Tag{
      type: @types[tag["tag_type"]],
      id: tag["id"],
      slug: AngelList.Slug.extract(tag["angellist_url"]),
      url: tag["angellist_url"],
      name: tag["name"],
      pretty: tag["display_name"]
    }
  end
end
