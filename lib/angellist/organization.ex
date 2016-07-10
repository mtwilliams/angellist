defmodule AngelList.Organization do
  @moduledoc ~S"""
  """

  defstruct ~w(id url slug hidden claimed logo name brief detailed links
               markets locations followers quality)a

  def get(id: id), do: get(AngelList.client, id: id)
  def get(client, id: id) do
    AngelList.Client.get!(client, "1/startups/#{id}", %{}).body |> decode
  end

  def roles(id, opts) when is_integer(id), do:
    roles(AngelList.client, id, opts)
  def roles(%AngelList.Organization{id: id}, opts),
    do: roles(AngelList.client, id, opts)
  def roles(client, %AngelList.Organization{id: id}, opts),
    do: roles(client, id, opts)
  def roles(client, id, opts) when is_integer(id) do
    # TODO(mtwilliams): Refactor |paginiation_related_opts| extraction.
    pagination_related_opts = Keyword.take(opts, ~w(page per_page)a)

    page =
      AngelList.Client.get!(client, "1/startups/#{id}/roles", pagination_related_opts).body
      |> AngelList.Page.decode

    decoded =
      page.results
      |> Enum.map(&AngelList.Role.decode/1)

    %AngelList.Page{page | results: decoded}
  end

  def decode(response) when is_binary(response) do
    response |> Poison.decode! |> decode
  end

  def decode(org) when is_map(org) do
    %AngelList.Organization{
      id: org["id"],
      url: org["angellist_url"],
      slug: AngelList.Slug.extract(org["angellist_url"]),
      hidden: org["hidden"],
      claimed: !org["community_profile"],
      logo: org["logo_url"],
      name: org["name"],
      brief: org["high_concept"],
      detailed: org["product_desc"],
      links: %{
        website: AngelList.URL.normalize(org["company_url"]),
        blog: AngelList.URL.normalize(org["blog_url"]),
        facebook: AngelList.URL.normalize(org["facebook_url"]),
        linkedin: AngelList.URL.normalize(org["linkedin_url"]),
        twitter: AngelList.URL.normalize(org["twitter_url"]),
        crunchbase: AngelList.URL.normalize(org["crunchbase_url"])
      },
      markets: Enum.map(org["markets"] || [], &AngelList.MarketTag.decode/1),
      locations: Enum.map(org["locations"] || [], &AngelList.LocationTag.decode/1),
      followers: org["follower_count"],
      quality: org["quality"]
    }
  end
end
