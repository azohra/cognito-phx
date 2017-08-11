defmodule CognitoPhxWeb.Router do
  use CognitoPhxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CognitoPhxWeb do
    pipe_through :browser # Use the default browser stack

    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true do
      get "/signup", SessionController, :sign_up
      get "/confirm", SessionController, :confirm
    end

    get "/", PageController, :index
    get "/login", PageController, :login
    get "/logout", PageController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", CognitoPhxWeb do
  #   pipe_through :api
  # end
end
