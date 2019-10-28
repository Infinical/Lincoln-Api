defmodule LincolnApi.Repo.Migrations.CreateRecommendations do
  use Ecto.Migration

  def change do
    create table(:recommendations) do
      add :start_date, :string
      add :end_date, :string
      add :rate, :string
      add :attachment, :string
      add :project_id, references(:projects)

      timestamps()
    end
  end
end
