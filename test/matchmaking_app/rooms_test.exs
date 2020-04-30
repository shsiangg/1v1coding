defmodule MatchmakingApp.RoomsTest do
  use MatchmakingApp.DataCase

  alias MatchmakingApp.Rooms

  describe "challenges" do
    alias MatchmakingApp.Rooms.Challenge

    @valid_attrs %{prompt: "some prompt", response: "some response"}
    @update_attrs %{prompt: "some updated prompt", response: "some updated response"}
    @invalid_attrs %{prompt: nil, response: nil}

    def challenge_fixture(attrs \\ %{}) do
      {:ok, challenge} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_challenge()

      challenge
    end

    test "list_challenges/0 returns all challenges" do
      challenge = challenge_fixture()
      assert Rooms.list_challenges() == [challenge]
    end

    test "get_challenge!/1 returns the challenge with given id" do
      challenge = challenge_fixture()
      assert Rooms.get_challenge!(challenge.id) == challenge
    end

    test "create_challenge/1 with valid data creates a challenge" do
      assert {:ok, %Challenge{} = challenge} = Rooms.create_challenge(@valid_attrs)
      assert challenge.prompt == "some prompt"
      assert challenge.response == "some response"
    end

    test "create_challenge/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_challenge(@invalid_attrs)
    end

    test "update_challenge/2 with valid data updates the challenge" do
      challenge = challenge_fixture()
      assert {:ok, %Challenge{} = challenge} = Rooms.update_challenge(challenge, @update_attrs)
      assert challenge.prompt == "some updated prompt"
      assert challenge.response == "some updated response"
    end

    test "update_challenge/2 with invalid data returns error changeset" do
      challenge = challenge_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_challenge(challenge, @invalid_attrs)
      assert challenge == Rooms.get_challenge!(challenge.id)
    end

    test "delete_challenge/1 deletes the challenge" do
      challenge = challenge_fixture()
      assert {:ok, %Challenge{}} = Rooms.delete_challenge(challenge)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_challenge!(challenge.id) end
    end

    test "change_challenge/1 returns a challenge changeset" do
      challenge = challenge_fixture()
      assert %Ecto.Changeset{} = Rooms.change_challenge(challenge)
    end
  end
end
