defmodule WaniKani.Source.ReviewStatistic do
  use WaniKani.Source

  alias WaniKani.Resource

  @resource "review_statistics"

  def fetch({:review_statistic, %{id: id}}, _) do
    {:ok, record} = Resource.one("#{@resource}/#{id}")
    %{%{} => record}
  end

  def fetch({:review_statistics, params}, _) do
    {:ok, records} = Resource.request(@resource, params)
    %{%{} => Resource.map_records(records)}
  end

  def fetch(_batch, args) do
    ids =
      Enum.map(args, & &1[:review_statistic_id])
      |> Enum.join(",")

    records = batch_request(@resource, %{ids: ids})

    zip_batch(args, records)
  end
end
