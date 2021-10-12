defmodule WaniKani.Source.StudyMaterial do
  use WaniKani.Source

  alias WaniKani.Resource

  @resource "study_material"

  def fetch({:study_material, %{id: id}}, _args) do
    {:ok, record} = Resource.one("#{@resource}/#{id}")
    %{%{} => record}
  end

  def fetch({:study_materials, params}, _) do
    {:ok, records} = Resource.request(@resource, params)
    %{%{} => Resource.map_records(records)}
  end

  def fetch(_batch, args) do
    ids =
      Enum.map(args, & &1[:study_material_id])
      |> Enum.join(",")

    records = batch_request(@resource, %{ids: ids})

    zip_batch(args, records)
  end
end
