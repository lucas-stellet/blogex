#!/bin/sh

mix deps.get;

mix compile;

mix ecto.setup; 

sleep 5 

mix phx.server
