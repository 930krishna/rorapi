defmodule RorapiWeb.V1.TopicController do
  use RorapiWeb, :controller

  alias Rorapi.Models.LinkerRepo
  alias RorapiWeb.Admin.TopicView
  alias Rorapi.Models.TopicRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for topic of interest list.
  """
  def list(conn, params) do
    user_id = conn
              |> get_req_header("user_id")
              |> List.first
    with {:ok, value} <- TopicRepo.user_topic_list(user_id, params) do
      conn
      |> put_status(:ok)
      |> put_view(TopicView)
      |> render("topic.json", key: value)
    end
  end

  @doc"""
     This is for add topic of interest.
  """
  def add(conn, params) do
    user_id = conn
              |> get_req_header("user_id")
              |> List.first

    request = %{"users_id" => user_id, "topicofinterest_id" => params["topic_id"]}

    with {:ok, message} <- LinkerRepo.add_topic(request) do
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