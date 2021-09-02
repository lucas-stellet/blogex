defmodule Blogex do
  @moduledoc false

  alias Blogex.Posts.Create, as: PostCreate
  alias Blogex.Posts.Get, as: PostGet
  alias Blogex.Posts.Update, as: PostUpdate
  alias Blogex.Posts.Delete, as: PostDelete
  alias Blogex.Users.Create, as: UserCreate
  alias Blogex.Users.Delete, as: UserDelete
  alias Blogex.Users.Get, as: UserGet

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate get_user_by_id(params), to: UserGet, as: :by_id

  defdelegate get_all_users(), to: UserGet, as: :all

  defdelegate delete_user(id), to: UserDelete, as: :call

  defdelegate create_post(params), to: PostCreate, as: :call

  defdelegate get_all_posts(), to: PostGet, as: :all

  defdelegate get_post_by_id(params), to: PostGet, as: :by_id

  defdelegate update_post(params), to: PostUpdate, as: :call

  defdelegate delete_post(params), to: PostDelete, as: :call

  defdelegate search_post(params), to: PostGet, as: :by_term
end
