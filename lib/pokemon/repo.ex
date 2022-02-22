defmodule Pokemon.Repo do
  use Ecto.Repo,
    otp_app: :pokemon_api,
    adapter: Ecto.Adapters.Postgres
end
