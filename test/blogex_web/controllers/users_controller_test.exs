defmodule BlogexWeb.UsersControllerTest do
  @moduledoc false
  use BlogexWeb.ConnCase, async: true

  import Blogex.Factory

  describe "create/2" do
    test "creates the user when all params are valid and returns a token", %{conn: conn} do
      params = %{
        "email" => "lucas@gmail.com",
        "display_name" => "Lucas Stellet",
        "image" => "https://link.com",
        "password" => "123senha"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{"token" => _} = response
    end

    test "returns an validation error message when there is one", %{conn: conn} do
      params = %{
        "image" => "https://link.com",
        "password" => "123senha"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => ["display_name can't be blank", "email can't be blank"]} = response
    end
  end

  describe "delete/2" do
    test "when there is a user iwth the given id, deletes him", %{conn: conn} do
      insert(:user)
      id = "c4d98b79-2228-41b7-8c75-6473a586d54f"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
