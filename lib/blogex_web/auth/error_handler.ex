defmodule BlogexWeb.Auth.ErrorHandler do
  @moduledoc """
  Error Handler for Blogex Auth
  """

  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  def auth_error(conn, {:invalid_token, _reason}, _opts) do
    response = %{message: "Token expirado ou invalido"}

    send_response(conn, response)
  end

  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    response = %{message: "Token nao encontrado"}

    send_response(conn, response)
  end

  defp send_response(conn, response) do
    conn
    |> put_resp_content_type("application/json; charset=utf-8")
    |> send_resp(:unauthorized, Poison.encode!(response))
    |> halt()
  end
end
