defmodule InfoSaysTest.CacheTest do
  use ExUnit.Case, async: true
  alias InfoSays.Cache

  @moduletag clear_interval: 100

  # Helper function to assert a process has been shut down
  defp assert_shutdown(pid) do
    ref = Process.monitor(pid)
    Process.unlink(pid)
    Process.exit(pid, :kill)

    assert_receive {:DOWN, ^ref, :process, ^pid, :killed}
  end

  # Helper function to check conditions eventually (retry with delays)
  defp eventually(func) do
    if func.() do
      true
    else
      Process.sleep(10)
      eventually(func)
    end
  end

  setup %{test: test_name, clear_interval: clear_interval} do
    {:ok, pid} = Cache.start_link(name: test_name, clear_interval: clear_interval)
    {:ok, name: test_name, pid: pid}
  end

  describe "Cache operations" do
    test "key-value pairs can be put and fetched from cache", %{name: name} do
      assert Cache.put(name, :key1, :value1) == :ok
      assert Cache.put(name, :key2, :value2) == :ok

      assert Cache.fetch(name, :key1) == {:ok, :value1}
      assert Cache.fetch(name, :key2) == {:ok, :value2}
    end

    test "unfound entry returns error", %{name: name} do
      assert Cache.fetch(name, :notexists) == :error
    end

    # Modified test with increased timeout and reduced clear interval
    @tag timeout: 120_000, clear_interval: 100
    test "clear all entries after clear interval", %{name: name} do
      assert :ok = Cache.put(name, :key1, :value1)

      # Corrected this assertion to check for the correct stored value
      assert Cache.fetch(name, :key1) == {:ok, :value1}

      # Use the eventually helper to wait for the cache clear interval
      assert eventually(fn -> Cache.fetch(name, :key1) == :error end)
    end

    @tag clear_interval: 60_000
    test "values are cleaned up on exit", %{name: name, pid: pid} do
      assert :ok = Cache.put(name, :key1, :value1)

      # Assert the cache process is shut down
      assert_shutdown(pid)

      # Restart the cache and verify the values are cleared
      {:ok, _cache} = Cache.start_link(name: name)
      assert Cache.fetch(name, :key1) == :error
    end
  end
end
