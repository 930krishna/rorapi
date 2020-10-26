defmodule Rorapi.Models.EventRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Events

  @doc """
   This is for Add Event.
  """
  def add_event(params) do
    event_map = %{
      description: params["description"],
      type: params["type"],
      event_date: params["date"],
      duration: params["duration"],
      event_host: params["host"],
      location: params["location"]
    }
    changeset = Events.changeset(%Events{}, event_map)
    case Repo.insert(changeset) do
      {:ok, _response} ->
        {:ok, "Event Added Successfully"}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
    This is for Update Event.
  """
  def update_event(params) do
    case Repo.get_by(Events, id: params["id"]) do
      nil -> {:error_message, :message, "Event Not Found"}
      events -> event_map = %{
         description: params["description"],
         type: params["type"],
         event_date: params["date"],
         duration: params["duration"],
         event_host: params["host"],
         location: params["location"]
      }
      changeset = Events.changeset(events, event_map)
      case Repo.update(changeset) do
          {:ok, _response} ->
            {:ok, "Event Updated Successfully"}
          {:error, changeset} ->
            {:error, changeset}
      end
    end
  end

  @doc"""
     This is for list events.
  """
  def events_list(params)do
    get =  Events
           |> select([a], a)
           |> order_by([a], desc: a.id)
           |> Repo.paginate(params)
    {:ok, get}
  end

end