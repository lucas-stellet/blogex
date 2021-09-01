defmodule BlogexWeb.UsersView do
  use BlogexWeb, :view

  alias Blogex.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      token: user.id
    }
  end
end
