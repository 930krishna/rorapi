defmodule Rorapi.Models.EventRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Events

  @doc """
   add Event
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
    changeset_beneficiary = Events.changeset(%Events{}, event_map)
    case Repo.insert(changeset_beneficiary) do
      {:ok, _response} ->
        {:ok, "Event Added Successfully"}
      {:error, changeset} ->
        {:error, changeset}
    end
  end
end