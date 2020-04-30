defmodule MatchmakingAppWeb.ChallengeChannel do
  use MatchmakingAppWeb, :channel
  alias MatchmakingApp.ChallengePresence
  alias MatchmakingApp.Rooms 


  # room:searching
  # room:lobby
  # room:id

  # can we get a list of all in searching?
  def join("challenge:" <> challenge_id, _params, socket) do
    challenge = Rooms.get_challenge(challenge_id)
    send(self(), {:after_join, challenge})
    socket    = assign(socket, :challenge, challenge)
    response  = %{challenge: challenge}
    {:ok, response, socket}
  end

  def handle_info({:after_join, challenge}, socket) do
    ChallengePresence.track_user_join(socket, socket.assigns.current_user)
    push socket, "presence_state", ChallengePresence.list(socket)
    {:noreply, socket}
  end

  def handle_in("response:update", %{"response" => codeResponse}, socket) do
    case Challenge.update(socket.assigns.challenge, codeResponse) do
      {:ok, challenge} ->
        ChallengePresence.do_user_update(socket, socket.assigns.user_id, %{typing: true})
        broadcast! socket, "response:updated", %{challenge: challenge}
        {:noreply, socket}
      {:error, changeset} ->
        {:reply, {:error, %{error: "Error updating challenge"}}, socket}
    end
  end

  def handle_in("current_participant_typing:remove", _, socket) do
    ChallengePresence.do_user_update(socket, socket.assigns.current_user, %{typing: false})
    push socket, "presence_state", ChallengePresence.list(socket)
    {:noreply, socket}
  end

end