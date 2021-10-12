defmodule WaniKani.Source.VoiceActor do
  use WaniKani.Source

  alias WaniKani.Resource

  @resource "voice_actor"

  def fetch({:voice_actor, %{id: id}}, _args) do
    {:ok, record} = Resource.one("#{@resource}/#{id}")
    %{%{} => record}
  end

  def fetch({:voice_actors, params}, _) do
    {:ok, records} = Resource.request(@resource, params)
    %{%{} => Resource.map_records(records)}
  end

  def fetch(_batch, args) do
    ids =
      Enum.map(args, & &1[:voice_actor_id])
      |> Enum.join(",")

    records = batch_request(@resource, %{ids: ids})

    zip_batch(args, records)
  end
end
