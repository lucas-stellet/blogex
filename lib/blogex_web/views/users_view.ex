defmodule BlogexWeb.UsersView do
  use BlogexWeb, :view

  alias Blogex.User

  def render("create.json", %{token: token}) do
    %{
      token: token
    }
  end

  def render("show.json", %{user: %User{} = user}), do: user

  def render("index.json", %{users: users}), do: users
end
