defmodule Blogex.User do
  @moduledoc """
  User's schema.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Blogex.Post

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields ~w(email display_name password image)a

  schema "users" do
    field :email, :string
    field :display_name, :string
    field :image, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :posts, Post

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields, message: "is required")
    |> validate_format(:email, ~r/\S+@\S+\.\S+/, message: "must be a valid email")
    |> validate_length(:password,
      min: 6,
      message: "length must be 6 characters long "
    )
    |> validate_length(:display_name,
      min: 8,
      message: "length must be 6 characters long "
    )
    |> update_change(:email, &String.downcase(&1))
    |> update_change(:email, &String.trim(&1))
    |> update_change(:display_name, &String.trim(&1))
    |> put_password_hash()
    |> unique_constraint(:email)
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      %{
        id: struct.id,
        displayName: struct.display_name,
        email: struct.email,
        image: struct.image
      }
      |> Jason.Encode.map(opts)
    end
  end
end
