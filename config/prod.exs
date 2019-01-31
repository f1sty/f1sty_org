use Mix.Config

config :site, SiteWeb.Endpoint,
  http: [:inet6, port: {:system, "PORT"}],
  url: [host: "localhost", port: {:system, "PORT"}],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: ".",
  version: Application.spec(:site, :vsn),
  secret_key_base: System.get_env("PROD_SECRET")

config :logger, level: :info

config :site, Site.Repo,
  pool_size: 15
