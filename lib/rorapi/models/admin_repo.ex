defmodule Rorapi.Models.AdminRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Admin

  @doc"""
     This is for admin view
  """
  def view(params)do
    case Repo.get_by(Admin, username: params["username"], password: params["password"]) do
      nil -> {:error_message, :message, "Username or Password is wrong."}
      admin ->  {:ok, admin}
    end
  end

end