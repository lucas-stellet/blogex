defmodule BlogexWeb.FallbackController do
  @moduledoc """
  Handle errors in the BlogexWeb application
  """

  use BlogexWeb, :controller

  alias BlogexWeb.ErrorView

  def call(conn, {:error, %{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end

  def call(conn, {:error, %{status: status}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json")
  end
end
