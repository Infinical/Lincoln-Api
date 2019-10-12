defmodule LincolnApi.Repo do
  use Ecto.Repo,
    otp_app: :lincoln_api,
    adapter: Ecto.Adapters.Postgres
end
