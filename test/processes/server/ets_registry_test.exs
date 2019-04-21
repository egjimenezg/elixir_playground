defmodule Ets.ProcessRegistryTest do

  use ExUnit.Case

  setup do
    Ets.ProcessRegistry.start_link
    :ok
  end

  test "register a new process by name only once" do
    assert :ok == Ets.ProcessRegistry.register(:some_name)
    assert :error == Ets.ProcessRegistry.register(:some_name)
  end

  test "register a new process and find it using the where_is function" do
    Ets.ProcessRegistry.register(:first_process)

    assert is_nil(Ets.ProcessRegistry.where_is(:first_process)) == false
    assert is_nil(Ets.ProcessRegistry.where_is(:second_process)) == true
  end

  test "remove process related information when it crash" do
    Ets.ProcessRegistry.register(:process_a)
    
    pid = Ets.ProcessRegistry.where_is(:process_a)

    Process.sleep(10) 
    Process.exit(pid, :kill)
    Process.sleep(10) 
   
    assert Process.alive?(pid) == false
    assert is_nil(Ets.ProcessRegistry.where_is(:process_a)) == true
  end

end
