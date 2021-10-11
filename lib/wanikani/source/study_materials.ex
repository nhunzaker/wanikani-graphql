defmodule WaniKani.Source.StudyMaterial do
  alias WaniKani.Resource

  require Logger

  def data() do
    Dataloader.KV.new(&fetch/2)
  end

  def fetch({:study_material, %{id: id}}, _args) do
    {:ok, record} = Resource.one("study_materials/#{id}")
    %{%{} => record}
  end

  def fetch({:study_materials, %{}}, _) do
    {:ok, records} = Resource.all(:study_materials)
    %{%{} => records}
  end

  def fetch(_batch, args) do
    ids = Enum.map(args, & &1[:study_material_id])
    subjects = batch_request(ids)
    Enum.zip(args, subjects)
  end

  def batch_request(ids) do
    headers = Resource.headers()
    uri = Resource.uri("study_materials", %{ids: Enum.join(ids, ",")})

    Logger.debug("API Request: #{uri}")

    {:ok, res} =
      Finch.build(:get, uri, headers)
      |> Finch.request(WaniKaniFinch)

    {:ok, json} = Jason.decode(res.body, keys: :atoms)

    Resource.map_records(json)
  end
end
