defmodule DHTServer do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(DHTServer.Worker, []),
      worker(DHTServer.Storage, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DHTServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defdelegate search(infohash, callback),                to: DHTServer.Worker
  defdelegate search_announce(infohash, port, callback), to: DHTServer.Worker
end
