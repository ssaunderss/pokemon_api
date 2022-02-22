#!/bin/bash

# install hex and rebar
mix local.hex --force
mix local.rebar --force

# fetch dependencies
mix deps.get

# ecto
mix ecto.create
mix ecto.migrate