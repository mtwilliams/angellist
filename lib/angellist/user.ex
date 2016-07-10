defmodule AngelList.User do
  @moduledoc ~S"""
  """

  defstruct ~w(id slug url portrait name biography does done criteria
               investor links locations roles skills followers)a

  def me, do: me(AngelList.client)
  def me(client) do
    AngelList.Client.get!(client, "1/me", %{}).body |> decode
  end

  def get(id: id), do: get(AngelList.client, id: id)
  def get(slug: slug), do: get(AngelList.client, slug: slug)
  def get(email: email), do: get(AngelList.client, email: email)

  def get(client, id: id) do
    AngelList.Client.get!(client, "1/users/#{id}", %{}).body |> decode
  end

  def get(client, slug: slug) do
    AngelList.Client.get!(client, "1/users/search", %{slug: slug}).body |> decode
  end

  def get(client, email: email) do
    hash = :crypto.hash(:md5, email) |> Base.encode16(case: :lower)
    AngelList.Client.get!(client, "1/users/search", %{email: hash}).body |> decode
  end

  def decode(response) when is_binary(response) do
    response |> Poison.decode! |> decode
  end

  def decode(user) when is_map(user) do
    %AngelList.User{
      id: user["id"],
      slug: AngelList.Slug.extract(user["angellist_url"]),
      url: user["angellist_url"],
      portrait: user["image"],
      name: user["name"],
      biography: user["bio"],
      does: user["what_i_do"],
      done: user["what_ive_built"],
      criteria: user["criteria"],
      investor: user["investor"],
      links: %{
        website: AngelList.URL.normalize(user["online_bio_url"]),
        resume: AngelList.URL.normalize(user["resume_url"]),
        blog: AngelList.URL.normalize(user["blog_url"]),
        facebook: AngelList.URL.normalize(user["facebook_url"]),
        linkedin: AngelList.URL.normalize(user["linkedin_url"]),
        twitter: AngelList.URL.normalize(user["twitter_url"]),
        aboutme: AngelList.URL.normalize(user["aboutme_url"]),
        dribbble: AngelList.URL.normalize(user["dribbble_url"]),
        behance: AngelList.URL.normalize(user["behance_url"]),
        github: AngelList.URL.normalize(user["github_url"])
      },
      locations: Enum.map(user["locations"] || [], &AngelList.LocationTag.decode/1),
      roles: Enum.map(user["roles"] || [], &AngelList.RoleTag.decode/1),
      skills: Enum.map(user["skills"] || [], &AngelList.SkillTag.decode/1),
      followers: user["follower_count"]
    }
  end
end
