defmodule BlogexWeb.UsersViewTest do
  use BlogexWeb.ConnCase, async: true

  import Phoenix.View
  import Blogex.Factory

  alias BlogexWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{token: _token} = response
  end
end
