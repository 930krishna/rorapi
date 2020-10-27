defmodule RorapiWeb.Admin.EventusersController do
  use RorapiWeb, :controller

  alias RorapiWeb.Admin.UserView
  alias Rorapi.Models.UserRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for list of user who have attend event.
  """
  def attend_list(conn, params) do
    with {:ok, value} <- UserRepo.attend_list(params) do
      conn
      |> put_status(:ok)
      |> put_view(UserView)
      |> render("user.json", key: value)
    end
  end

  @doc"""
     This is for list of user who have cancelled event.
  """
  def cancelled_list(conn, params) do
    with {:ok, value} <- UserRepo.cancelled_list(params) do
      conn
      |> put_status(:ok)
      |> put_view(UserView)
      |> render("user.json", key: value)
    end
  end


end