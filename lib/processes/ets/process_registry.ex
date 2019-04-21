defmodule Ets.ProcessRegistry do

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    Process.flag(:trap_exit, true)
    :ets.new(__MODULE__, [:named_table, :public])

    {:ok, nil}
  end

  def register(name) do
    case :ets.lookup(__MODULE__, name) do
      [{^name, _}] ->
        :error
      [] ->
        new_pid = spawn(fn ->
                    Process.link(Process.whereis(__MODULE__))
                    receive do
                      message -> IO.inspect(message)
                    end 
                  end)

        :ets.insert(__MODULE__, {name, new_pid})
        :ok
    end
  end

  def where_is(name) do
    case :ets.lookup(__MODULE__, name) do
      [{^name, value}] ->
        value
      [] -> nil
    end
  end

  def handle_info({:EXIT, pid, _reason}, _state) do
    :ets.match_delete(__MODULE__,{:_,pid}) 

    {:noreply, nil}
  end

end
