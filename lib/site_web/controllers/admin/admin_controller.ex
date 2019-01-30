defmodule SiteWeb.Admin.AdminController do
  use SiteWeb, :controller

  def index(conn, _params) do
    render(conn, "admin.html")
  end
end
