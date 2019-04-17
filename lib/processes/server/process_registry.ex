defmodule Server.ProcessRegistry do

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  def register(name) do
    GenServer.call(__MODULE__, {:register, name})
  end

  def where_is(name) do
    GenServer.call(__MODULE__, {:where_is, name})
  end

  def handle_call({:register, name}, _, registry) do

    case Map.fetch(registry, name) do
      {:ok, _} ->
        {:reply, :error, registry}
      :error ->
        pid = spawn_link(fn ->
                receive do
                  message -> IO.inspect(message)
                end
              end)

        {:reply, :ok, Map.put(registry, name, pid)}
    end
  end

  def handle_call({:where_is, name}, _, registry) do
    {:reply, Map.get(registry, name), registry}    
  end

end
