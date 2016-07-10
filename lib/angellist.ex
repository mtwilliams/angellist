defmodule AngelList do
  @moduledoc ~S"""
  """

  @options ~w(user_agent base_url proxy timeout)a

  @defaults [{:user_agent, "Elixir/#{System.version()}"},
             {:base_url, "https://api.angel.co/"},
             {:proxy, nil},
             {:timeout, 5000}]

  for {name, default} <- @defaults do
    def unquote(:"default_#{name}")(), do: unquote(default)
    def unquote(name)(), do: Application.get_env(:angellist, unquote(name), unquote(default))
  end

  @doc ~S"""
  """
  def defaults do
    Enum.map(@options, fn option ->
      {option, apply(AngelList, option, [])}
    end)
  end

  @doc ~S"""
  """
  def options, do: @options

  @doc ~S"""
  """
  def client(options \\ []), do: AngelList.Client.new(options)
end
