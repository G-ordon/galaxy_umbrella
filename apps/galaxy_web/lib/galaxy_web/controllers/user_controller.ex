defmodule GalaxyWeb.UserController do
  use GalaxyWeb, :controller

  alias Galaxy.Accounts
  alias Galaxy.Accounts.User

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> GalaxyWeb.Auth.login(user)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: ~p"/users/#{user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Failed to create user. #{format_errors(changeset)}")
        render(conn, :new, changeset: changeset)
    end
  end

  defp format_errors(changeset) do
    Enum.map(changeset.errors, fn {field, {message, _}} ->
      "#{field} #{message}"
    end)
    |> Enum.join(", ")
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    case user do
      nil ->
        conn
        |> put_flash(:error, "User not found.")
        |> redirect(to: ~p"/users")

      user ->
        render(conn, "show.html", user: user)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    changeset = Galaxy.Accounts.change_user(user)
    render(conn, :edit, user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: ~p"/users/#{user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, user: user, changeset: changeset)
    end
  end


  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    case Accounts.delete_user(user) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User deleted successfully.")
        |> redirect(to: ~p"/users")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Failed to delete user.")
        |> redirect(to: ~p"/users")
    end
  end


end
