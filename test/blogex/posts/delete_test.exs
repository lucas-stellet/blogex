defmodule Blogex.Posts.DeleteTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  alias Blogex.Post
  alias Blogex.User
  alias Blogex.Posts.Delete

  import Blogex.Factory

  describe "call/1" do
    test "returns an ok tuple with an post when successfully delete it" do
      %User{id: user_id} = insert(:user)
      %Post{id: id, title: title} = insert(:post)

      response = Delete.call(user_id: user_id, post_id: id)

      assert {:ok, %Post{title: ^title}} = response
    end
  end

  test "returns an error tuple when pass an invalid ID" do
    response = Delete.call(user_id: "123iduser", post_id: "123idpost")

    assert {:error, %{result: "ID esta em um formato invalido", status: :bad_request}} = response
  end
end
