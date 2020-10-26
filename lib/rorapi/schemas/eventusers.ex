defmodule Rorapi.Schemas.Eventusers do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "eventusers Table Model"

  schema "eventusers" do
    field :events_id, :integer
    field :invite_users, {:array, :integer}
    field :confirmed_users, {:array, :integer}
    field :cancelled_users, {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(eventusers, attrs) do
    eventusers
    |> cast( attrs, [:events_id, :invite_users])
    |> validate_required([:events_id])
  end

  @doc false
  def changesetUpdateConfirmed(eventusers, attrs) do
    eventusers
    |> cast( attrs, [:confirmed_users])
    |> validate_required([:confirmed_users])
  end

  @doc false
  def changesetUpdateCancelled(eventusers, attrs) do
    eventusers
    |> cast( attrs, [:cancelled_users])
    |> validate_required([:cancelled_users])
  end

end