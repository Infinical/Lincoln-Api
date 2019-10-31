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
      # add :recommendations_id, references(:recommendations)

      timestamps()
    end

    create unique_index(:projects, [:user_id])
    create unique_index(:projects, [:supervisor_id])
    # create unique_index(:projects, [:recommendation_id])
  end
end
