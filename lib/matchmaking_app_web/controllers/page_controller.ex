defmodule MatchmakingAppWeb.PageController do
  use MatchmakingAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
