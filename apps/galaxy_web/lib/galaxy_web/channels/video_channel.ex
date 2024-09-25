defmodule GalaxyWeb.VideoChannel do
  use Phoenix.Channel

  alias Galaxy.Multimedia
  alias Galaxy.Accounts  # Update this if you're handling rendering differently

  def join("videos:" <> video_id, _params, socket) do
    {:ok, assign(socket, :video_id, video_id)}
  end

  def handle_in("new_annotation", %{"body" => _body, "comment" => _comment, "at" => _at} = params, socket) do
    current_user = socket.assigns[:current_user]

    if current_user do
      case Multimedia.annotate_video(current_user, socket.assigns.video_id, params) do
        {:ok, annotation} ->
          broadcast_annotation(socket, current_user, annotation)
          Task.start(fn -> compute_additional_info(annotation, socket) end)
          {:reply, :ok, socket}

        {:error, changeset} ->
          {:reply, {:error, %{errors: changeset}}, socket}
      end
    else
      {:reply, {:error, "User not authenticated"}, socket}
    end
  end

  defp broadcast_annotation(socket, user, annotation) do
    broadcast!(socket, "new_annotation", %{
      id: annotation.id,
      body: annotation.body,
      comment: annotation.comment,
      at: annotation.at,
      user: %{
        id: user.id,
        name: user.name,
        email: user.email  # You can adjust the fields you want to broadcast
      }
    })
  end

  defp compute_additional_info(annotation, socket) do
    results = InfoSays.compute(annotation.body, limit: 1, timeout: 10_000)

    for result <- results do
      backend_user = Accounts.get_user_by_email(result.backend.email)
      attrs = %{body: result.text, at: annotation.at}

      case Multimedia.annotate_video(backend_user, annotation.video_id, attrs) do
        {:ok, info_ann} ->
          broadcast_annotation(socket, backend_user, info_ann)

        {:error, _changeset} ->
          :ignore
      end
    end
  end
end
