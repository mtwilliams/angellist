defmodule AngelList.Role do
  @moduledoc ~S"""
  """

  defstruct ~w(id type title started ended tagged organization confirmed)a

  def decode(role) when is_binary(role) do
    role |> Poison.decode! |> decode
  end

  @types %{
    "founder" => :founder,
    "employee" => :employee,
    "current_investor" => :investor,
    "past_investor" => :investor,
    "advisor" => :advisor,
    "board_member" => :board_member,
    "incubator" => :incubator
  }

  def decode(role) when is_map(role) do
    %AngelList.Role {
      id: role["id"],
      type: @types[role["role"]],
      title: role["title"],
      started: role["started_at"],
      ended: role["ended_at"],
      tagged: decode_tagged(role["tagged"]),
      organization: AngelList.Organization.decode(role["startup"]),
      confirmed: role["confirmed"]
    }
  end

  defp decode_tagged(%{"type" => "User"} = tagged),
    do: AngelList.User.decode(tagged)

  defp decode_tagged(%{"type" => "Startup"} = tagged),
    do: AngelList.Organization.decode(tagged)
end
