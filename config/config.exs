# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :matchmaking_app,
  ecto_repos: [MatchmakingApp.Repo]

# Configures the endpoint
config :matchmaking_app, MatchmakingAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Wvd5BPPDUMS1nBc+VNLzHWEMrg7T9fa0iyrDUJ0AwUI0gSAetf+bTDHyYGjGVRoq",
  render_errors: [view: MatchmakingAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: MatchmakingApp.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
