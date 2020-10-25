defmodule RorapiWeb.PageController do
  use RorapiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
