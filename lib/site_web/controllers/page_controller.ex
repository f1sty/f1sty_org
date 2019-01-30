defmodule SiteWeb.PageController do
  use SiteWeb, :controller

  alias Site.Blog

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end
end
