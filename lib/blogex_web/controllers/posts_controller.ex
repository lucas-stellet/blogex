defmodule BlogexWeb.PostsController do
  use BlogexWeb, :controller

  alias BlogexWeb.Auth.Guardian
  alias BlogexWeb.FallbackController

  action_fallback FallbackController

  import Guardian.Plug, only: [current_resource: 1]

  alias Blogex.Post

  def create(conn, params) do
    with {:ok, %{id: user_id}} <- current_resource(conn),
         {:ok, post} <- Blogex.create_post(Map.put(params, "user_id", user_id)) do
      conn
      |> put_status(:created)
      |> render("create.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Post{} = post} <- Blogex.get_post_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", post: post)
    end
  end

  def index(conn, _params) do
    posts = Blogex.get_all_posts()

    conn
    |> put_status(:ok)
    |> render("index.json", posts: posts)
  end

  def delete(conn, params) do
    with {:ok, %{id: user_id}} <- current_resource(conn),
         {:ok, _post} <- Blogex.delete_post(user_id: user_id, post_id: Map.get(params, "id")) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, post} <- Blogex.update_post(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", post: post)
    end
  end

  def search(conn, %{"q" => term}) do
    posts = Blogex.search_post(term)

    # conn
    # |> put_status(:ok)
    # |> text("")

    conn
    |> put_status(:ok)
    |> render("index.json", posts: posts)
  end

  def search(conn, _) do
    message = %{message: "Nenhum parametro de busca enviado"}

    conn
    |> put_status(:bad_request)
    |> render("index.json", posts: message)
  end
end
