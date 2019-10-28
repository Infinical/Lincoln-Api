defmodule LincolnApiWeb.API.V1.RecommendationsController do
  use LincolnApiWeb, :controller

  alias LincolnApi.Dashboard
  alias LincolnApi.Dashboard.Recommendations

  action_fallback LincolnApiWeb.FallbackController

  def index(conn, _params) do
    recommendations = Dashboard.list_recommendations()
    render(conn, "index.json", recommendations: recommendations)
  end

  def create(conn, %{"recommendations" => recommendations_params}) do
    with {:ok, %Recommendations{} = recommendations} <-
           Dashboard.create_recommendations(recommendations_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.api_v1_recommendations_path(conn, :show, recommendations)
      )
      |> render("show.json", recommendations: recommendations)
    end
  end

  def show(conn, %{"id" => id}) do
    recommendations = Dashboard.get_recommendations!(id)
    render(conn, "show.json", recommendations: recommendations)
  end

  def update(conn, %{"id" => id, "recommendations" => recommendations_params}) do
    recommendations = Dashboard.get_recommendations!(id)

    with {:ok, %Recommendations{} = recommendations} <-
           Dashboard.update_recommendations(recommendations, recommendations_params) do
      render(conn, "show.json", recommendations: recommendations)
    end
  end

  def delete(conn, %{"id" => id}) do
    recommendations = Dashboard.get_recommendations!(id)

    with {:ok, %Recommendations{}} <- Dashboard.delete_recommendations(recommendations) do
      send_resp(conn, :no_content, "")
    end
  end
end
