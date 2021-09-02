defmodule Blogex.Posts.Create do
  @moduledoc """
  Blogex Posts Create command
  """

  alias Blogex.{Post, Repo}

  def call(params) do
    params
    |> Post.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Post{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, %{status: :bad_request, result: result}}
  end
end
