defmodule InfoSays.Wolfram do
  @moduledoc """
  A module for interacting with the Wolfram Alpha API.

  This module implements the InfoSays.Backend behavior and provides
  methods to compute queries using the Wolfram Alpha service.
  """

  import SweetXml
  alias InfoSays.Result

  @behaviour InfoSays.Backend
  @base "http://api.wolframalpha.com/v2/query"

  # Fetch the HTTP client from the application environment, defaulting to :httpc if not set
  @http Application.compile_env(:info_says, :wolfram)[:http_client] || :httpc

  @impl true
  def name, do: "Wolfram"

  @impl true
  def compute(query_str, _opts \\ []) do
    query_str
    |> fetch_xml()
    |> xpath(~x"/queryresult/pod[contains(@title, 'Result') or contains(@title, 'Definitions')]/subpod/plaintext/text()")
    |> build_results()
  end

  defp build_results(nil), do: []

  defp build_results(answer) do
    [%Result{backend: __MODULE__, score: 95, text: to_string(answer)}]
  end

  # Use the custom HTTP client to fetch the XML
  defp fetch_xml(query) do
    {:ok, {_, _, body}} = @http.request(String.to_charlist(url(query)))

    body
  end

  defp url(input) do
    "#{@base}?" <>
      URI.encode_query(appid: id(), input: input, format: "plaintext")
  end

  defp id do
    Application.fetch_env!(:info_says, :wolfram)[:app_id]
  end
end
