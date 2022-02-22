import Config

config :pokemon_api, Pokemon.Repo,
  database: "pokemon_api_repo",
  username: "postgres",
  password: "postgres",
  hostname: "postgres_db"

config :pokemon_api, ecto_repos: [Pokemon.Repo]

import_config "#{config_env()}.exs"
