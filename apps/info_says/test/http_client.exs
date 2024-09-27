defmodule InfoSays.Test.HTTPClient do
  @moduledoc """
  A mock HTTP client for testing purposes, simulating responses from the Wolfram API.
  """

  # Load the XML fixture from the test fixtures directory
  @wolfram_xml File.read!("test/fixtures/wolfram.xml")

  @doc """
  Simulates an HTTP request to the given URL.

  If the URL contains "1+%2B+1", it returns a mocked response with the
  contents of `@wolfram_xml`. For any other URL, it returns an empty
  `<queryresult></queryresult>`.

  ## Examples

      iex> InfoSays.Test.HTTPClient.request("http://example.com?query=1+%2B+1")
      {:ok, {[], [], "<xml content...>"}}

      iex> InfoSays.Test.HTTPClient.request("http://example.com")
      {:ok, {[], [], "<queryresult></queryresult>"}}
  """
  @spec request(String.t()) :: {:ok, {any, any, String.t()}} | {:error, String.t()}
  def request(url) do
    url = to_string(url)

    cond do
      String.contains?(url, "1+%2B+1") -> {:ok, {[], [], @wolfram_xml}}
      true -> {:ok, {[], [], "<queryresult></queryresult>"}}
    end
  end
end
