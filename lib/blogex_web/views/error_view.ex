defmodule BlogexWeb.ErrorView do
  use BlogexWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{
        result: %Changeset{
          errors: [
            email: {"has already been taken", _}
          ]
        }
      }) do
    %{message: "Usuario ja registrado."}
  end

  def render("error.json", %{result: %Changeset{} = changeset}) do
    message = reduce_ecto_changeset_errors(translate_errors(changeset))

    %{message: message}
  end

  def render("error.json", %{result: result}) do
    %{message: result}
  end

  defp reduce_ecto_changeset_errors(errors) do
    for {key, [value]} <- errors do
      Atom.to_string(key) <> " " <> String.trim(value)
    end
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
