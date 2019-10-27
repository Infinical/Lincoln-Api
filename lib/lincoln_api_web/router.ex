defmodule LincolnApiWeb.Router do
  use LincolnApiWeb, :router

  pipeline :admin do
    plug LincolnApiWeb.Plugs.EnsureRolePlug, :administrator
  end

  pipeline :sup do
    plug LincolnApiWeb.Plugs.EnsureRolePlug, :supervisor
  end

  pipeline :ambassador do
    plug LincolnApiWeb.Plugs.EnsureRolePlug, :ambassador
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: LincolnApiWeb.ApiAuthErrorHandler
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    plug LincolnApiWeb.ApiAuthPlug, otp_app: :lincoln_api
  end

  scope "/api/v1", LincolnApiWeb.API.V1, as: :api_v1 do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete, :show]
    post "/session/renew", SessionController, :renew
  end

  scope "/api/v1", LincolnApiWeb.API.V1, as: :api_v1 do
    pipe_through [:api, :protected, :ambassador]
    resources "/projects", ProjectController, only: [:create, :show, :update, :index]
    post "/my_projects", ProjectController, :list_by_id
  end
end
