defmodule PokemonApi.PokemonClientTest do
  use ExUnit.Case, async: true
  alias PokemonApi.PokemonClient
  import Hammox

  setup :verify_on_exit!

  @valid_response %{
    body: %{
      "name" => "psyduck",
      "id" => "54"
    },
    status: 200
  }

  @invalid_response %{
    body: "Not found",
    status: 404
  }

  test "from_id/1 with valid input returns name" do
    ApiClientBehaviourMock
    |> expect(:pokemon_details, fn _pokemon -> {:ok, @valid_response} end)
    |> expect(:pokemon_details, fn _pokemon -> {:ok, @valid_response} end)

    assert PokemonClient.from_id(54) == "psyduck"
    assert PokemonClient.from_id("54") == "psyduck"
  end

  test "from_id/1 with id out of range returns not found" do
    ApiClientBehaviourMock
    |> expect(:pokemon_details, fn _pokemon -> {:ok, @invalid_response} end)
    |> expect(:pokemon_details, fn _pokemon -> {:ok, @invalid_response} end)

    assert PokemonClient.from_id(0) == "not found"
    assert PokemonClient.from_id("0") == "not found"
  end

  test "from_id/1 with invalid input type returns not found" do
    assert PokemonClient.from_id([]) == "not found"
    assert PokemonClient.from_id(%{}) == "not found"
    assert PokemonClient.from_id(:psyduck) == "not found"
  end

  test "from_name/1 with valid input returns id" do
    ApiClientBehaviourMock
    |> expect(:pokemon_details, fn _pokemon -> {:ok, @valid_response} end)

    assert PokemonClient.from_name("psyduck") == "54"
  end

  test "from_name/1 with invalid name returns not found" do
    ApiClientBehaviourMock
    |> expect(:pokemon_details, fn _pokemon -> {:ok, @invalid_response} end)

    assert PokemonClient.from_name("bubbles") == "not found"
  end

  test "from_name/1 with invalid input type returns not found" do
    assert PokemonClient.from_name("") == "not found"
    assert PokemonClient.from_name([]) == "not found"
    assert PokemonClient.from_name(%{}) == "not found"
    assert PokemonClient.from_name(:pikachu) == "not found"
  end
end
