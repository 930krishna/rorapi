defmodule Rorapi.Schemas.Events do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "Events Table Model"

  schema "events" do
    field :description, :string
    field :type, :string
    field :event_date, :date
    field :duration, :string
    field :event_host, :string
    field :location, :string
    field :rsvp_counts, :integer
    field :rsvp_cancelled_counts, :integer

    timestamps()
  end

  @doc false
  def changeset(events, attrs) do
    events
    |> cast( attrs, [:description, :rsvp_counts, :rsvp_cancelled_counts, :type, :event_date, :duration, :event_host, :location])
    |> validate_required([:description, :type, :event_date, :duration, :event_host, :location])
  end

  @doc false
  def changesetAddRSVP(events, attrs) do
    events
    |> cast( attrs, [:rsvp_counts])
    |> validate_required([:rsvp_counts])
  end

  @doc false
  def changesetCancelRSVP(events, attrs) do
    events
    |> cast( attrs, [:rsvp_cancelled_counts])
    |> validate_required([:rsvp_cancelled_counts])
  end

end