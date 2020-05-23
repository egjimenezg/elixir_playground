defmodule Worker.Supervisor.OneForOne do

  def start_link do
    Supervisor.start_link(
      [
        %{
          id: Worker.Supervised,
          start: {Worker.Supervised, :start_link, [nil]}
        }
      ],
      strategy: :one_for_one
    )
  end


end
