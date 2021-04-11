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
end
