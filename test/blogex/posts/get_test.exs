defmodule Blogex.Posts.GetTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  alias Blogex.Post
  alias Blogex.Posts.Get

  import Blogex.Factory

  describe "by_id/1" do
    test "returns an ok tuple with an post wnen pass an ID" do
      user = insert(:user)
      post = insert(:post)

      response = Get.by_id(post.id)

      assert {:ok, %Post{post | user: %Blogex.User{user | password: nil}}} == response
    end

    test "returns an error tuple wnen pass an unknown post" do
      response = Get.by_id("c4d98b79-2228-41b7-8c75-6473a586d54d")

      expected_response = {:error, %{status: :not_found, result: "Post nao existe"}}

      assert expected_response == response
    end

    test "returns an error tuple wnen pass an invalid ID" do
      response = Get.by_id("123id")

      expected_response =
        {:error, %{status: :bad_request, result: "ID esta em um formato invalido"}}

      assert expected_response == response
    end
  end

  describe "by_term/1" do
    test "returns the post when pass an term that is present on post title or content" do
      insert(:user)
      %{id: id} = insert(:post)

      response = Get.by_term("Post")

      assert [%Post{id: ^id}] = response
    end

    test "returns all posts when an empty string is passed" do
      insert(:user)
      insert(:post)

      response = Get.by_term("")

      assert [%Post{}] = response
    end
  end

  describe "by_user_id/1" do
    test "returns an post with users_id" do
      user = insert(:user)
      post = insert(:post)

      response = Get.all()

      assert [%Post{post | user: %Blogex.User{user | password: nil}}] == response
    end

    test "returns an empty array when there is not post on database" do
      response = Get.all()

      expected_response = []

      assert expected_response == response
    end
  end

  describe "all/1" do
    test "returns an array with an post" do
      user = insert(:user)
      post = insert(:post)

      response = Get.all()

      assert [%Post{post | user: %Blogex.User{user | password: nil}}] == response
    end

    test "returns an empty array when there is not post on database" do
      response = Get.all()

      expected_response = []

      assert expected_response == response
    end
  end
end
