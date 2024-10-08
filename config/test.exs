import Config

config :pbkdf2_elixir, :rounds, 1
# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :galaxy, Galaxy.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "galaxy_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :galaxy_web, GalaxyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Qsct38bvO/EzV4S3mWcaGTbF643DYstQsHEPMyJ5Rk+KUskxutl98pMNoc0hn/kW",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails
config :galaxy, Galaxy.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
  #update the test configuration tou use our stubbed client
config :info_says, :wolfram,
      app_id: "G2WE65-8KPYHUJH85",
      http_client: InfoSays.Test.HTTPClient

config :info_says, :wolfram,
     http_client: InfoSays.Test.HTTPClient
