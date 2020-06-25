defmodule DemoPhoenixApi.Repo do
  use Ecto.Repo,
    otp_app: :demo_phoenix_api,
    adapter: Ecto.Adapters.Postgres
end
