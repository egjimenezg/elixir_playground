defmodule Worker.Supervisor.DynamicTest do
  use ExUnit.Case

  @workers_number 4

  setup do
    Worker.DynamicSupervisor.start_link(%{})
    :ok
  end

  test "should create workers dynamically" do
    1..@workers_number
    |> Enum.each(fn(n) ->
      Worker.DynamicSupervisor.start_child(n)
    end)

    1..@workers_number
    |> Enum.each(fn(n) ->
      pid = Process.whereis(String.to_atom("worker_#{n}"))
      assert Process.alive?(pid) == true
    end)
  end

end
