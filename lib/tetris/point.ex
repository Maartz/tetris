defmodule Tetris.Point do
  def origin do
    {0, 0}
  end

  def left({x, y}), do: {x - 1, y}

  def right({x, y}), do: {x + 1, y}

  def down({x, y}), do: {x, y + 1}

  def move({x, y}, {x_change, y_change}) do
    {x + x_change, y + y_change}
  end

  def transpose({x, y}) do
    {y, x}
  end

  def mirror({x, y}) do
    {5 - x, y}
  end

  def flip({x, y}) do
    {x,5 - y}
  end

  def rotate(point, 0), do: point

  def rotate(point, 90), do: point |> flip() |> transpose()

  def rotate(point, 180), do: point |> mirror() |> flip()

  def rotate(point, 270), do: point |> mirror() |> transpose()

  def add_shape({x, y}, shape), do: {x, y, shape}

  def add_shape(point_with_shape, _shape), do: point_with_shape

end
