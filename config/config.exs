# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quoteboard,
  ecto_repos: [Quoteboard.Repo]

# Configures the endpoint
config :quoteboard, QuoteboardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fEtzrWN5K8C7uJOYKHBS403iY0klNEXlHoVX5cyIKG3pvjno1nUjiwEegDDx+d4q",
  render_errors: [view: QuoteboardWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Quoteboard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :quoteboard, Quoteboard.Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Quoteboard",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "Q/pRXuJQoZblGk4AIOHhMX0AkzuUpBS91hQVlO06PqrtRd/iAobc3CdBkMPDVYgc"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
