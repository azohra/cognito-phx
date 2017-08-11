# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :cognito_phx, CognitoPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+EZg6smL9Kye8ncHIVIxOi7UsG822ZXr7DbV16IDCXLS/GqjeoNfoXABVOht4PVt",
  render_errors: [view: CognitoPhxWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CognitoPhx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :aws,
  key: System.get_env("AWS_ACCESS_KEY_ID"),
  secret: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: System.get_env("AWS_REGION") || "us-east-1",
  client_id: System.get_env("AWS_AZOHRA_CLIENT_ID") || "3ilgtakk6l650do644aqq18210",
  user_pool_id: System.get_env("AWS_AZOHRA_USER_POOL_ID") || "us-east-1_Dy9nsBdBM"
  # bucket: "florin-test"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
