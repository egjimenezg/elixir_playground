defmodule Worker.Supervisor.OneForOne do

  def start_link do
    Supervisor.start_link(
      [
        Worker.Supervised
      ],
      strategy: :one_for_one
    )
  end


end
