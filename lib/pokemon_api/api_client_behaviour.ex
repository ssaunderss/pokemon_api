defmodule PokemonApi.ApiClientBehaviour do
  @callback pokemon_details(String.t()) :: tuple()
end
