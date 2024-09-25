defmodule InfoSays.Counter do
  use GenServer

  # Client API

  def start_link(initial_val) do
    GenServer.start_link(__MODULE__, initial_val, name: __MODULE__)
  end

  def inc() do
    GenServer.cast(__MODULE__, :inc)
  end

  def dec() do
    GenServer.cast(__MODULE__, :dec)
  end

  def val(timeout \\ 5000) do
    GenServer.call(__MODULE__, :val, timeout)
  end

  # Server Callbacks

  def init(initial_val) do
    Process.send_after(self(), :tick, 1000)  # Schedule the first tick after 1 second
    {:ok, initial_val}
  end

  def handle_info(:tick, val) when val <= 0 do
    raise "boom!"
  end

  def handle_info(:tick, val) do
    IO.puts("tick #{val}")
    Process.send_after(self(), :tick, 1000)  # Schedule the next tick after 1 second
    {:noreply, val - 1}
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    {:reply, val, val}
  end
end
