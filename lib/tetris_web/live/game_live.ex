defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view

  alias Tetris.Tetromino

  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)
    {:ok,
      socket
      |> new_tetromino
    }
  end

  def new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end

  def render(assigns) do
    ~L"""
    <pre>
      <%= inspect @tetro %>
    </pre>
    """
  end

  def handle_info(:tick, socket) do
    {:noreply, socket}
  end
end
