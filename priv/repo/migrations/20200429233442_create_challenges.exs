defmodule MatchmakingApp.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :prompt, :string
      add :response, :string

      timestamps()
    end

  end
end
