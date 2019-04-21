defmodule Server.ProcessRegistryTest do

  use ExUnit.Case

  setup do
    Server.ProcessRegistry.start_link
    :ok
  end

  test "register a new process by name only once" do
    self()
    |> IO.inspect
    assert :ok == Server.ProcessRegistry.register(:some_name)
    assert :error == Server.ProcessRegistry.register(:some_name)
  end

  test "register a new process and find it using the where_is function" do
    Server.ProcessRegistry.register(:first_process)

    assert is_nil(Server.ProcessRegistry.where_is(:first_process)) == false
    assert is_nil(Server.ProcessRegistry.where_is(:second_process)) == true
  end

  test "remove process related information when it crash" do
    Server.ProcessRegistry.register(:process_a)

    pid = Server.ProcessRegistry.where_is(:process_a)

    Process.exit(pid, :kill)

    assert Process.alive?(pid) == false
    assert is_nil(Server.ProcessRegistry.where_is(:process_a)) == true
  end

end
