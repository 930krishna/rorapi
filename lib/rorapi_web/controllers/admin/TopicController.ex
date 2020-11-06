defmodule RorapiWeb.Admin.TopicController do
  use RorapiWeb, :controller

  alias RorapiWeb.Admin.TopicView
  alias Rorapi.Models.TopicRepo

  action_fallback RorapiWeb.FallbackController

  @doc"""
     This is for insert topic of interest in db.
  """
  def create(conn, params) do
    with {:ok, message} <- TopicRepo.add_topic(params) do
      success_response_message(conn, message)
    end
  end

  @doc"""
     This is for update exist topic of interest in db.
  """
  def update(conn, params) do
    with {:ok, message} <- TopicRepo.update_topic(params) do
      success_response_message(conn, message)
    end
  end

  @doc"""
     This is for list for topic of interest.
  """
  def show(conn, params) do
    with {:ok, value} <- TopicRepo.topic_list(params) do
      conn
      |> put_status(:ok)
      |> put_view(TopicView)
      |> render("topic.json", key: value)
    end
  end

  #Private function
  defp success_response_message(conn, message) do
    conn
    |> put_view(RorapiWeb.SuccessView)
    |> render("200.json", message: message)
  end

end