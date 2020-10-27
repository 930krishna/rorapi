defmodule Rorapi.Models.UserRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Users
  alias Rorapi.Schemas.Eventusers

  @doc """
   This is for Add User.
  """
  def add_user(params) do
    user_map = %{
      full_name: params["full_name"],
      age: params["age"],
      email: params["email"],
      password: params["password"]
    }
    changeset = Users.changeset(%Users{}, user_map)
    case Repo.insert(changeset) do
      {:ok, _response} ->
        {:ok, "Registration Successfully"}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc"""
     This is for list users.
  """
  def user_list(params)do
    get =  Users
           |> select([a], a)
           |> order_by([a], desc: a.id)
           |> Repo.paginate(params)
    {:ok, get}
  end

  @doc"""
     This is for user view
  """
  def view(params)do
    case Repo.get_by(Users, email: params["email"], password: params["password"]) do
      nil -> {:error_message, :message, "Email or Password is wrong."}
      admin ->  {:ok, admin}
    end
  end

  @doc"""
     This is for list of attend users.
  """
  def attend_list(params)do
    attend = Repo.get_by(Eventusers, events_id: params["event_id"])
    case attend do
      nil -> {:error_message, :message, "Event id is not exist."}
      admin ->  attend_user = attend.confirmed_users
                get =  Users
                       |> where([p], p.id in ^attend_user)
                       |> select([a], a)
                       |> order_by([a], desc: a.id)
                       |> Repo.paginate(params)
                {:ok, get}
    end
  end

  @doc"""
     This is for list of cancelled users.
  """
  def cancelled_list(params)do
    cancelled = Repo.get_by(Eventusers, events_id: params["event_id"])
    case cancelled do
      nil -> {:error_message, :message, "Event id is not exist."}
      admin ->  cancelled_user = cancelled.cancelled_users
                get =  Users
                       |> where([p], p.id in ^cancelled_user)
                       |> select([a], a)
                       |> order_by([a], desc: a.id)
                       |> Repo.paginate(params)
                {:ok, get}
    end
  end

end