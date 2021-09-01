defmodule BlogexWeb.WelcomeController do
  use BlogexWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("Welcome to Blogex API!")
  end
end
