defmodule Galaxy.Repo do
  use Ecto.Repo,
    otp_app: :galaxy,
    adapter: Ecto.Adapters.Postgres
end
