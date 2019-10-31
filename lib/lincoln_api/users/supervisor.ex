defmodule LincolnApi.Users.Supervisor do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "supervisors" do
    field :username, :string
    field :role, :string, default: "supervisor"
    pow_user_fields()
    has_many :projects, LincolnApi.Dashboard.Project

    timestamps()
  end
end
