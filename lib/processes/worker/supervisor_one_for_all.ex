defmodule Worker.Supervisor.OneForAll do

  @workers_number 4

  def start_link do
    # Generating workers child spec, this could be done dinamically using a DynamicSupervisor
    child_specs = 1..@workers_number
                  |> Enum.map(fn(n) -> {Worker.Supervised, n} end)

    Supervisor.start_link(child_specs, strategy: :one_for_all)
  end

end
