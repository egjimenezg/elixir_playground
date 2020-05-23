defmodule Worker.Supervisor.OneForOneTest do

  use ExUnit.Case

  setup do
    Worker.Supervisor.OneForOne.start_link
    :ok
  end

  test "should create a new worker when the supervised worker dies" do
    worker_pid = Process.whereis(Worker.Supervised)
    Process.monitor(worker_pid)

    Process.exit(worker_pid, :kill)

    receive do
      {:DOWN, _, :process, worker_pid, :killed} -> IO.puts("#{inspect worker_pid} is DOWN")
    end

    new_pid = Process.whereis(Worker.Supervised)

    assert worker_pid != new_pid
  end

end
