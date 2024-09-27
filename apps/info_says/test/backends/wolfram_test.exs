defmodule InfoSays.Backends.WolframTest do
  use ExUnit.Case, async: true
  alias InfoSays.Result

  # Assuming you've set up a mock HTTP client in your configuration for tests

  setup do
    # Optionally set up any necessary state or dependencies here
    :ok
  end

  test "makes request, reports results, then terminates" do
    # Compute the result for "1 + 1" using the Wolfram backend
    [actual] = InfoSays.compute("1 + 1", backends: [InfoSays.Wolfram])

    assert %Result{backend: InfoSays.Wolfram, text: "2"} = actual
  end

  test "no query results reports an empty list" do
    # Ensure that computing a query that yields no results returns an empty list
    results = InfoSays.compute("none", backends: [InfoSays.Wolfram])

    assert results == []
  end
end
