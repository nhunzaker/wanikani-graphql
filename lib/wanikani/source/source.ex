defmodule WaniKani.Source do
  alias WaniKani.Resource

  require Logger

  def batch_request(path, query) do
    headers = Resource.headers()
    uri = Resource.uri(path, query)

    Logger.debug("API Request: #{uri}")

    {:ok, res} =
      Finch.build(:get, uri, headers)
      |> Finch.request(WaniKaniFinch)

    {:ok, json} = Jason.decode(res.body, keys: :atoms)

    Resource.map_records(json)
  end

  def zip_batch(args, records) do
    Enum.zip_reduce(args, records, %{}, fn key, val, acc ->
      Map.put(acc, key, val)
    end)
  end

  defmacro __using__(_opts) do
    quote do
      import WaniKani.Source

      def data() do
        Dataloader.KV.new(&fetch/2)
      end
    end
  end
end
