# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lincoln_api,
  ecto_repos: [LincolnApi.Repo]

config :lincoln_api, :pow,
  user: LincolnApi.Users.User,
  repo: LincolnApi.Repo,
  extensions: [PowInvitation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks

# Configures the endpoint
config :lincoln_api, LincolnApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ul5/BLLq4n96/1ujs0kAsw+EYcK/Rh3uWqKWB7CXba0xLREw6Nrs1eZ4/e0WPJVd",
  render_errors: [view: LincolnApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LincolnApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Compile-time configured key.

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
