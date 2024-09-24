defmodule InfoSays.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      InfoSays.Cache,
      {Task.Supervisor, name: InfoSays.TaskSupervisor},
      # Starts a worker by calling: InfoSays.Worker.start_link(arg)
      # {InfoSays.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InfoSays.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
