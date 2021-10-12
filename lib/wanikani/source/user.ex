defmodule WaniKani.Source.User do
  use WaniKani.Source

  @resource "user"

  def fetch({:user, %{}}, _args) do
    {:ok, record} = WaniKani.Resource.one(@resource)
    %{%{} => record}
  end
end
