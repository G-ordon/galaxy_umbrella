defmodule InfoSaysTest do
  use ExUnit.Case, async: true
  alias InfoSays.Result

  defmodule TestBackend do
    def name(), do: "Wolfram"

    def compute("result", _opts) do
      [%Result{backend: __MODULE__, text: "result"}]
    end

    def compute("none", _opts) do
      []
    end

    def compute("timeout", _opts) do
      Process.sleep(:infinity)
    end

    def compute("boom", _opts) do
      raise "boom!"
    end
  end

  describe "compute/2" do
    test "with backend results" do
      assert [%Result{backend: TestBackend, text: "result"}] =
               InfoSays.compute("result", backends: [TestBackend])
    end

    test "with no backend results" do
      assert [] = InfoSays.compute("none", backends: [TestBackend])
    end

    test "with timeout returns no results" do
      results = InfoSays.compute("timeout", backends: [TestBackend], timeout: 10)
      assert results == []
    end

    @tag :capture_log
    test "discard backend errors" do
      assert InfoSays.compute("boom", backends: [TestBackend]) == []
    end
  end
end
