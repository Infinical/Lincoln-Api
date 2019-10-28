defmodule LincolnApiWeb.API.V1.InviteController do
  use LincolnApiWeb, :controller

  alias Ecto.Changeset
  alias Plug.Conn
  alias LincolnApiWeb.ErrorHelpers

  def create(conn, %{"user" => user_params}) do
    conn
    |> PowInvitation.Plug.create_user(user_params)
    |> case do
      {:ok, _user, conn} ->
        json(conn, %{
          status: 200,
          message: "Account created successfully",
          data: %{
            token: conn.private[:api_auth_token],
            renew_token: conn.private[:api_renew_token]
          }
        })

      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

        conn
        |> put_status(500)
        |> json(%{status: 500, message: "Couldn't create user", error: %{errors: errors}})
    end
  end
end
