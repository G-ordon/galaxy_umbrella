defmodule GalaxyWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import GalaxyWeb.ChannelCase

      # The default endpoint for testing
      @endpoint GalaxyWeb.Endpoint
    end
  end

  setup _tags do
    :ok
  end
end
