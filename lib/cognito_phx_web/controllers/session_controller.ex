defmodule CognitoPhxWeb.SessionController do
  use CognitoPhxWeb, :controller

  alias CognitoPhx.Accounts

  def sign_up(conn, _params) do
    conn
    |> render(:sign_up)
  end

  def new(conn, _params) do
    conn
    |> render(:new)
  end

  def confirm(conn, _params) do
    conn
    |> render(:confirm)
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password, "password_confirm" => password_confirm, "sign_up" => "true"}}) do
    case Accounts.sign_up(email, password, password_confirm) do
      {:ok, user, _http_resp} ->
        conn
        |> assign(:current_user, user)
        |> put_session(:authenticated, true)
        |> put_flash(:info, gettext("We've created your account"))
        |> redirect(to: session_session_path(conn, :confirm))

      {:error, {error, error_msg}} ->
        prevent_brute_force_attacks()
        conn
        |> put_flash(:error, "#{error}: #{error_msg}")
        |> render(:sign_up)
      
      {:error, error} ->
        prevent_brute_force_attacks()
        conn
        |> put_flash(:error, error)
        |> render(:sign_up)
    end

  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate(email, password) do
      {:ok, user, _http_resp} ->
        conn
        |> assign(:current_user, user)
        |> put_session(:authenticated, true)
        |> put_flash(:info, gettext("Successfully logged in"))
        |> redirect(to: page_path(conn, :index))
      {:error, error} ->
        prevent_brute_force_attacks()
        conn
        |> put_flash(:error, gettext("Invalid email or password"))
        |> render(:new)
    end

  end

  def create(conn, %{"session" => %{"email" => email, "confirmation_code" => confirmation_code}}) do
    case Accounts.confirm(email, confirmation_code) do
      {:ok, user, _http_resp} ->
        conn
        |> assign(:current_user, user)
        |> put_session(:authenticated, true)
        |> put_flash(:info, gettext("Successfully logged in"))
        |> redirect(to: page_path(conn, :index))

      {:error, {error, error_msg}} ->
        prevent_brute_force_attacks()
        conn
        |> put_flash(:error, "#{error}: #{error_msg}")
        |> redirect(to: session_session_path(conn, :confirm))
      
      {:error, error} ->
        prevent_brute_force_attacks()
        conn
        |> put_flash(:error, error)
        |> redirect(to: session_session_path(conn, :confirm))
    end
  end

  def delete(conn, _) do
    conn
    |> put_session(:authenticated, false)
    |> put_flash(:info, gettext("Successfully logged out. Bye!"))
    |> redirect(to: page_path(conn, :index))
  end

  defp prevent_brute_force_attacks do
    :timer.sleep(1_000)
  end

  defp redirect_path(conn) do
    get_session(conn, :redirect_path) || "/"
  end
end