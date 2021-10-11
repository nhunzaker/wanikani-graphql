defmodule WaniKani.Source.VoiceActor do
  alias WaniKani.Resource

  require Logger

  def data() do
    Dataloader.KV.new(&fetch/2)
  end

  def fetch({:voice_actor, %{id: id}}, _args) do
    {:ok, record} = Resource.one("voice_actors/#{id}")
    %{%{} => record}
  end

  def fetch({:voice_actors, %{}}, _) do
    {:ok, records} = Resource.all(:voice_actors)
    %{%{} => records}
  end

  def fetch(_batch, args) do
    ids = Enum.map(args, & &1[:voice_actor_id])
    voice_actors = batch_request(ids)
    Enum.zip(args, voice_actors)
  end

  def batch_request(ids) do
    headers = Resource.headers()
    uri = Resource.uri("voice_actors", %{ids: Enum.join(ids, ",")})

    Logger.debug("API Request: #{uri}")

    {:ok, res} =
      Finch.build(:get, uri, headers)
      |> Finch.request(WanikaniFinch)

    {:ok, json} = Jason.decode(res.body, keys: :atoms)

    Resource.map_records(json)
  end
end
