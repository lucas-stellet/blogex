defmodule Blogex.Posts.Delete do
  @moduledoc false

  alias Blogex.{Repo}
  alias Ecto.UUID

  def call(user_id: user_id, post_id: post_id) do
    case validate_uuids?([user_id, post_id]) do
      true ->
        delete([user_id, post_id])

      false ->
        {:error, %{status: :bad_request, result: "ID esta em um formato invalido"}}
    end
  end

  defp delete([user_id, post_id]) do
    with {:ok, post} <- Blogex.get_post_by_id(post_id),
         {:ok, _deletable_post} <- user_own_post(user_id, post) do
      Repo.delete(post)
    end
  end

  defp user_own_post(user_id, %{user_id: post_user_id} = post) do
    cond do
      user_id == post_user_id ->
        {:ok, post}

      user_id != post_user_id ->
        {:error, %{status: :unauthorized}}
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
