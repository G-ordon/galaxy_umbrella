defmodule InfoSaysTest do
  use ExUnit.Case
  doctest InfoSays

  test "greets the world" do
    assert InfoSays.hello() == :world
  end
end
