defmodule Rorapi.Models.UserRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Users

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

end