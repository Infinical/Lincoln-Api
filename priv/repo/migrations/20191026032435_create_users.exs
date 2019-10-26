defmodule LincolnApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string
      add :role,  :string , null: false ,   default: "ambassador"
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
