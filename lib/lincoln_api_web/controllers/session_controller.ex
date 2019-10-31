defmodule LincolnApiWeb.API.V1.SessionController do
  use LincolnApiWeb, :controller

  alias LincolnApi.Accounts
  alias LincolnApi.Users.User
  alias LincolnApiWeb.ApiAuthPlug

  @spec create(Conn.t(), map()) :: Conn.t()

  def create(conn, %{"user" => user_params}) do
    conn
    |> Pow.Plug.authenticate_user(user_params)
    |> case do
      {:ok, conn} ->
        user = Jason.encode(conn.assigns.current_user)

        json(conn, %{
          data: %{
            token: conn.private[:api_auth_token],
            renew_token: conn.private[:api_renew_token],
            user: conn.assigns.current_user
          }
        })

      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end

  @spec renew(Conn.t(), map()) :: Conn.t()
  def renew(conn, _params) do
    config = Pow.Plug.fetch_config(conn)

    conn
    |> ApiAuthPlug.renew(config)
    |> case do
      {conn, nil} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid token"}})

      {conn, _user} ->
        json(conn, %{
          data: %{
            token: conn.private[:api_auth_token],
            renew_token: conn.private[:api_renew_token]
          }
        })
    end
  end

  def show(conn, _params) do
    conn
    |> Pow.Plug.current_user()
    |> IO.inspect()
  end

  @spec delete(Conn.t(), map()) :: Conn.t()
  def delete(conn, _params) do
    {:ok, conn} = Pow.Plug.clear_authenticated_user(conn)

    json(conn, %{data: %{message: "User Log Out Successful"}})
  end

  def list_users(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def fetch_supervisors(conn, _params) do
    supervisors = Accounts.list_supervisors()
    render(conn, "index.json", users: supervisors)
  end
end
