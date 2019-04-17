defmodule Server.ProcessRegistryTest do

  use ExUnit.Case

  test "register a new process by name only once" do
    Server.ProcessRegistry.start_link
    assert :ok == Server.ProcessRegistry.register(:some_name)
    assert :error == Server.ProcessRegistry.register(:some_name)
  end

  test "register a new process and find it using the where_is function" do
    Server.ProcessRegistry.start_link
    Server.ProcessRegistry.register(:first_process)

    assert is_nil(Server.ProcessRegistry.where_is(:first_process)) == false
    assert is_nil(Server.ProcessRegistry.where_is(:second_process)) == true
  end

end
