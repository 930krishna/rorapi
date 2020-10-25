defmodule Rorapi.Schemas.Admin do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "Admin Table Model"

  schema "admin" do
    field :full_name, :string
    field :username, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    address
    |> cast( attrs, [:full_name, :username, :password])
    |> validate_required([:full_name, :username, :password])
  end

end