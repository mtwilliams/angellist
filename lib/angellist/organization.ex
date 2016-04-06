defmodule AngelList.Organization do
  @moduledoc ~S"""
  """

  defstruct ~w(id url hidden unclaimed logo name brief detailed quality links followers markets locations)a

  def get(id: id), do: get(AngelList.client, id: id)
  def get(client, id: id) do
    AngelList.Client.get!(client, "1/startups/#{id}", %{}).body |> decode
  end

  def decode(response) when is_binary(response) do
    decode(Poison.decode!(response))
  end

  def decode(org) when is_map(org) do
    %AngelList.Organization{
      id: org["id"],
      url: org["angellist_url"],
      hidden: org["hidden"],
      unclaimed: org["community_profile"],
      logo: org["logo_url"],
      name: org["name"],
      brief: org["high_concept"],
      detailed: org["product_desc"],
      quality: org["quality"],
      links: %{
        web: AngelList.URL.normalize(org["company_url"]),
        blog: AngelList.URL.normalize(org["blog_url"]),
        facebook: AngelList.URL.normalize(org["facebook_url"]),
        linkedin: AngelList.URL.normalize(org["linkedin_url"]),
        twitter: AngelList.URL.normalize(org["twitter_url"]),
        crunchbase: AngelList.URL.normalize(org["crunchbase_url"])
      },
      followers: org["follower_count"],
      markets: decode_tags(org["markets"]),
      locations: decode_tags(org["locations"])
    }
  end

  defp decode_tags(tags) do
    Enum.map(tags, &(AngelList.Tag.decode(&1)))
  end
end
