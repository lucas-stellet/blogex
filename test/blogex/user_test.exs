defmodule Blogex.UserTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  import Blogex.Factory

  alias Blogex.User
  alias Ecto.Changeset

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{display_name: "Lucas Stellet"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{
        display_name: "Lucas Stellet Pedreiro"
      }

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{display_name: "Lucas Stellet Pedreiro"}, valid?: true} =
               response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{display_name: "Lu", password: "123s"})

      response = User.changeset(params)

      expected_response = %{
        password: ["password length must be 6 characters long "],
        display_name: ["display_name length must be 6 characters long "]
      }

      assert errors_on(response) == expected_response
    end
  end
end
