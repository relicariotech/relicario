defmodule Relicario.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RelicarioWeb.Telemetry,
      Relicario.Repo,
      {DNSCluster, query: Application.get_env(:relicario, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Relicario.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Relicario.Finch},
      # Start a worker by calling: Relicario.Worker.start_link(arg)
      # {Relicario.Worker, arg},
      # Start to serve requests, typically the last entry
      RelicarioWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Relicario.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RelicarioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
