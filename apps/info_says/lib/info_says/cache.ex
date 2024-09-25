defmodule InfoSays.Cache do
  use GenServer

  @clear_interval :timer.seconds(60)

  def put(name \\ __MODULE__, key, value) do
    true = :ets.insert(tab_name(name), {key, value})
    :ok
  end

  def fetch(name \\ __MODULE__, key) do
    case :ets.lookup(tab_name(name), key) do
      [{_, value}] -> {:ok, value}
      [] -> :error
    end
  rescue
    ArgumentError -> :error
  end

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, opts, name: opts[:name])
  end

  def init(opts) do
    state = %{
      interval: opts[:clear_interval] || @clear_interval,
      table: new_table(opts[:name]),
      timer: schedule_clear(@clear_interval)
    }
    {:ok, state}
  end

  def handle_info(:clear, state) do
    :ets.delete_all_objects(state.table)
    new_state = %{state | timer: schedule_clear(state.interval)}
    {:noreply, new_state}
  end

  defp new_table(name) do
    :ets.new(tab_name(name), [:set, :named_table, :public, read_concurrency: true, write_concurrency: true])
  end

  defp tab_name(name), do: :"#{name}_cache"

  defp schedule_clear(interval) do
    Process.send_after(self(), :clear, interval)
  end
end
