defmodule Blogex do
  @moduledoc false

  alias Blogex.Users.Create, as: UserCreate
  alias Blogex.Users.Get, as: UserGet
  alias Blogex.Users.Delete, as: UserDelete

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate get_user_by_id(params), to: UserGet, as: :by_id

  defdelegate get_all_users(), to: UserGet, as: :all

  defdelegate delete_user(id), to: UserDelete, as: :call
end
