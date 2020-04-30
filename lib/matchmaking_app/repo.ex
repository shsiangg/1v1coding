defmodule MatchmakingApp.Repo do
  use Ecto.Repo,
    otp_app: :matchmaking_app,
    adapter: Ecto.Adapters.Postgres
end
