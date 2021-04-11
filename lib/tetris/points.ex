defmodule Tetris.Points do
  alias Tetris.Point

  def move(points, coordinates) do
    points
    |> Enum.map(&Point.move(&1, coordinates))
  end

end
