defmodule LincolnApi.Dashboard.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :attachment, :string
    field :description, :string
    field :end_date, :string
    field :name, :string
    field :start_date, :string
    belongs_to :user, LincolnApi.Users.User
    belongs_to :supervisor, LincolnApi.Users.Supervisor
    has_one :recommendation, LincolnApi.Dashboard.Recommendations
    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :name,
      :description,
      :start_date,
      :end_date,
      :attachment,
      :user_id,
      :supervisor_id
    ])
    |> validate_required([:name, :description, :start_date, :end_date, :user_id])
  end
end
