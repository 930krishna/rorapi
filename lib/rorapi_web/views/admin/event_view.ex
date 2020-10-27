defmodule RorapiWeb.Admin.EventView do
  use RorapiWeb, :view

  alias RorapiWeb.Admin.EventView

  @doc"""
    This is for event list.
  """
  def render("event.json", %{key: value}) do
    %{
      status_code: "200",
      total_pages: value.total_pages,
      total_entries: value.total_entries,
      page_size: value.page_size,
      page_number: value.page_number,
      data: render_many(value.entries, EventView, "event_list.json", as: :key)
    }
  end

  def render("event_list.json", %{key: value})do
    %{
      id: value.id,
      description: value.description,
      type: value.type,
      date: value.event_date,
      duration: value.duration,
      host: value.event_host,
      location: value.location,
      rsvp_counts: value.rsvp_counts,
      rsvp_cancelled_counts: value.rsvp_cancelled_counts
    }
  end

end