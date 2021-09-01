defmodule Blogex.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Blogex.Repo

  alias Blogex.User

  def user_params_factory do
    %{
      email: "lucas@gmail.com",
      display_name: "Lucas Stellet",
      image: "https://link.com",
      password: "123senha"
    }
  end

  def user_factory do
    %User{
      email: "tony@gmail.com",
      display_name: "Tony Francione",
      image: "https://link.com",
      password: "123senha",
      id: "c4d98b79-2228-41b7-8c75-6473a586d54f"
    }
  end
end
