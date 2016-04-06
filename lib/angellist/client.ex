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

  defp with_req_headers(client, headers) do
    Map.merge(%{"Authorization" => client.access_token,
                "User-Agent"    => client.options[:user_agent],
                "Content-Type"  => "application/json"}, headers)
  end

  def get!(client, path, headers, params), do: HTTPoison.get!(client.options[:base_url] <> path, with_req_headers(client, headers), params: params)
  def put!(client, path, headers, params), do: HTTPoison.post!(client.options[:base_url] <> path, params, with_req_headers(client, headers))
  def post!(client, path, headers, params), do: HTTPoison.post!(client.options[:base_url] <> path, params, with_req_headers(client, headers))
  def patch!(client, path, headers, params), do: HTTPoison.post!(client.options[:base_url] <> path, params, with_req_headers(client, headers))
  def delete!(client, path, headers, params), do: HTTPoison.post!(client.options[:base_url] <> path, with_req_headers(client, headers), params: params)
end
