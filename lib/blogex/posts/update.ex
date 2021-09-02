defmodule Blogex.Posts.Update do
  @moduledoc """
  Blogex Posts Update command
  """

  alias Blogex.{Post, Repo}
  alias Ecto.UUID

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, "ID esta em um formato invalido"}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case fetch_post(uuid) do
      nil -> {:error, "Post nao encontrado."}
      post -> update_post(create_changeset(post, params))
    end
  end

  defp fetch_post(uuid), do: Repo.get(Post, uuid)

  defp create_changeset(post, params) do
    post
    |> Post.changeset(params)
  end

  defp update_post(changeset) do
    case Repo.update(changeset) do
      {:ok, post} -> {:ok, post}
      {:error, changeset} -> {:error, changeset}
    end
  end
end
