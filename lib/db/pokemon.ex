defmodule PokemonApi.DB.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  Schema definition for a Pokemon Ecto object.
  All other linked fields from the /pokemon endpoint
  that are not in this schema (e.g. abilities) would
  use the id of the pokemon as a foreign key and be
  located in a seperate table
  """

  @fields [
    :id,
    :name,
    :base_experience,
    :height,
    :is_default,
    :order,
    :weight,
    :location_area_encounters,
    :species_id
  ]

  @primary_key {:id, :integer, autogenerate: false}
  schema "pokemon" do
    field(:name, :string)
    field(:base_experience, :integer)
    field(:height, :integer)
    field(:is_default, :boolean)
    field(:order, :integer)
    field(:weight, :integer)
    field(:location_area_encounters, :string)
    field(:species_id, :integer)
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
