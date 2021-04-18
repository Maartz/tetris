defmodule Tetris.Points do
  alias Tetris.Point

  def move(points, coordinates) do
    points
    |> Enum.map(&Point.move(&1, coordinates))
  end

  def add_shape(points, shape) do
    points
    |> Enum.map(fn point -> Point.add_shape(point, shape) end)
  end
end
