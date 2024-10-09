defmodule GalaxyWeb.VideoChannelTest do
  use GalaxyWeb, :channel

  def join("videos:" <> _video_id, _params, socket) do
    {:ok, socket}
  end

  # Handle "new_annotation" event
  def handle_in("new_annotation", %{"body" => _body, "comment" => _comment, "at" => _at}, socket) do
    # Handle new_annotation logic here
    {:noreply, socket}
  end

  # Handle "ping" event
  def handle_in("ping", %{"hello" => hello}, socket) do
    {:reply, {:ok, %{"response" => "pong", "hello" => hello}}, socket}
  end

  # Handle "shout" event
  def handle_in("shout", %{"hello" => message}, socket) do
    broadcast(socket, "shout", %{"hello" => message})
    {:noreply, socket}
  end

  # Catch-all for unhandled events
  def handle_in(event, _payload, socket) do
    IO.puts("Unhandled event: #{event}")
    {:noreply, socket}
  end
end
