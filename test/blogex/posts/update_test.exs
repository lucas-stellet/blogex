defmodule Blogex.Posts.UpdateTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  alias Blogex.{Post, User}
  alias Blogex.Posts.Update

  import Blogex.Factory

  describe "call/1" do
    test "returns an ok tuple with an post when successfully updated it" do
      %User{id: user_id} = insert(:user)
      %Post{id: id} = insert(:post)

      response = Update.call(%{"title" => "Updated post title", "id" => id}, user_id)

      assert {:ok, %Post{title: "Updated post title"}} = response
    end
  end

  test "returns an error tuple when pass an invalid ID" do
    insert(:user)
    %Post{id: id} = insert(:post)

    response = Update.call(%{"title" => "Updated post title", "id" => id}, user_id: "123iduser")

    assert {:error, %{result: "ID esta em um formato invalido", status: :bad_request}} = response
  end
end
