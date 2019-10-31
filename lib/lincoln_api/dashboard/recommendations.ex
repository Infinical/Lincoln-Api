defmodule LincolnApi.Dashboard.Recommendations do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recommendations" do
    field :attachment, :string
    field :end_date, :string
    field :rate, :string
    field :start_date, :string

    belongs_to :project, LincolnApi.Dashboard.Project

    timestamps()
  end

  @doc false
  def changeset(recommendations, attrs) do
    recommendations
    |> cast(attrs, [:start_date, :end_date, :rate, :attachment, :project_id])
    |> validate_required([:start_date, :end_date, :project_id])
  end
end
