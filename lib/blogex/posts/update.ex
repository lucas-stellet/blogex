defmodule Blogex.Posts.Update do
  @moduledoc """
  Blogex Posts Update command
  """

  alias Blogex.{Post, Repo}
  alias Ecto.UUID

  def call(%{"id" => post_id} = params, user_id) do
    case validate_uuids?([user_id, post_id]) do
      true ->
        update(params, user_id)

      false ->
        {:error, %{status: :bad_request, result: "ID esta em um formato invalido"}}
    end
  end

  defp update(%{"id" => post_id} = params, user_id) do
    IO.inspect(params)

    with {:ok, post} <- fetch_post(post_id),
         {:ok, _deletable_post} <- user_own_post(post, user_id) do
      update_post(create_changeset(post, params))
    end
  end

  defp fetch_post(post_id) do
    case Repo.get(Post, post_id) do
      nil -> {:error, %{status: :not_found, result: "Post nao encontrado."}}
      post -> {:ok, post}
    end
  end

  defp create_changeset(post, params) do
    post
    |> Post.changeset(params)
  end

  defp user_own_post(%{user_id: post_user_id} = post, user_id) do
    IO.inspect(post)
    IO.inspect(user_id)

    cond do
      user_id == post_user_id ->
        {:ok, post}

      user_id != post_user_id ->
        {:error, %{status: :unauthorized}}
    end
  end

  defp update_post(changeset) do
    case Repo.update(changeset) do
      {:ok, post} -> {:ok, post}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def validate_uuids?(uuids) do
    uuid_lists =
      for uuid <- uuids do
        case UUID.cast(uuid) do
          :error -> false
          {:ok, _uuid} -> true
        end
      end

    Enum.all?(uuid_lists)
  end
end
