defmodule RorapiWeb.Admin.EventusersView do
  use RorapiWeb, :view

  alias Rorapi.Repo
  alias RorapiWeb.Admin.EventusersView
  alias Rorapi.Schemas.Events

  @doc"""
    This is for eventusers list.
  """
  def render("eventusers.json", %{key: value}) do
    %{
      status_code: "200",
      total_pages: value.total_pages,
      total_entries: value.total_entries,
      page_size: value.page_size,
      page_number: value.page_number,
      data: render_many(value.entries, EventusersView, "eventusers_list.json", as: :key)
    }
  end

  def render("eventusers_list.json", %{key: value}) do
    # Event name
    event = Repo.get_by(Events, id: value.events_id)
    %{
      event_id: value.events_id,
      description: event.description,
      type: event.type,
      date: event.event_date,
      duration: event.duration,
      host: event.event_host,
      location: event.location
    }
  end

end