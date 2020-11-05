defmodule Rorapi.Schemas.Topicofinterest do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "Topic of interest Table Model"

  schema "topicofinterest" do
    field :title, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(topicofinterest, attrs) do
    topicofinterest
    |> cast( attrs, [:title, :description])
    |> validate_required([:title, :description])
  end

end