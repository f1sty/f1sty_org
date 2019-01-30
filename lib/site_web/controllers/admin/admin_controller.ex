defmodule SiteWeb.Admin.AdminController do
  use SiteWeb, :controller

  def index(conn, _params) do
    render(conn, "admin.html")
  end

  def login(conn, params) do
    with u <- Site.User.get(params["login"]["username"]),
         p <- params["login"]["password"] do
      case u && Comeonin.Bcrypt.checkpw(p, u.password) do
        true ->
          Map.delete(params, "login")
          conn
          |> put_session(:signed_in, :true)
          |> redirect(to: Routes.admin_post_path(conn, :index))
        _ ->
          redirect(conn, to: Routes.admin_admin_path(conn, :index))
      end
    end
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:signed_in)
    |> redirect(to: Routes.admin_admin_path(conn, :index))
  end
end
