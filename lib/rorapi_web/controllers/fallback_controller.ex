defmodule RorapiWeb.FallbackController do

  use RorapiWeb, :controller


  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(RorapiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, error}) do
    http_status = case error["code"] do
      "401" -> 401
      "422" -> 422
      "404" -> 404
      "405" -> 405
      "4004" -> 406
      _ -> 500
    end
    conn
    |> put_status(http_status)
    |> json(
         %{
           status_code: error["code"],
           errors: %{
             message: error["error"]
           }
         }
       )
  end

  def call(conn, {:error_unique, key, message})do
    conn
    |> put_status(422)
    |> json(
         %{
           errors: %{
             "#{key}" => [message]
           },
           status_code: "422"
         }
       )
  end

  def call(conn, {:empty_response, status_code})do
    conn
    |> put_status(200)
    |> json(
         %{
           data: [],
           status_code: status_code
         }
       )
  end

  def call(conn, {:error_manual, error_resp})do
    conn
    |> put_status(422)
    |> json(error_resp)
  end

  def call(conn, {:error_message, :message, message}) do
    conn
    |> json(
         %{
           status_code: "4004",
           errors: %{
             message: message
           }
         }
       )
  end

end