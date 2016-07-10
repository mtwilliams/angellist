defmodule AngelList.LocationTag do
  @moduledoc ~S"""
  """

  defstruct ~w(id slug url name pretty)a

  def get(id: id), do: get(AngelList.client, id: id)
  def get(client, id: id) do
    AngelList.Tag.get(client, id: id) |> decode
  end

  def decode(%{"tag_type" => "LocationTag"} = tag) do
    tag |> AngelList.Tag.decode |> decode
  end

  def decode(%AngelList.Tag{type: :location} = tag) do
    %AngelList.LocationTag {
      id: tag.id,
      slug: tag.slug,
      url: tag.url,
      name: tag.name,
      pretty: tag.pretty
    }
  end
end
