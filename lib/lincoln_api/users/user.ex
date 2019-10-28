defmodule LincolnApi.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  use Pow.Extension.Ecto.Schema,
    extensions: [PowInvitation]

  @derive {Jason.Encoder, only: [:email, :username, :role, :id]}
  schema "users" do
    field :username, :string
    field :role, :string, default: "ambassador"
    pow_user_fields()
    has_many :projects, LincolnApi.Dashboard.Project

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> changeset_username(attrs)
    |> changeset_role(attrs)
  end

  def changeset_username(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:username])
    |> Ecto.Changeset.validate_required([:username])
  end

  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(ambassador supervisor administrator))
  end
end
