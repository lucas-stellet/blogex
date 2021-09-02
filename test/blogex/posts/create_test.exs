defmodule Blogex.Posts.CreateTest do
  @moduledoc false

  use Blogex.DataCase, async: true

  alias Blogex.Post
  alias Blogex.Posts.Create

  import Blogex.Factory

  describe "call/1" do
    test "returns an ok tuple with an post wnen pass valid parameters" do
      insert(:user)

      post_params = %{
        content: "Post content",
        title: "Post title",
        user_id: "c4d98b79-2228-41b7-8c75-6473a586d54f"
      }

      response = Create.call(post_params)

      assert {:ok,
              %Post{user_id: "c4d98b79-2228-41b7-8c75-6473a586d54f", content: "Post content"}} =
               response
    end

    test "returns an error when there is not a required param" do
      insert(:user)

      post_params = %{
        content: "Post content",
        user_id: "c4d98b79-2228-41b7-8c75-6473a586d54f"
      }

      expected_response = %{title: ["is required"]}

      response = Create.call(post_params)

      assert {:error, %{status: :bad_request, result: changeset}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
