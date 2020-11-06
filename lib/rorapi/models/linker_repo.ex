defmodule Rorapi.Models.LinkerRepo do
  import Ecto.Query

  alias Rorapi.Repo
  alias Rorapi.Schemas.Linker

  @doc """
   This is for Add Topic of interest.
  """
  def add_topic(params) do
    case Repo.get_by(Linker, users_id: params["users_id"], topicofinterest_id: params["topicofinterest_id"]) do
      nil ->
        linker_map = %{
          users_id: params["users_id"],
          topicofinterest_id: params["topicofinterest_id"]
        }
        changeset = Linker.changeset(%Linker{}, linker_map)
        case Repo.insert(changeset) do
          {:ok, _response} ->
            {:ok, "Topic of Interest Added Successfully"}
          {:error, changeset} ->
            {:error, changeset}
        end
      _linker -> {:error_message, :message, "This topic already added."}
    end
  end

end