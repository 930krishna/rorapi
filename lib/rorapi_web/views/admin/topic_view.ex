defmodule RorapiWeb.Admin.TopicView do
  use RorapiWeb, :view

  alias RorapiWeb.Admin.TopicView

  @doc"""
    This is for event list.
  """
  def render("topic.json", %{key: value}) do
    %{
      status_code: "200",
      total_pages: value.total_pages,
      total_entries: value.total_entries,
      page_size: value.page_size,
      page_number: value.page_number,
      data: render_many(value.entries, TopicView, "topic_list.json", as: :key)
    }
  end

  def render("topic_list.json", %{key: value}) do
    %{
      id: value.id,
      title: value.title,
      short_desc: value.short_desc
    }
  end
end