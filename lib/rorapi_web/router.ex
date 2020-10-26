defmodule RorapiWeb.Router do
  use RorapiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_without_token do
    plug :accepts, ["json"]
    plug RorapiWeb.Plugs.PublicIp
  end

  scope "/", RorapiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # API's related to without token
  scope "/api", RorapiWeb do
    pipe_through :api_without_token

    get "/", PageController, :index

    # Admin Login
    post "/admin/login", Main.LoginController, :admin_login

    # User Login
    post "/v1/login", Main.LoginController, :user_login
  end

  # Admin API's related to with token
  scope "/api/admin", RorapiWeb do
    pipe_through :api_without_token

    # Event CRUD
    scope "/event" do
      resources "/", Admin.EventsController, except: [:new, :edit]
    end
  end

  # User API's related to with token
  scope "/api/v1", RorapiWeb do
    pipe_through :api_without_token

    # Event CRUD
    scope "/event" do
      get "/list", User.EventController, :list
      post "/add", User.EventController, :add
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RorapiWeb do
  #   pipe_through :api
  # end
end
