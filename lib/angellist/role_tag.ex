defmodule AngelList.RoleTag do
  @moduledoc ~S"""
  """

  defstruct ~w(id slug url name pretty)a

  def decode(%{"tag_type" => "RoleTag"} = tag) do
    tag |> AngelList.Tag.decode |> decode
  end

  def decode(%AngelList.Tag{type: :role} = tag) do
    %AngelList.RoleTag {
      id: tag.id,
      slug: tag.slug,
      url: tag.url,
      name: tag.name,
      pretty: tag.pretty
    }
  end
end
