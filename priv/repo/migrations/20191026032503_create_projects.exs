defmodule LincolnApi.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :text
      add :start_date, :string
      add :end_date, :string
      add :attachment, :string
      add :user_id, references(:users)
      add :supervisor_id, references(:users)

      timestamps()
    end
  end
end
