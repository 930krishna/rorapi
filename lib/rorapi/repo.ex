defmodule Rorapi.Repo do
  use Scrivener, page_size: 30
  use Ecto.Repo, otp_app: :rorapi,
  adapter: Ecto.Adapters.Postgres

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
#  def init(_, opts) do
#    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
#  end
end
