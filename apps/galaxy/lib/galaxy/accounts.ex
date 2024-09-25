defmodule Galaxy.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Galaxy.Repo
  alias Galaxy.Accounts.User
  alias Pbkdf2

    # Define your token salt here

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user by email.
  """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Gets a single user by ID.

  Raises `Ecto.NoResultsError` if the User does not exist.
  """
  def get_user(id) do
    Repo.get!(User, id)
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Creates a registration changeset for a new user with password hashing.
  """
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Authenticates a user by email and password.
  """
  def authenticate_by_email_and_pass(email, given_password) do
    user = Repo.get_by(User, email: email)

    case user do
      nil -> {:error, :not_found}
      %User{password_hash: nil} -> {:error, :unauthorized}
      %User{password_hash: password_hash} ->
        if Pbkdf2.verify_pass(given_password, password_hash) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end


end
