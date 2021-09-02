defmodule BlogexWeb.PostsView do
  use BlogexWeb, :view

  alias Blogex.Post

  def render("create.json", %{post: post}), do: post

  def render("update.json", %{post: post}), do: post

  def render("show.json", %{post: %Post{} = post}), do: post

  def render("index.json", %{posts: posts}), do: posts
end
