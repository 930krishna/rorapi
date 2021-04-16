defmodule RorapiWeb.LoginController do
  use RorapiWeb, :controller

  alias Rorapi.Models.AdminRepo
  alias Rorapi.Models.UserRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for admin login
  """
  def admin_login(conn, params) do
    with {:ok, output} <- AdminRepo.view(params) do
      json conn, %{status: 200, fullname: output.full_name, aid: output.id, message: "Login Successfully"}
    end
  end

  @doc"""
     This is for user login
  """
  def user_login(conn, params) do
    with {:ok, output} <- UserRepo.view(params) do
      json conn, %{status: 200, fullname: output.full_name, uid: output.id, message: "Login Successfully"}
    end
  end


end