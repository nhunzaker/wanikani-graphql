defmodule WaniKani.Resource do
  def api_host do
    Application.fetch_env!(:wanikani, :api_host)
  end

  def api_token do
    Application.fetch_env!(:wanikani, :api_token)
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
    [{"Authorization", "Bearer #{api_token()}"}]
  end

  def uri(path, query \\ %{}) do
    uri = %URI{
      scheme: "https",
      host: api_host(),
      path: "/v2/#{path}",
      query: Plug.Conn.Query.encode(query)
    }

    URI.to_string(uri)
  end

  defp request(resource_type) do
    {:ok, res} =
      Finch.build(:get, uri(resource_type), headers())
      |> Finch.request(WaniKaniFinch)

    Jason.decode(res.body, keys: :atoms)
  end
end
