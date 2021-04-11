defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view

  alias Tetris.Tetromino

  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)
    {:ok,
      socket
      |> new_tetromino
      |> show
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Tetrelixir</h1>
    <%= render_board(assigns) %>
    <% [{x, y}] = @points %>
    <pre>
      {<%= x %>, <%= y %>}
    </pre>
    """
  end

  def down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket) do
    socket
    |>  new_tetromino()
    |> show
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |> assign(:tetro, Tetromino.down(tetro))
    |> show
  end

  def handle_info(:tick, socket) do
    {:noreply, down(socket)}
  end

  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(%{points: [{x, y}]} = assigns) do
    ~L"""
    <rect
      width="20" height="20"
      x="<%= (x - 1) * 20 %>", y="<%= (y - 1) * 20 %>"
      style="fill:rgb(255,0,0);"
    />
    """
  end

  defp show(socket) do
    assign(socket,
      points: Tetromino.points(socket.assigns.tetro)
     )
  end

  defp new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end
end
