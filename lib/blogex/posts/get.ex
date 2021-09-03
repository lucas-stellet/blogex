defmodule Blogex.Posts.Get do
  @moduledoc """
  Blogex Posts Get command
  """

  alias Blogex.{Post, Repo}
  alias Ecto.UUID

  import Ecto.Query, only: [from: 2]

  def by_id(id) do
    case UUID.cast(id) do
      :error ->
        {:error, %{status: :bad_request, result: "ID esta em um formato invalido"}}

      {:ok, uuid} ->
        get(uuid)
    end
  end

  def by_term(term) do
    query_search(term)
    |> Repo.all()
  end

  def all do
    Repo.all(Post)
    |> Repo.preload(:user)
  end

  defp get(id) do
    case Repo.get(Post, id) do
      nil ->
        {:error, %{status: :not_found, result: "Post nao existe"}}

      post ->
        {:ok, Repo.preload(post, :user)}
    end
  end

  defp query_search(term) do
    from p in Post, where: ilike(p.content, ^"%#{term}%") or ilike(p.title, ^"%#{term}%")
  end
end
