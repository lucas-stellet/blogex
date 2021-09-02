defmodule Blogex.Users.DeleteTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  alias Blogex.User
  alias Blogex.Users.Delete

  import Blogex.Factory

  describe "call/1" do
    test "returns an ok tuple wnen deletes an user" do
      insert(:user)

      response = Delete.call("c4d98b79-2228-41b7-8c75-6473a586d54f")

      assert {:ok, %User{}} = response
    end

    test "returns an error tuple when try to delete an unknown user" do
      insert(:user)

      response = Delete.call("c4d98b79-2228-41b7-8c75-6473a586d54a")

      assert {:error, %{status: :not_found, result: "Usuario nao existe"}} = response
    end

    test "returns an error tuple when pass an invalid uuid " do
      insert(:user)

      response = Delete.call("123id")

      assert {:error, %{result: "ID esta em um formato invalido", status: :bad_request}} =
               response
    end
  end
end
