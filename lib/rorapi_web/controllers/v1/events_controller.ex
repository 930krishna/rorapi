defmodule RorapiWeb.V1.EventsController do
  use RorapiWeb, :controller

  alias RorapiWeb.Admin.EventView
  alias Rorapi.Models.EventRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for list of events.
  """
  def list(conn, params) do
    user_id = conn
              |> get_req_header("user_id")
              |> List.first

    text conn, "Event list"
  end

  @doc"""
     This is for add event.
  """
  def add(conn, params) do
    user_id = conn
              |> get_req_header("user_id")
              |> List.first
    text conn, "Add event"
  end


end