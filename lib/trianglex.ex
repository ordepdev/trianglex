defmodule Trianglex do

  @blank " "
  @moduledoc """
  Documentation for Trianglex.
  """

  defstruct [:value]

  @doc """
  Makes the simplest right upwards tringle.

  ## Examples

      iex> Trianglex.right(1)
      :not_a_triangle

      iex> Trianglex.right(2)
      [["*"], ["*", "*"]]

      iex> Trianglex.right(3)
      [["*"], ["*", "*"], ["*", "*", "*"]]

      iex> Trianglex.right(4)
      [["*"], ["*", "*"], ["*", "*", "*"], ["*", "*", "*", "*"]]

  """
  def right(1), do: :not_a_triangle
  def right(rows) do
    Range.new(1, rows)
    |> Enum.reduce([], fn row, acc -> acc ++ [List.duplicate("*", row)] end)
  end
  def right(rows, :down) do
    Range.new(rows, 1)
    |> Enum.reduce([], fn row, acc -> acc ++ [List.duplicate("*", row) ++ List.duplicate(@blank, rows-row)] end)
  end

  @doc """
  Makes the simplest left upwards tringle.

  ## Examples

      iex> Trianglex.left(1)
      :not_a_triangle

      iex> Trianglex.left(2)
      [[" ","*"], ["*", "*"]]

      iex> Trianglex.left(3)
      [[" "," ","*"], [" ","*", "*"], ["*", "*", "*"]]

      iex> Trianglex.left(4)
      [[" "," "," ","*"], [" "," ", "*", "*"], [" ","*", "*", "*"], ["*", "*", "*", "*"]]

      iex> Trianglex.left(2, :down)
      [["*", "*"], [" ","*"]]

      iex> Trianglex.left(3, :down)
      [["*", "*", "*"], [" ","*", "*"], [" "," ","*"]]

      iex> Trianglex.left(4, :down)
      [["*", "*", "*", "*"], [" ","*", "*", "*"], [" "," ","*", "*"], [" "," "," ","*"]]

  """
  def left(1), do: :not_a_triangle
  def left(rows) do
    Range.new(1, rows)
    |> Enum.reduce([], fn row, acc -> acc ++ [List.duplicate(@blank, rows-row) ++ List.duplicate("*", row)] end)
  end
  def left(rows, :down) do
    Range.new(rows, 1)
    |> Enum.reduce([], fn row, acc -> acc ++ [List.duplicate(@blank, rows-row) ++ List.duplicate("*", row)] end)
  end

  @doc """
  Mirrors a left triangle.
  """
  def mirror(1), do: :not_a_triangle
  def mirror(rows) do
    Enum.concat(
      Enum.zip(Trianglex.left(rows), Trianglex.right(rows)),
      Enum.zip(Trianglex.left(rows,:down), Trianglex.right(rows,:down))
    )
  end

  @doc """
  Given a valid triangle, it will print it.
  """
  def print([{_, _} | _] = mirror), do: mirror |> Enum.each(fn {l,r} -> IO.puts l++r end)
end
