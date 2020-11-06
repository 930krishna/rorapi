defmodule RorapiWeb.V1.TopicController do
  use RorapiWeb, :controller

  alias Rorapi.Models.LinkerRepo

  action_fallback RorapiWeb.FallbackController

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