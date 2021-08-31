defmodule Blogex.User do
  @moduledoc """
  User's schema.
  """

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(email display_name password image)a

  schema "users" do
    field :email, :string
    field :display_name, :string
    field :image, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @spec changeset(map) :: %Ecto.Changeset{}
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/, message: "invalid format")
    |> validate_length(:password,
      min: 6,
      message: "Senha deve ter no minimo 6 caracteres. "
      message: "password has to be between 6 and 8 characters. "
    )
    |> update_change(:email, &String.downcase(&1))
    |> update_change(:email, &String.trim(&1))
    |> update_change(:display_name, &String.trim(&1))
    |> update_change(:display_name, &String.capitalize(&1))
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
