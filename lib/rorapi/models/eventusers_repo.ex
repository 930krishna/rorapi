defmodule Rorapi.Models.EventusersRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Eventusers
  alias Rorapi.Schemas.Events

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

  # Private Function for insert event
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

  # Private Function for update event
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

  @doc """
   This is for check event for users and add it.
  """
  def check_event(params) do
    check_event = Eventusers
          |> where(^event_user_filter(params))
          |> where([d], d.events_id == ^params["event_id"])
          |> Repo.one
    case check_event do
      nil -> {:error_message, :message, "Event not found."}
      check_event ->
        user_id = to_integer_value(params["user_id"])
        member = Enum.member?(check_event.confirmed_users,user_id)
        events = if member == true, do: check_event.confirmed_users, else: ["#{user_id}"] ++  check_event.confirmed_users
        confirm_event = %{confirmed_users: events}
        changeset = Eventusers.changesetUpdateConfirmed(check_event, confirm_event)
        case Repo.update(changeset) do
          {:ok, _response} ->
            rsvp_counts(params["event_id"])
            {:ok, "Confirmed attendees."}
          {:error, changeset} ->
            {:error, changeset}
        end
    end
  end

  @doc """
   This is for check event for users and cancel it.
  """
  def remove_event(params) do
    check_event = Eventusers
                  |> where(^event_user_filter(params))
                  |> where([d], d.events_id == ^params["event_id"])
                  |> Repo.one
    case check_event do
      nil -> {:error_message, :message, "Event not found."}
      check_event ->
        user_id = to_integer_value(params["user_id"])
        member = Enum.member?(check_event.cancelled_users,user_id)
        events = if member == true, do: check_event.cancelled_users, else: ["#{user_id}"] ++  check_event.cancelled_users
        confirm_event = %{cancelled_users: events}
        changeset = Eventusers.changesetUpdateCancelled(check_event, confirm_event)
        case Repo.update(changeset) do
          {:ok, _response} ->
            rsvp_cancel_counts(params["event_id"])
            {:ok, "Removing attendees."}
          {:error, changeset} ->
            {:error, changeset}
        end
    end
  end

  # Private Function for search event for user
  defp event_user_filter(params)do
    Enum.reduce(
      params,
      dynamic(true),
      fn
        {"user_id", value}, dynamic -> id = String.to_integer(value)
                                  dynamic([d], ^dynamic and fragment("? @> ?", d.invite_users, ^[id]))
        {_, _}, dynamic -> dynamic
      end
    )
  end

  @doc """
   This is for list of events for users
  """
  def event_list(params) do
    check_event = Eventusers
                  |> where(^event_confirm_filter(params))
                  |> order_by([d], [desc: d.id])
                  |> Repo.paginate(params)
    case check_event do
      nil -> {:error_message, :message, "Events not found."}
      check_event -> {:ok, check_event}
    end
  end

  # Private Function for search event for user
  defp event_confirm_filter(params)do
    Enum.reduce(
      params,
      dynamic(true),
      fn
        {"user_id", value}, dynamic -> id = String.to_integer(value)
                                       dynamic([d], ^dynamic and fragment("? @> ?", d.confirmed_users, ^[id]))
        {_, _}, dynamic -> dynamic
      end
    )
  end

  # Private function for manage RSVP Counts
  defp rsvp_counts(event_id) do
    event = Repo.get_by(Events, id: event_id)
    db_value = event.rsvp_counts
    new_value = 1
    last_rsvp = db_value + new_value
    event_map = %{rsvp_counts: last_rsvp}
    changeset = Events.changesetAddRSVP(event, event_map)
    Repo.update(changeset)
  end
  # Private function for manage RSVP Cancelled Counts
  defp rsvp_cancel_counts(event_id) do
    event = Repo.get_by(Events, id: event_id)
    db_value = event.rsvp_cancelled_counts
    new_value = 1
    last_rsvp = db_value + new_value
    event_map = %{rsvp_cancelled_counts: last_rsvp}
    changeset = Events.changesetCancelRSVP(event, event_map)
    Repo.update(changeset)
  end

  # Private function convert string to integer
  defp to_integer_value(key)do
    if is_integer(key), do: key, else: String.to_integer(key)
  end

end