defmodule Blogex.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string
      add :display_name, :string
      add :password_hash, :string
      add :image, :string

      timestamps()
    end
  end
end
