defmodule Rorapi.Schemas.eventUsers do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "eventUsers Table Model"

  schema "eventUsers" do
    field :events_id, :integer
    field :invite_users, {:array, :integer}
    field :confirmed_users, {:array, :integer}
    field :cancelled_users, {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(eventUsers, attrs) do
    address
    |> cast( attrs, [:events_id, :invite_users])
    |> validate_required([:events_id])
  end

  @doc false
  def changesetUpdateConfirmed(eventUsers, attrs) do
    address
    |> cast( attrs, [:confirmed_users])
    |> validate_required([:confirmed_users])
  end

  @doc false
  def changesetUpdateCancelled(eventUsers, attrs) do
    address
    |> cast( attrs, [:cancelled_users])
    |> validate_required([:cancelled_users])
  end

end