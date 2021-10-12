defmodule WaniKani.Resource do
  require Logger

  def api_host do
    Application.fetch_env!(:wanikani, :api_host)
  end

  def api_token do
    Application.fetch_env!(:wanikani, :api_token)
  end

  def api_version do
    Application.fetch_env!(:wanikani, :api_version)
  end

  def api_revision do
    Application.fetch_env!(:wanikani, :api_revision)
  end

  def map_records(json) do
    Enum.map(json.data, fn entry ->
      entry.data
      |> Map.put(:id, Map.get(entry, :id))
      |> Map.put(:url, Map.get(entry, :url))
    end)
  end

  def all(type) do
    {:ok, json} = request(type)
    {:ok, map_records(json)}
  end

  def one(:user) do
    {:ok, json} = request(:user)

    {:ok,
     json.data
     |> Map.put(:url, Map.get(json, :url))}
  end

  def one(type) do
    {:ok, json} = request(type)

    {:ok,
     json.data
     |> Map.put(:id, Map.get(json, :id))
     |> Map.put(:url, Map.get(json, :url))}
  end

  def headers() do
    [{"Authorization", "Bearer #{api_token()}"}, {"Wanikani-Revision", api_revision()}]
  end

  def uri(path, query \\ %{}) do
    uri = %URI{
      scheme: "https",
      host: api_host(),
      path: "/#{api_version()}/#{path}",
      query: Plug.Conn.Query.encode(query)
    }

    URI.to_string(uri)
  end

  def request(resource_type, query \\ %{}) do
    uri = uri(resource_type, query)

    {:ok, res} =
      Finch.build(:get, uri, headers())
      |> Finch.request(WaniKaniFinch)

    Logger.debug("Sending request: #{uri}")

    Jason.decode(res.body, keys: :atoms)
  end
end
