defmodule LincolnApiWeb.Router do
  use LincolnApiWeb, :router
 

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,error_handler: LincolnApiWeb.ApiAuthErrorHandler
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    plug LincolnApiWeb.ApiAuthPlug, otp_app: :lincoln_api
  end

  scope "/api/v1", LincolnApiWeb.API.V1, as: :api_v1 do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end

  scope "/api/v1", LincolnApiWeb.API.V1, as: :api_v1 do
    pipe_through [:api,:protected]
    resources "/projects", ProjectController
    
    
  end
end
