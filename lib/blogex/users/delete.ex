defmodule Blogex.Users.Delete do
  @moduledoc false

  alias Blogex.{Repo, User}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error ->
        {:error, %{status: :bad_request, result: "ID esta em um formato invalido"}}

      {:ok, uuid} ->
        delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "Usuario nao existe"}}
      user -> Repo.delete(user)
    end
  end
end
