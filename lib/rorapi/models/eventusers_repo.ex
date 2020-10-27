defmodule Rorapi.Models.EventusersRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Eventusers

  @doc """
   This is for invite users in event.
  """
  def user_invite(params) do
    # Check event id
    # If not exist then insert or if exist then update
    case Repo.get_by(Eventusers, events_id: params["events_id"]) do
      nil -> invite_insert(params)
      event_user -> invite_update(event_user, params)
    end
  end

  defp invite_insert(params) do
    event_map = %{
      events_id: params["events_id"],
      invite_users: params["invite_users"]
    }
    changeset = Eventusers.changeset(%Eventusers{}, event_map)
    case Repo.insert(changeset) do
      {:ok, _response} ->
        {:ok, "Invite user successfully"}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp invite_update(event_user, params) do
    invite_map = %{
      events_id: params["events_id"],
      invite_users: params["invite_users"]
    }
    changeset = Eventusers.changeset(event_user, invite_map)
    case Repo.update(changeset) do
      {:ok, _response} ->
        {:ok, "Invite user successfully"}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end