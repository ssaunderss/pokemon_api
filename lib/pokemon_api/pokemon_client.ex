defmodule PokemonApi.PokemonClient do
  @doc """
  Based on context, calls live / mock clients
  """
  def api_client, do: Application.get_env(:pokemon_api, :api_client)

  @doc """
  Given a pokemon_id that is either a valid integer
  or string representation of the id, return the name
  of a given pokemon
  """
  @type pokemon_id :: integer | String.t()
  @spec from_id(pokemon_id) :: String.t()
  def from_id(pokemon_id) when is_integer(pokemon_id) do
    id_string = Integer.to_string(pokemon_id)
    fetch_details(id_string, :name)
  end

  def from_id(pokemon_id) when is_binary(pokemon_id) and pokemon_id != "" do
    fetch_details(pokemon_id, :name)
  end

  def from_id(_pokemon_id) do
    "not found"
  end

  @doc """
  Given a non-empty string that is the name of a pokemon, returns the
  string id of the pokemon from the Poke API
  """
  @type pokemon_name :: String.t()
  @spec from_name(pokemon_name) :: String.t()
  def from_name(pokemon_name) when is_binary(pokemon_name) and pokemon_name != "" do
    fetch_details(pokemon_name, :id)
  end

  def from_name(_pokemon_name) do
    "not found"
  end

  @type string_pokemon :: String.t()
  @type switch_to :: atom()
  @spec fetch_details(string_pokemon, switch_to) :: String.t()
  def fetch_details(string_pokemon, switch_to) do
    {:ok, response} = api_client().pokemon_details(string_pokemon)
    converter = {switch_to, response.status}

    case converter do
      {:name, 200} -> response.body["name"]
      {:id, 200} -> response.body["id"]
      _ -> "not found"
    end
  end
end
