defmodule CognitoPhxWeb.PageControllerTest do
  use CognitoPhxWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "nothing"
  end
end
