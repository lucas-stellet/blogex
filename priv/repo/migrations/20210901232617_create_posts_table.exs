defmodule Blogex.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :content, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :uuid)

      timestamps()
    end
  end
end
