defmodule Worker.Supervised do

  use GenServer

  def init(_) do
    {:ok, %{}}
  end

  def start_link(_) do
    IO.puts("Starting worker")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

end
