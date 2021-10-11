defmodule WaniKani.Source.ReviewStatistic do
  alias WaniKani.Resource

  require Logger

  def data() do
    Dataloader.KV.new(&fetch/2)
  end

  def fetch({:review_statistic, %{id: id}}, _args) do
    {:ok, record} = Resource.one("review_statistics/#{id}")
    %{%{} => record}
  end

  def fetch({:review_statistics, %{}}, _) do
    {:ok, records} = Resource.all(:review_statistics)
    %{%{} => records}
  end

  def fetch(_batch, args) do
    ids = Enum.map(args, & &1[:review_statistic_id])
    subjects = batch_request(ids)
    Enum.zip(args, subjects)
  end

  def batch_request(ids) do
    headers = Resource.headers()
    uri = Resource.uri("review_statistics", %{ids: Enum.join(ids, ",")})

    Logger.debug("API Request: #{uri}")

    {:ok, res} =
      Finch.build(:get, uri, headers)
      |> Finch.request(WaniKaniFinch)

    {:ok, json} = Jason.decode(res.body, keys: :atoms)

    Resource.map_records(json)
  end
end