defmodule SiteWeb.Router do
  use SiteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug :forbidden
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SiteWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin", SiteWeb.Admin, as: :admin do
    pipe_through :browser

    get "/", AdminController, :index
    get "/logout", AdminController, :logout
    post "/", AdminController, :login

    scope "/posts" do
      pipe_through :auth

      resources "/", PostController
    end
  end

  def forbidden(conn, _opts) do
    alias SiteWeb.Router.Helpers, as: Routes
    alias SiteWeb.Endpoint

    case get_session(conn, :signed_in) do
      true -> conn
      _ ->
        conn
        |> Phoenix.Controller.redirect(to: Routes.admin_admin_path(Endpoint, :index))
        |> halt()
    end
  end
end
