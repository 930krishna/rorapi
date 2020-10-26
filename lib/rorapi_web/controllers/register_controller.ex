defmodule RorapiWeb.RegisterController do
  use RorapiWeb, :controller

  alias Rorapi.Models.UserRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for register user in db.
  """
  def register(conn, params) do
    with {:ok, message} <- UserRepo.add_user(params) do
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