defmodule RorapiWeb.Admin.UsersController do
  use RorapiWeb, :controller

  alias RorapiWeb.Admin.UserView
  alias Rorapi.Models.UserRepo
  alias Rorapi.Models.EventusersRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for user list
  """
  def list(conn, params) do
    with {:ok, value} <- UserRepo.user_list(params) do
      conn
      |> put_status(:ok)
      |> put_view(UserView)
      |> render("user.json", key: value)
    end
  end

  @doc"""
     This is for invite user in event
  """
  def invite(conn, params) do
    with {:ok, message} <- EventusersRepo.user_invite(params) do
      success_response_message(conn, message)
    end
  end

  #Private function
  defp success_response_message(conn, message) do
    conn
    |> put_view(RorapiWeb.SuccessView)
    |> render("200.json", message: message)
  end


end