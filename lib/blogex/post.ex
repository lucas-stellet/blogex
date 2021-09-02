defmodule Blogex.Post do
  @moduledoc """
  Post's schema.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Blogex.User

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:title, :content, :user_id]
  @required_fields [:title, :content]

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :user, User, foreign_key: :user_id, type: :binary_id

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields, message: "is required")
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{user: %User{} = user} = struct, opts) do
      %{
        content: struct.content,
        title: struct.title,
        user: user,
        id: struct.id
      }
      |> Jason.Encode.map(opts)
    end

    def encode(struct, opts) do
      %{
        userId: struct.user_id,
        content: struct.content,
        title: struct.title,
        id: struct.id
      }
      |> Jason.Encode.map(opts)
    end
  end
end
