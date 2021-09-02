defmodule BlogexWeb.Auth.Guardian do
  @moduledoc false

  use Guardian, otp_app: :blogex

  alias Blogex.User
  alias Blogex.Users.Get

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    user =
      claims
      |> Map.get("sub")
      |> Get.by_id()

    {:ok, user}
  end

  def authenticate(%{"email" => email, "password" => password}) do
    case Get.by_email(email) do
      {:error, _} ->
        {:error, %{status: :bad_request, result: "Favor verificar as suas credenciais"}}

      {:ok, user} ->
        validate_password(user, password)
    end
  end

  defp validate_password(%User{password_hash: hash} = user, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(user)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token}
  end
end
