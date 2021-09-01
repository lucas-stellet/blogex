defmodule Blogex.Users.Get do
  @moduledoc false

  alias Blogex.{Repo, User}
  alias Ecto.UUID

  def by_id(id) do
    case UUID.cast(id) do
      :error ->
        {:error, %{status: :bad_request, result: "ID esta em um formato invalido"}}

      {:ok, uuid} ->
        get(uuid)
    end
  end

  def by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, %{status: :not_found, result: "Usuario nao existe"}}
      user -> {:ok, user}
    end
  end

  def all, do: Repo.all(User)

  defp get(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "Usuario nao existe"}}
      user -> {:ok, user}
    end
  end
end
