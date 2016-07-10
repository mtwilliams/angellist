defmodule AngelList.SkillTag do
  @moduledoc ~S"""
  """

  # TODO(mtwilliams): Track `level`?
  defstruct ~w(id slug url name pretty)a

  def decode(%{"tag_type" => "SkillTag"} = tag) do
    tag |> AngelList.Tag.decode |> decode
  end

  def decode(%AngelList.Tag{type: :skill} = tag) do
    %AngelList.SkillTag {
      id: tag.id,
      slug: tag.slug,
      url: tag.url,
      name: tag.name,
      pretty: tag.pretty
    }
  end
end
