defmodule LincolnApi.Dashboard do
  @moduledoc """
  The Dashboard context.
  """

  import Ecto.Query, warn: false
  alias LincolnApi.Repo

  alias LincolnApi.Dashboard.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  def list_by_user_id(id) do
    query = from(p in Project, where: p.user_id == ^id)
    Repo.all(query)
  end

  def by_sup_id(id) do
    query = from(p in Project, where: p.supervisor_id == ^id)
    Repo.all(query)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{source: %Project{}}

  """
  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  alias LincolnApi.Dashboard.Recommendations

  @doc """
  Returns the list of recommendations.

  ## Examples

      iex> list_recommendations()
      [%Recommendations{}, ...]

  """
  def list_recommendations do
    Repo.all(Recommendations)
  end

  @doc """
  Gets a single recommendations.

  Raises `Ecto.NoResultsError` if the Recommendations does not exist.

  ## Examples

      iex> get_recommendations!(123)
      %Recommendations{}

      iex> get_recommendations!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recommendations!(id), do: Repo.get!(Recommendations, id)

  @doc """
  Creates a recommendations.

  ## Examples

      iex> create_recommendations(%{field: value})
      {:ok, %Recommendations{}}

      iex> create_recommendations(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recommendations(attrs \\ %{}) do
    %Recommendations{}
    |> Recommendations.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recommendations.

  ## Examples

      iex> update_recommendations(recommendations, %{field: new_value})
      {:ok, %Recommendations{}}

      iex> update_recommendations(recommendations, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recommendations(%Recommendations{} = recommendations, attrs) do
    recommendations
    |> Recommendations.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Recommendations.

  ## Examples

      iex> delete_recommendations(recommendations)
      {:ok, %Recommendations{}}

      iex> delete_recommendations(recommendations)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recommendations(%Recommendations{} = recommendations) do
    Repo.delete(recommendations)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recommendations changes.

  ## Examples

      iex> change_recommendations(recommendations)
      %Ecto.Changeset{source: %Recommendations{}}

  """
  def change_recommendations(%Recommendations{} = recommendations) do
    Recommendations.changeset(recommendations, %{})
  end
end
