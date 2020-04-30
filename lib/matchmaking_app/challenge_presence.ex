defmodule MatchmakingApp.ChallengePresence do
  use Phoenix.Presence, otp_app: :matchmaking_app,
                        pubsub_server: MatchmakingApp.PubSub

 alias MatchmakingApp.ChallengePresence
  def do_user_update(socket, user, %{typing: typing}) do
    ChallengePresence.update(socket, user.id, %{
      typing: typing,
      username: user.username,
      user_id: user.id,
    })
  end

  def track_user_join(socket, user) do
    ChallengePresence.track(socket, user.id, %{
      typing: false,
      username: user.username,
      user_id: user.id
    })
  end
end