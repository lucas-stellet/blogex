defmodule Blogex do
  @moduledoc false

  alias Blogex.Repo

  @doc """
  Handle the return of changeset creation.
  """

  def validate_changeset(%Ecto.Changeset{valid?: true} = changeset), do: Repo.insert(changeset)

  def validate_changeset(%Ecto.Changeset{valid?: false} = changeset), do: changeset
end
