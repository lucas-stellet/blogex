defmodule BlogexWeb.BodyGuard do
  @moduledoc false

  import Plug.Conn

  import Guardian.Plug, only: [current_resource: 1]

  def init(options), do: options

  def call(conn, _opts) do
    case user_exist?(current_resource(conn)) do
      true ->
        conn

      false ->
        conn
        |> put_resp_content_type("application/json; charset=utf-8")
        |> send_resp(403, Poison.encode!(%{"message" => "Token expirado ou invalido"}))
        |> halt()
    end
  end

  defp user_exist?({:ok, _}), do: true

  defp user_exist?({:error, _}), do: false
end
