defmodule BlogexWeb.AuthView do
  use BlogexWeb, :view

  def render("login.json", %{token: token}) do
    %{
      token: token
    }
  end
end
