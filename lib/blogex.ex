defmodule Blogex do
  @moduledoc false

  alias Blogex.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
  Handle the return of changeset creation.
  """

  def validate_changeset(%Ecto.Changeset{valid?: true} = changeset), do: Repo.insert(changeset)

  def validate_changeset(%Ecto.Changeset{valid?: false} = changeset), do: changeset
end
