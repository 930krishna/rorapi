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
  end

  @doc"""
     This is for update exist event in db.
  """
  def update(conn, params) do
    with {:ok, message} <- EventRepo.update_event(params) do
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