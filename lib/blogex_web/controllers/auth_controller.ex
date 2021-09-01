defmodule BlogexWeb.AuthController do
  use BlogexWeb, :controller

  action_fallback BlogexWeb.FallbackController

  alias BlogexWeb.Auth.Guardian

  def login(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end
end
