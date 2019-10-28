defmodule LincolnApiWeb.RecommendationsControllerTest do
  use LincolnApiWeb.ConnCase

  alias LincolnApi.Dashboard
  alias LincolnApi.Dashboard.Recommendations

  @create_attrs %{
    attachment: "some attachment",
    end_date: "some end_date",
    rate: "some rate",
    start_date: "some start_date"
  }
  @update_attrs %{
    attachment: "some updated attachment",
    end_date: "some updated end_date",
    rate: "some updated rate",
    start_date: "some updated start_date"
  }
  @invalid_attrs %{attachment: nil, end_date: nil, rate: nil, start_date: nil}

  def fixture(:recommendations) do
    {:ok, recommendations} = Dashboard.create_recommendations(@create_attrs)
    recommendations
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all recommendations", %{conn: conn} do
      conn = get(conn, Routes.recommendations_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create recommendations" do
    test "renders recommendations when data is valid", %{conn: conn} do
      conn = post(conn, Routes.recommendations_path(conn, :create), recommendations: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.recommendations_path(conn, :show, id))

      assert %{
               "id" => id,
               "attachment" => "some attachment",
               "end_date" => "some end_date",
               "rate" => "some rate",
               "start_date" => "some start_date"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.recommendations_path(conn, :create), recommendations: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update recommendations" do
    setup [:create_recommendations]

    test "renders recommendations when data is valid", %{conn: conn, recommendations: %Recommendations{id: id} = recommendations} do
      conn = put(conn, Routes.recommendations_path(conn, :update, recommendations), recommendations: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.recommendations_path(conn, :show, id))

      assert %{
               "id" => id,
               "attachment" => "some updated attachment",
               "end_date" => "some updated end_date",
               "rate" => "some updated rate",
               "start_date" => "some updated start_date"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, recommendations: recommendations} do
      conn = put(conn, Routes.recommendations_path(conn, :update, recommendations), recommendations: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete recommendations" do
    setup [:create_recommendations]

    test "deletes chosen recommendations", %{conn: conn, recommendations: recommendations} do
      conn = delete(conn, Routes.recommendations_path(conn, :delete, recommendations))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.recommendations_path(conn, :show, recommendations))
      end
    end
  end

  defp create_recommendations(_) do
    recommendations = fixture(:recommendations)
    {:ok, recommendations: recommendations}
  end
end
