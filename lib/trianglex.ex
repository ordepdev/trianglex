defmodule Trianglex do
  @blank " "
  @moduledoc """
  Documentation for Trianglex.
  """

  defstruct [:value]

  @doc """

  """
  def empty(rows) do
    Range.new(1, rows)
    |> Enum.reduce([], fn _, acc ->
      acc ++ [List.duplicate(@blank, rows)]
    end)
  end

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
    |> Enum.reduce([], fn row, acc ->
      acc ++ [List.duplicate("*", row)]
    end)
  end

  def right(rows, :down) do
    Range.new(rows, 1)
    |> Enum.reduce([], fn row, acc ->
      acc ++ [List.duplicate("*", row) ++ List.duplicate(@blank, rows - row)]
    end)
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
    |> Enum.reduce([], fn row, acc ->
      acc ++ [List.duplicate(@blank, rows - row) ++ List.duplicate("*", row)]
    end)
  end

  def left(rows, :down) do
    Range.new(rows, 1)
    |> Enum.reduce([], fn row, acc ->
      acc ++ [List.duplicate(@blank, rows - row) ++ List.duplicate("*", row)]
    end)
  end

  @doc """
  Mirrors a given triangle.

  ## Examples

      iex> Trianglex.left(2) |> Trianglex.mirror
      [["*"," "], ["*", "*"]]

      iex> Trianglex.left(3) |> Trianglex.mirror
      [["*"," "," "], ["*", "*"," "], ["*", "*", "*"]]

  """
  def mirror(triangle) do
    triangle
    |> Enum.map(fn row -> Enum.reverse(row) end)
  end

  @doc """
  Takes two triagnles and combine them together.

  This can be used to create larger triangles from smaller ones.

  ## Examples
  
      iex> Trianglex.left(2) |> Trianglex.combine(Trianglex.right(2))
      [[" ","*","*"], ["*","*","*","*"]]

  """
  def combine(left, right) do
    left
    |> Enum.zip(right)
    |> Enum.map(fn {l,r} -> l ++ r end)
  end

  @doc """
  It prints our triangle, yay!
  """
  def print(triangle) do
    Enum.each(triangle, fn row -> IO.puts(row) end)
  end
end
