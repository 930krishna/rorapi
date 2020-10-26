defmodule Rorapi.Schemas.Users do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc "Users Table Model"

  schema "users" do
    field :full_name, :string
    field :age, :integer
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast( attrs, [:full_name, :age, :email, :password])
    |> validate_required([:full_name, :age, :email, :password])
  end

end