defmodule Relicario.Repo do
  use Ecto.Repo,
    otp_app: :relicario,
    adapter: Ecto.Adapters.Postgres
end
