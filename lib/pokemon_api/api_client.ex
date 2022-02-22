defmodule PokemonApi.ApiClient do
  use Tesla

  @behaviour PokemonApi.ApiClientBehaviour

  plug(Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2/pokemon/")
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Timeout, timeout: 5_000)

  @type pokemon :: String.t()
  @type body :: %{
          status: integer(),
          body: %{
            name: String.t(),
            id: String.t()
          }
        }
  @type details_response :: {atom, body}
  @spec pokemon_details(pokemon) :: details_response
  @doc """
  Given a pokemon name or a pokemon id (string),
  returns the details of a pokemon in a tuple
  {status, response_body}:

  iex> pokemon_details("1")
  {:ok, %{abilities: [...]}}
  iex> pokemon_details("bulbasaur")
  {:ok, %{abilities: [...]}}
  """
  def pokemon_details(pokemon) do
    get(pokemon)
  end
end
