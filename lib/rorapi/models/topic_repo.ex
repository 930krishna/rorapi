defmodule Rorapi.Models.TopicRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Topicofinterest
  alias Rorapi.Schemas.Linker
  alias Rorapi.Schemas.Users

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
  def topic_list(params) do
    get =  Topicofinterest
           |> select([a], a)
           |> order_by([a], desc: a.id)
           |> Repo.paginate(params)
    {:ok, get}
  end

  @doc"""
     This is for topic of interest list for users.
  """
  def user_topic_list(user_id, params) do
    get = (
            from l in Linker,
                 where: l.users_id == ^user_id,
                 join: t in Topicofinterest,
                 on: l.topicofinterest_id == t.id,
                 select: %{
                   id: t.id,
                   title: t.title,
                   short_desc: t.short_desc
                 })
          |> order_by(desc: :id)
          |> Repo.paginate(params)
    {:ok, get}
  end

  @doc"""
     This is for topic of interest list for users.
  """
  def users_list(params) do
    topic_id = params["topic_id"]
    get = (
            from l in Linker,
                 where: l.topicofinterest_id == ^topic_id,
                 join: u in Users,
                 on: l.users_id == u.id,
                 select: %{
                   id: u.id,
                   full_name: u.full_name,
                   email: u.email,
                   age: u.age
                 })
          |> order_by(desc: :id)
          |> Repo.paginate(params)
    {:ok, get}
  end

end