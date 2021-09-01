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

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Blogex.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def index(conn, _params) do
    users = Blogex.get_all_users()

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = _user} <- Blogex.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
