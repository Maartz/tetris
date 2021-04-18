defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view

  alias Tetris.Tetromino

  def mount(_params, _session, socket) do
    if connected?(socket) do
       :timer.send_interval(500, :tick)
    end

    {:ok,
      socket
      |> new_tetromino
      |> show
    }
  end

  def render(assigns) do
    ~L"""
    <% {x, y} = @tetro.location %>
    <section class="phx-hero">
      <h1>Tetrelixir</h1>
      <%= render_board(assigns) %>
      <pre>
        <%= inspect @tetro %>
      </pre>
    </section>
    """
  end

  def rotate(%{assigns: %{tetro: tetro}} = socket) do
    socket
    |>  assign(:tetro, Tetromino.rotate(tetro))
  end
  def down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket) do
    socket
    |>  new_tetromino()
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, :tetro, Tetromino.down(tetro))
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> down |> rotate |> show}
  end

  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~L"""
    <%= for {x, y, shape} <- @points do %>
    <rect
      width="20" height="20"
      x="<%= (x - 1) * 20 %>", y="<%= (y - 1) * 20 %>"
      style="fill:<%= color(shape) %>;"
    />
    <% end %>
    """
  end

  defp color(:l), do: "firebrick"
  defp color(:j), do: "dodgerblue"
  defp color(:z), do: "darkorange"
  defp color(:s), do: "gold"
  defp color(:o), do: "hotpink"
  defp color(:i), do: "lime"
  defp color(:t), do: "mediumorchid"
  defp color(_),  do: "red"

  defp show(socket) do
    assign(socket,
      points: Tetromino.show(socket.assigns.tetro)
     )
  end

  defp new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end
end
