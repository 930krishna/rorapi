defmodule RorapiWeb.V1.EventsController do
  use RorapiWeb, :controller

  alias RorapiWeb.Admin.EventusersView
  alias Rorapi.Models.EventusersRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for list of events.
  """
  def list(conn, params) do
    user_id = conn
              |> get_req_header("user_id")
              |> List.first

    request = %{"user_id" => user_id}
    with {:ok, value} <- EventusersRepo.event_list(request) do
      conn
      |> put_status(:ok)
      |> put_view(EventusersView)
      |> render("eventusers.json", key: value)
    end
  end

  @doc"""
     This is for add event.
  """
  def add(conn, params) do
    user_id = conn
              |> get_req_header("user_id")
              |> List.first

    request = %{"user_id" => user_id, "event_id" => params["event_id"]}

    with {:ok, message} <- EventusersRepo.check_event(request) do
      success_response_message(conn, message)
    end
  end

  @doc"""
     This is for cancel event.
  """
  def remove(conn, params) do
    user_id = conn
              |> get_req_header("user_id")
              |> List.first

    request = %{"user_id" => user_id, "event_id" => params["event_id"]}

    with {:ok, message} <- EventusersRepo.remove_event(request) do
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