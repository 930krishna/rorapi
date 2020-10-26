defmodule RorapiWeb.Admin.UsersController do
  use RorapiWeb, :controller

  alias RorapiWeb.Admin.UserView
  alias Rorapi.Models.UserRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for update exist event in db.
  """
  def list(conn, params) do
    with {:ok, value} <- UserRepo.user_list(params) do
      conn
      |> put_status(:ok)
      |> put_view(UserView)
      |> render("user.json", key: value)
    end
  end

end