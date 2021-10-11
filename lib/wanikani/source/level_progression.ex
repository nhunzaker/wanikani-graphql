defmodule WaniKani.Source.LevelProgression do
  alias WaniKani.Resource

  require Logger

  def data() do
    Dataloader.KV.new(&fetch/2)
  end

  def fetch({:level_progression, %{id: id}}, _args) do
    {:ok, record} = Resource.one("level_progressions/#{id}")
    %{%{} => record}
  end

  def fetch({:level_progressions, %{}}, _) do
    {:ok, records} = Resource.all(:level_progressions)
    %{%{} => records}
  end

  def fetch(_batch, args) do
    ids = Enum.map(args, & &1[:level_progression_id])
    subjects = batch_request(ids)
    Enum.zip(args, subjects)
  end

  def batch_request(ids) do
    headers = Resource.headers()
    uri = Resource.uri("level_progressions", %{ids: Enum.join(ids, ",")})

    Logger.debug("API Request: #{uri}")

    {:ok, res} =
      Finch.build(:get, uri, headers)
      |> Finch.request(WaniKaniFinch)

    {:ok, json} = Jason.decode(res.body, keys: :atoms)

    Resource.map_records(json)
  end
end
