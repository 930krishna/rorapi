defmodule RorapiWeb.SuccessView do
  use RorapiWeb, :view
  @moduledoc """
    This is for success view messages.
  """
  @doc """
    This is for call success view 200
  """
  def render("200.json", assigns) do
    %{
      status_code: "200",
      message: assigns.message
    }
  end

end