defmodule WaniKani.Source.SpacedRepetitionSystem do
  use WaniKani.Source

  alias WaniKani.Resource

  @resource "spaced_repetition_system"

  def fetch({:spaced_repetition_system, %{id: id}}, _args) do
    {:ok, record} = Resource.one("#{@resource}/#{id}")
    %{%{} => record}
  end

  def fetch({:spaced_repetition_systems, params}, _) do
    {:ok, records} = Resource.request(@resource, params)
    %{%{} => Resource.map_records(records)}
  end

  def fetch(_batch, args) do
    ids =
      Enum.map(args, & &1[:spaced_repetition_system_id])
      |> Enum.join(",")

    records = batch_request(@resource, %{ids: ids})

    zip_batch(args, records)
  end
end
