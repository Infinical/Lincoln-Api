defmodule LincolnApiWeb.API.V1.RecommendationsView do
  use LincolnApiWeb, :view
  alias LincolnApiWeb.API.V1.RecommendationsView

  def render("index.json", %{recommendations: recommendations}) do
    %{data: render_many(recommendations, RecommendationsView, "recommendations.json")}
  end

  def render("show.json", %{recommendations: recommendations}) do
    %{data: render_one(recommendations, RecommendationsView, "recommendations.json")}
  end

  def render("recommendations.json", %{recommendations: recommendations}) do
    %{
      id: recommendations.id,
      start_date: recommendations.start_date,
      end_date: recommendations.end_date,
      rate: recommendations.rate,
      attachment: recommendations.attachment
    }
  end
end
