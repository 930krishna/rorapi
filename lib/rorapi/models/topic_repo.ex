defmodule Rorapi.Models.TopicRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Topicofinterest

  @doc """
   This is for Add Topic of interest.
  """
  def add_topic(params) do
    topic_map = %{
      title: params["title"],
      short_desc: params["short_desc"]
    }
    changeset = Topicofinterest.changeset(%Topicofinterest{}, topic_map)
    case Repo.insert(changeset) do
      {:ok, _response} ->
        {:ok, "Topic of Interest Added Successfully"}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
    This is for Update Topic of interest.
  """
  def update_topic(params) do
    case Repo.get_by(Topicofinterest, id: params["id"]) do
      nil -> {:error_message, :message, "Topic Not Found"}
      topic -> topic_map = %{
        title: params["title"],
        short_desc: params["short_desc"]
      }
      changeset = Topicofinterest.changeset(topic, topic_map)
      case Repo.update(changeset) do
        {:ok, _response} ->
          {:ok, "Topic of Interest Updated Successfully"}
        {:error, changeset} ->
          {:error, changeset}
      end
    end
  end

  @doc"""
     This is for topic of interest list.
  """
  def topic_list(params)do
    get =  Topicofinterest
           |> select([a], a)
           |> order_by([a], desc: a.id)
           |> Repo.paginate(params)
    {:ok, get}
  end

end