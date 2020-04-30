defmodule MatchmakingApp.Rooms.Challenge do
  use Ecto.Schema
  import Ecto.Changeset

  schema "challenges" do
    field :prompt, :string
    field :response, :string

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:prompt, :response])
    |> validate_required([:prompt, :response])
  end
end
