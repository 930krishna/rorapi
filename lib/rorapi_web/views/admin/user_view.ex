defmodule RorapiWeb.Admin.UserView do
  use RorapiWeb, :view

  alias RorapiWeb.Admin.UserView

  @doc"""
    This is for user list.
  """
  def render("user.json", %{key: value}) do
    %{
      status_code: "200",
      total_pages: value.total_pages,
      total_entries: value.total_entries,
      page_size: value.page_size,
      page_number: value.page_number,
      data: render_many(value.entries, UserView, "user_list.json", as: :key)
    }
  end

  def render("user_list.json", %{key: value})do
    %{
      id: value.id,
      full_name: value.full_name,
      age: value.age,
      email: value.email
    }
  end

end