defmodule Worker.DynamicSupervisor do

  use DynamicSupervisor

  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, _args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(id) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {Worker.Supervised, id}
    )
  end

end
