defmodule WaniKani.Source.Summary do
  alias WaniKani.Resource

  require Logger

  def data() do
    Dataloader.KV.new(&fetch/2)
  end

  def fetch({:summary, %{}}, _args) do
    {:ok, record} = Resource.one("summary")
    %{%{} => record}
  end

  def fetch(_batch, args) do
    ids = Enum.map(args, & &1[:summary_id])
    subjects = batch_request(ids)
    Enum.zip(args, subjects)
  end

  def batch_request(ids) do
    headers = Resource.headers()
    uri = Resource.uri("summary", %{ids: Enum.join(ids, ",")})

    Logger.debug("API Request: #{uri}")

    {:ok, res} =
      Finch.build(:get, uri, headers)
      |> Finch.request(WanikaniFinch)

    {:ok, json} = Jason.decode(res.body, keys: :atoms)

    Resource.map_records(json)
  end
end
