defmodule Worker.Supervised do

  use GenServer

  def init(_) do
    {:ok, %{}}
  end

  def child_spec(worker_id) do
    %{id: "worker_#{worker_id}", start: {Worker.Supervised, :start_link, ["worker_#{worker_id}"]} }
  end

  def start_link(worker_name) when is_binary(worker_name) do
    GenServer.start_link(__MODULE__, nil, name: String.to_atom(worker_name))
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

end
