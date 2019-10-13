defmodule LincolnApiWeb.Router do
  use LincolnApiWeb, :router

  pipeline :api do
    plug Corsica, origins: "*"
    plug :accepts, ["json"]
  end

  scope "/api", LincolnApiWeb do
    pipe_through :api
    resources "/projects", ProjectController


  end
end
