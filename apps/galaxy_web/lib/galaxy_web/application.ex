defmodule GalaxyWeb.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
        # Add the Repo here
      GalaxyWeb.Telemetry,
      GalaxyWeb.Endpoint,
      GalaxyWeb.Presence
    ]

    opts = [strategy: :one_for_one, name: GalaxyWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    GalaxyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
