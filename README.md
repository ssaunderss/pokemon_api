# PokemonApi

A simple pokemon API for retrieving a pokemon's name / id

## Getting the project running
For this project, I developed in a dev container using the `Remote - Containers` plugin on VSCode.

Once you open this directory within VSCode with the `Remote - Containers` plugin installed, you should be able to click on the Containers plugin in the bottom left-hand portion of the editor and choose the option "Open in Container" - if you receive a prompt to choose which directory to open, just make sure that it's the root of the project.

To get this running there is a `Dockerfile` to define the Elixir development (in `.devcontainer`), a `docker-compose.yml` to add a postgres service for ecto / the dev environment, a `devcontainer.json` which outlines which plugins to use, container startup logic, etc. and a `setup.sh` file which will execute once the container is created to start Elixir boilerplate for us. 

The dev container will set up a full Elixir development environment that has all necessary dependencies, starts our extra services (postgres) and runs migrations, etc. Once it's created you'll be able to directly interact with the container from a shell prompt within VSCode.

## API Design 

The `ApiClient` communicates with [pokeapi](https://pokeapi.co/) and is located in `lib/pokemon_api/api_client.ex`. This client uses the Tesla package to communicate with pokeapi's `pokemon` endpoint. This endpoint accepts a pokemon name or a pokemon id and will return detailed information on that pokemon. I type-spec'd the client's functionality and added a `Behaviour` for the `pokemon_details/1` callback so that this client could be mocked and leverage the `Hammox` package for testing (more below).

The `PokemonClient` (`lib/pokemon_api/pokemon_client.ex`) directly interacts with `ApiClient` to grab information on pokemon and processes it so a user is either returned a pokemon name or an id. There are 2 main functions `from_id/1` and `from_name/1` which intake a pokemon's name or id, respectively. I created a few variations of each function that pattern match off of input and use guards to ensure that valid / well-formatted requests are being passed to the `pokemon` endpoint. `from_id/1` can be given a string representation of an integer or an integer and if it is valid it will be passed to `fetch_details/2` which in turn passes the request to `ApiClient` and handles the result (whether a pokemon id should return a pokemon name, or vice versa). `from_name/1` follows the same path, but it first checks that a valid string has been passed to itself (specifically that the string is non-empty because it changes the behavior of the endpoint). All of these functions are also type-spec'd so we can ensure that contracts persist in testing. 

## Pokemon Table
I defined a table for pokemon which includes their core details in `lib/db/pokemon.ex`. Although this data doesn't encapsulate all data within a pokemon payload, other tables could be created to capture that data and then be linked using the pokemon table's `id` as a foreign key.

## Testing
All functions within the API are typespec'd which creates a "contract" of what is to be passed into the function and what should be returned. Since a behaviour was defined outlining how a callback from the `ApiClient` should be handled, this allows us to use a mock of `ApiClient` in the `test` environment. Tying this all together, `Hammox` is used so that we can create / test a mock of the client behaviour and also check that all of our typespec'd contracts are working as expected.

There is also an automated testing workflow for this repo which can be found in `.github/workflows/tests.yaml`.

