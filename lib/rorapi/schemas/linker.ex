defmodule Rorapi.Schemas.Linker do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "Linker Table Model"

  schema "linker" do
    field :users_id, :integer
    field :topicofinterest_id, :integer

    timestamps()
  ends

  @doc false
  def changeset(linker, attrs) do
    linker
    |> cast( attrs, [:users_id, :topicofinterest_id])
    |> validate_required([:users_id, :topicofinterest_id])
  end

end