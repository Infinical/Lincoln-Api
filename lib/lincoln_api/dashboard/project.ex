defmodule LincolnApi.Dashboard.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :attachment, :string
    field :description, :string
    field :end_date, :string
    field :image, :string
    field :name, :string
    field :start_date, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :image, :description, :start_date, :end_date, :attachment])
    |> validate_required([:name, :image, :description, :start_date, :end_date])
   
  end
end
