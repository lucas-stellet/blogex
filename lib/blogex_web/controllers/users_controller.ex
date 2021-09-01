defmodule BlogexWeb.UsersController do
  use BlogexWeb, :controller

  alias BlogexWeb.FallbackController

  action_fallback FallbackController

  alias Blogex.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Blogex.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
