defmodule Galaxy.Repo.Migrations.AddVersionToUsers do
  use Ecto.Migration

  def change do
  alter table(:users) do
    add :version, :integer, default: 1
  end
  end
end
