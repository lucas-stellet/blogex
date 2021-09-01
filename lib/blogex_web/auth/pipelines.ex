defmodule BlogexWeb.Auth.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline, otp_app: :blogex

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
