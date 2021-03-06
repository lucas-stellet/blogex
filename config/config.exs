# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blogex,
  ecto_repos: [Blogex.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :blogex, BlogexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v6DqQSv1Jmk6kBM8Sub9PMspageID11MBywOjQjNqJcyMJhyeBlwihX3r9KUikuO",
  render_errors: [view: BlogexWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Blogex.PubSub,
  live_view: [signing_salt: "stslcf/0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :blogex, BlogexWeb.Auth.Guardian,
  issuer: "blogex",
  ttl: {30, :minutes},
  secret_key:
    System.get_env(
      "GUARDIAN_SECRET",
      "UaE9J9jqkLcBcV46r+WihLKwNea5HLz+X2eo3ij4CYBuelnEQo3eXi1QEIp4PzC2"
    )

config :blogex, BlogexWeb.Auth.Pipeline,
  module: BlogexWeb.Auth.Guardian,
  error_handler: BlogexWeb.Auth.ErrorHandler

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
