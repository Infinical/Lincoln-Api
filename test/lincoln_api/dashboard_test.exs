defmodule LincolnApi.DashboardTest do
  use LincolnApi.DataCase

  alias LincolnApi.Dashboard

  describe "projects" do
    alias LincolnApi.Dashboard.Project

    @valid_attrs %{attachment: "some attachment", description: "some description", end_date: ~D[2010-04-17], name: "some name", start_date: ~D[2010-04-17]}
    @update_attrs %{attachment: "some updated attachment", description: "some updated description", end_date: ~D[2011-05-18],name: "some updated name", start_date: ~D[2011-05-18]}
    @invalid_attrs %{attachment: nil, description: nil, end_date: nil,, name: nil, start_date: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Dashboard.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Dashboard.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Dashboard.create_project(@valid_attrs)
      assert project.attachment == "some attachment"
      assert project.description == "some description"
      assert project.end_date == ~D[2010-04-17]
      assert project.name == "some name"
      assert project.start_date == ~D[2010-04-17]
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Dashboard.update_project(project, @update_attrs)
      assert project.attachment == "some updated attachment"
      assert project.description == "some updated description"
      assert project.end_date == ~D[2011-05-18]
      assert project.name == "some updated name"
      assert project.start_date == ~D[2011-05-18]
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_project(project, @invalid_attrs)
      assert project == Dashboard.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Dashboard.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_project(project)
    end
  end

  describe "recommendations" do
    alias LincolnApi.Dashboard.Recommendations

    @valid_attrs %{attachment: "some attachment", end_date: "some end_date", rate: "some rate", start_date: "some start_date"}
    @update_attrs %{attachment: "some updated attachment", end_date: "some updated end_date", rate: "some updated rate", start_date: "some updated start_date"}
    @invalid_attrs %{attachment: nil, end_date: nil, rate: nil, start_date: nil}

    def recommendations_fixture(attrs \\ %{}) do
      {:ok, recommendations} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create_recommendations()

      recommendations
    end

    test "list_recommendations/0 returns all recommendations" do
      recommendations = recommendations_fixture()
      assert Dashboard.list_recommendations() == [recommendations]
    end

    test "get_recommendations!/1 returns the recommendations with given id" do
      recommendations = recommendations_fixture()
      assert Dashboard.get_recommendations!(recommendations.id) == recommendations
    end

    test "create_recommendations/1 with valid data creates a recommendations" do
      assert {:ok, %Recommendations{} = recommendations} = Dashboard.create_recommendations(@valid_attrs)
      assert recommendations.attachment == "some attachment"
      assert recommendations.end_date == "some end_date"
      assert recommendations.rate == "some rate"
      assert recommendations.start_date == "some start_date"
    end

    test "create_recommendations/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_recommendations(@invalid_attrs)
    end

    test "update_recommendations/2 with valid data updates the recommendations" do
      recommendations = recommendations_fixture()
      assert {:ok, %Recommendations{} = recommendations} = Dashboard.update_recommendations(recommendations, @update_attrs)
      assert recommendations.attachment == "some updated attachment"
      assert recommendations.end_date == "some updated end_date"
      assert recommendations.rate == "some updated rate"
      assert recommendations.start_date == "some updated start_date"
    end

    test "update_recommendations/2 with invalid data returns error changeset" do
      recommendations = recommendations_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_recommendations(recommendations, @invalid_attrs)
      assert recommendations == Dashboard.get_recommendations!(recommendations.id)
    end

    test "delete_recommendations/1 deletes the recommendations" do
      recommendations = recommendations_fixture()
      assert {:ok, %Recommendations{}} = Dashboard.delete_recommendations(recommendations)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_recommendations!(recommendations.id) end
    end

    test "change_recommendations/1 returns a recommendations changeset" do
      recommendations = recommendations_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_recommendations(recommendations)
    end
  end
end
