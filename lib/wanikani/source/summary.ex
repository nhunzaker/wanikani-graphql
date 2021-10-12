defmodule WaniKani.Source.Summary do
  use WaniKani.Source

  alias WaniKani.Resource

  @resource "summary"

  def fetch({:summary, params}, _args) do
    {:ok, records} = Resource.request(@resource, params)
    %{%{} => Resource.map_records(records)}
  end
end
