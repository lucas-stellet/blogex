defmodule BlogexWeb.Router do
  use BlogexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BlogexWeb.Auth.Pipeline
  end

  pipeline :bodyguard do
    plug BlogexWeb.BodyGuard
  end

  scope "/api", BlogexWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    post "/user", UsersController, :create

    post "/login", AuthController, :login
  end

  scope "/api", BlogexWeb do
    pipe_through [:api, :auth, :bodyguard]

    get "/user", UsersController, :index
    get "/user/:id", UsersController, :show
    delete "/user/me", UsersController, :delete

    post "/post", PostsController, :create
    get "/post", PostsController, :index
    get "/post/search", PostsController, :search
    get "/post/:id", PostsController, :show
    put "/post/:id", PostsController, :update
    delete "/post/:id", PostsController, :delete
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: BlogexWeb.Telemetry
    end
  end
end
