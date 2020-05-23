defmodule Worker.Supervisor.OneForAllTest do
  use ExUnit.Case

  @workers_number 4

  setup do
    Worker.Supervisor.OneForAll.start_link
    :ok
  end

  test "should create new workers when one of the supervised workers die" do
    worker_pids = get_worker_pids(@workers_number)

    first_worker = Process.whereis(:worker_1)

    Process.monitor(first_worker)
    Process.exit(first_worker, :kill)

    receive do
      {:DOWN, _, :process, first_worker, :killed} -> IO.puts("#{inspect first_worker} is DOWN")
    after
      1000 -> :ok
    end

    new_worker_pids = get_worker_pids(@workers_number)

    refute MapSet.subset?(worker_pids, new_worker_pids)
  end

  defp get_worker_pids(n) do
    1..n
    |> Stream.map(fn(n) -> Process.whereis(String.to_atom("worker_#{n}")) end)
    |> Enum.into(MapSet.new)
  end

end
