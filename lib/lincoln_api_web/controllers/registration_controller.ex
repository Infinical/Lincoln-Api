defmodule LincolnApiWeb.API.V1.RegistrationController do
    use LincolnApiWeb, :controller
  
    alias Ecto.Changeset
    alias Plug.Conn
    alias LincolnApiWeb.ErrorHelpers
  
    @spec create(Conn.t(), map()) :: Conn.t()
    def create(conn, %{"user" => user_params}) do
      conn
      |> Pow.Plug.create_user(user_params)
      |> case do
        {:ok, _user, conn} ->
          json(conn, %{status: 200, message: "Account created successfully",data: %{token: conn.private[:api_auth_token], renew_token: conn.private[:api_renew_token]}})
          SendGrid.Email.build()
          |> SendGrid.Email.add_to("inficalvin@gmail.com")
          |> SendGrid.Email.put_from("test2@email.com")
          |> SendGrid.Email.put_template("d-838aa6b683a845359bf447ed09f8d96c")
          |> SendGrid.Mail.send() 
  
        {:error, changeset, conn} ->
          errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
  
          conn
          |> put_status(500)
          |> json(%{status: 500, message: "Couldn't create user",error: %{ errors: errors}})
      end
    end
  end