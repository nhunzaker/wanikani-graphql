defmodule WaniKani.Source.SpacedRepetitionSystem do
  alias WaniKani.Resource

  require Logger

  def data() do
    Dataloader.KV.new(&fetch/2)
  end

  def fetch({:spaced_repetition_system, %{id: id}}, _args) do
    {:ok, record} = Resource.one("spaced_repetition_systems/#{id}")
    %{%{} => record}
  end

  def fetch({:spaced_repetition_systems, %{}}, _) do
    {:ok, records} = Resource.all(:spaced_repetition_systems)
    %{%{} => records}
  end

  def fetch(_batch, args) do
    ids = Enum.map(args, & &1[:spaced_repetition_system_id])
    subjects = batch_request(ids)
    Enum.zip(args, subjects)
  end

  def batch_request(ids) do
    headers = Resource.headers()
    uri = Resource.uri("spaced_repetition_systems", %{ids: Enum.join(ids, ",")})

    Logger.debug("API Request: #{uri}")

    {:ok, res} =
      Finch.build(:get, uri, headers)
      |> Finch.request(WaniKaniFinch)

    {:ok, json} = Jason.decode(res.body, keys: :atoms)

    Resource.map_records(json)
  end
end
