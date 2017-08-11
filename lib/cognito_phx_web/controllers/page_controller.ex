defmodule CognitoPhxWeb.PageController do
  use CognitoPhxWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, _params) do
    conn
    |> redirect(to: session_path(conn, :new))
  end
end
