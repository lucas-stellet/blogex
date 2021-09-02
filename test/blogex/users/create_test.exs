defmodule Blogex.Users.CreateTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  alias Blogex.User
  alias Blogex.Users.Create

  import Blogex.Factory

  describe "call/1" do
    test "returns user wnen all params are valid" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok,
              %User{
                id: _id,
                display_name: "Lucas Stellet",
                email: "lucas@gmail.com",
                image: "https://link.com"
              }} = response
    end

    test "returns an error when there is an invalid param" do
      params = build(:user_params, %{display_name: "Luc", password: "123s"})

      response = Create.call(params)

      expected_response = %{
        display_name: ["display_name length must be 6 characters long "],
        password: ["password length must be 6 characters long "]
      }

      assert {:error, %{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
