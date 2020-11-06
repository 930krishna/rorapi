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
      get "/attend_list/:event_id", Admin.EventusersController, :attend_list
      get "/cancelled_list/:event_id", Admin.EventusersController, :cancelled_list
    end

    # Topic of interests CRUD
    scope "/topic" do
      resources "/", Admin.TopicController, except: [:new, :edit]
    end

    # User Scope
    scope "/user" do
      get "/list", Admin.UsersController, :list
      post "/invite", Admin.UsersController, :invite
    end

  end

  # User API's related to with token
  scope "/api/v1", RorapiWeb do
    pipe_through :api_without_token
    # Event Endpoints
    scope "/event" do
      get "/list", V1.EventsController, :list
      get "/cancel/list", V1.EventsController, :cancel_list
      post "/add", V1.EventsController, :add
      post "/remove", V1.EventsController, :remove
    end
  end

end