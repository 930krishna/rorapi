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

    # Admin Login
    post "/admin/login", LoginController, :admin_login

    # User Login
    post "/v1/login", LoginController, :user_login

    # User Register
    post "/v1/register", RegisterController, :register
  end

  # Admin API's related to with token
  scope "/api/admin", RorapiWeb do
    pipe_through :api_without_token
    # Event CRUD
    scope "/event" do
      resources "/", Admin.EventsController, except: [:new, :edit]
    end
    # User List
    get "/user/list", Admin.UsersController, :list
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

end