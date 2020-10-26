defmodule RorapiWeb.Admin.EventsController do
  use RorapiWeb, :controller

  alias RorapiWeb.Class.EventView
  alias Rorapi.Models.EventRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for insert event in db.
  """
  def create(conn, params) do
    with {:ok, message} <- EventRepo.add_event(params) do
      success_response_message(conn, message)
    end
  end3

  #Private fuction
  defp success_response_message(conn, message) do
    conn
    |> put_view(RorapiWeb.SuccessView)
    |> render("200.json", message: message)
  end

end