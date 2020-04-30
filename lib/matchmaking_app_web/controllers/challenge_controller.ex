defmodule MatchmakingAppWeb.ChallengeController do
  use MatchmakingAppWeb, :controller

  alias MatchmakingApp.Rooms
  alias MatchmakingApp.Rooms.Challenge

  def index(conn, _params) do
    challenges = Rooms.list_challenges()
    render(conn, "index.html", challenges: challenges)
  end

  def new(conn, _params) do
    changeset = Rooms.change_challenge(%Challenge{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"challenge" => challenge_params}) do
    case Rooms.create_challenge(challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge created successfully.")
        |> redirect(to: Routes.challenge_path(conn, :show, challenge))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    challenge = Rooms.get_challenge!(id)
    render(conn, "show.html", challenge: challenge)
  end

  def edit(conn, %{"id" => id}) do
    challenge = Rooms.get_challenge!(id)
    changeset = Rooms.change_challenge(challenge)
    render(conn, "edit.html", challenge: challenge, changeset: changeset)
  end

  def update(conn, %{"id" => id, "challenge" => challenge_params}) do
    challenge = Rooms.get_challenge!(id)

    case Rooms.update_challenge(challenge, challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge updated successfully.")
        |> redirect(to: Routes.challenge_path(conn, :show, challenge))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", challenge: challenge, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    challenge = Rooms.get_challenge!(id)
    {:ok, _challenge} = Rooms.delete_challenge(challenge)

    conn
    |> put_flash(:info, "Challenge deleted successfully.")
    |> redirect(to: Routes.challenge_path(conn, :index))
  end
end
