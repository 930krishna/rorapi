defmodule Rorapi.Schemas.Topicofinterest do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "Topic of interest Table Model"

  schema "topicofinterest" do
    field :title, :string
    field :short_desc, :string

    timestamps()
  end

  @doc false
  def changeset(topicofinterest, attrs) do
    topicofinterest
    |> cast( attrs, [:title, :short_desc])
    |> validate_required([:title, :short_desc])
  end

end