defmodule WaniKani.Source.LevelProgression do
  use WaniKani.Source

  alias WaniKani.Resource

  @resource "level_progressions"

  def fetch({:level_progression, %{id: id}}, _args) do
    {:ok, record} = Resource.one("#{@resource}/#{id}")
    %{%{} => record}
  end

  def fetch({:level_progressions, params}, _) do
    {:ok, records} = Resource.request(@resource, params)
    %{%{} => Resource.map_records(records)}
  end

  def fetch(_batch, args) do
    ids =
      Enum.map(args, & &1[:level_progression_id])
      |> Enum.join(",")

    records = batch_request(@resource, %{ids: ids})

    zip_batch(args, records)
  end
end
