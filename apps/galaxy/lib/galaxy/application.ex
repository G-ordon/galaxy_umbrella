defmodule Galaxy.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      {Galaxy.Repo, []}, # Ensure you use the tuple format
      # Start the PubSub system
      {Phoenix.PubSub, name: Galaxy.PubSub},
      # Other children...
    ]

    opts = [strategy: :one_for_one, name: Galaxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
