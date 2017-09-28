defmodule Aoc2016.Day3 do
  @moduledoc """
  Day 3: Squares With Three Sides

  In a valid triangle, the sum of any two sides must be larger than the remaining side.
  """

  @input_file_path "priv/2016/day3.txt"

  @doc """
  iex> Aoc2016.Day3.resolve()
  917
  """
  def resolve do
    @input_file_path
    |> File.stream!([:read], :line)
    |> Enum.filter(fn (l) ->
      valid_triangle?(l)
    end)
    |> length
  end

  @doc """
  iex> Aoc2016.Day3.valid_triangle?("5 10 25")
  false
  """
  def valid_triangle?(line) do
    [x, y, z] = line |> to_int

    ((x + y) > z) and ((y + z) > x) and ((x + z) > y)
  end

  def to_int(line) do
    line
    |> String.split(~r/\W+/)
    |> Stream.filter(fn(w) -> String.trim(w)  != "" end)
    |> Enum.map(fn(x) ->
      {n, _} = Integer.parse(x)
      n
    end)
  end
end
