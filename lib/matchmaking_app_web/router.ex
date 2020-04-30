defmodule MatchmakingAppWeb.Router do
  use MatchmakingAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MatchmakingAppWeb.Auth

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MatchmakingAppWeb do
    pipe_through :browser
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MatchmakingAppWeb do
  #   pipe_through :api
  # end
end
