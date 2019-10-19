defmodule LincolnApiWeb.API.V1.ProjectView do
  use LincolnApiWeb, :view
  alias LincolnApiWeb.API.V1.ProjectView

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      name: project.name,
      image: project.image,
      description: project.description,
      start_date: project.start_date,
      end_date: project.end_date,
      attachment: project.attachment}
  end
end
