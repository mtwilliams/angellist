defmodule AngelList.Client do
  @moduledoc ~S"""
  """

  defstruct ~w(client_id client_secret access_token options)a

  @doc ~S"""
  """
  def new(overrides \\ []) do
    fields = Enum.map(~w(client_id client_secret access_token)a, fn field ->
      value = Keyword.get(overrides, field, Application.get_env(:angellist, field))
      {field, value}
    end)

    default_options = Enum.into(AngelList.defaults, %{})
    options = Enum.into(Keyword.get(overrides, :options, []), default_options)

    struct(__MODULE__, Enum.into(fields, %{options: options}))
  end

  defp headers(client) do
    %{"Authorization" => client.access_token,
      "User-Agent"    => client.options[:user_agent],
      "Content-Type"  => "application/json"}
  end

  def get!(client, path, params), do: HTTPoison.get!(client.options[:base_url] <> path, headers(client), params: params)
  def put!(client, path, params), do: HTTPoison.post!(client.options[:base_url] <> path, params, headers(client))
  def post!(client, path, params), do: HTTPoison.post!(client.options[:base_url] <> path, params, headers(client))
  def patch!(client, path, params), do: HTTPoison.post!(client.options[:base_url] <> path, params, headers(client))
  def delete!(client, path, params), do: HTTPoison.post!(client.options[:base_url] <> path, headers(client), params: params)
end
