defmodule Blogex.Users.GetTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  alias Blogex.User
  alias Blogex.Users.Get

  import Blogex.Factory

  describe "by_id/1" do
    test "returns an ok tuple with an user wnen pass an ID" do
      user = insert(:user)

      response = Get.by_id("c4d98b79-2228-41b7-8c75-6473a586d54f")

      assert {:ok, %User{user | password: nil}} == response
    end

    test "returns an error tuple wnen pass an unknown user" do
      response = Get.by_id("c4d98b79-2228-41b7-8c75-6473a586d54d")

      expected_response = {:error, %{status: :not_found, result: "Usuario nao existe"}}

      assert expected_response == response
    end

    test "returns an error tuple wnen pass an invalid ID" do
      response = Get.by_id("123id")

      expected_response =
        {:error, %{status: :bad_request, result: "ID esta em um formato invalido"}}

      assert expected_response == response
    end
  end

  describe "by_email/1" do
    test "returns an ok tuple with an user wnen pass an email" do
      user = insert(:user)

      response = Get.by_email("tony@gmail.com")

      assert {:ok, %User{user | password: nil}} == response
    end

    test "returns an error tuple wnen pass email from an unknown user" do
      insert(:user)

      response = Get.by_email("lucas@gmail.com")

      expected_response = {:error, %{status: :not_found, result: "Usuario nao existe"}}

      assert expected_response == response
    end
  end

  describe "all/1" do
    test "returns an array with an user" do
      user = insert(:user)

      response = Get.all()

      assert [%User{user | password: nil}] == response
    end

    test "returns an empty array when there is not user on database" do
      response = Get.all()

      expected_response = []

      assert expected_response == response
    end
  end
end
