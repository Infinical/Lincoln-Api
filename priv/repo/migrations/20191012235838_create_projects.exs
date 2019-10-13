defmodule LincolnApi.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :image, :string
      add :description, :text
      add :start_date, :date
      add :end_date, :date
      add :attachment, :string

      timestamps()
    end

  end
end
