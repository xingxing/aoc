defmodule Aoc2016.Day1 do
  @moduledoc "Day 1: No Time for a Taxicab"

  @init_state {0, 0, :N}

  @input_file_path "priv/2016/day1.txt"

  @doc """
  move

  iex> Aoc2016.Day1.move({0, 0, :N}, "R2")
  {2, 0, :W}

  iex> Aoc2016.Day1.move({2, 0, :W}, "L3")
  {2, 3, :N}
  """
  def move({x, y, :N}, "L" <> steps), do: {x-to_int(steps), y, :E}
  def move({x, y, :N}, "R" <> steps), do: {x+to_int(steps), y, :W}
  def move({x, y, :S}, "L" <> steps), do: {x+to_int(steps), y, :W}
  def move({x, y, :S}, "R" <> steps), do: {x-to_int(steps), y, :E}

  def move({x, y, :E}, "L" <> steps), do: {x, y-to_int(steps), :S}
  def move({x, y, :E}, "R" <> steps), do: {x, y+to_int(steps), :N}
  def move({x, y, :W}, "L" <> steps), do: {x, y+to_int(steps), :N}
  def move({x, y, :W}, "R" <> steps), do: {x, y-to_int(steps), :S}

  @doc """
  iex> Aoc2016.Day1.shortest_path_destination({2, 3, :N})
  5
  """
  def shortest_path_destination({x, y, _}) do
    {xi, yi, _} = @init_state
    abs(x-xi) + abs(y-yi)
  end

  @doc """
  right answer

  iex> Aoc2016.Day1.resolve
  279
  """
  def resolve do
    @input_file_path
    |> File.read!
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> List.foldl(@init_state, fn(command, state) ->
      state |> move(command)
    end)
    |> shortest_path_destination
  end

  defp to_int(steps) do
    case Integer.parse(steps) do
      {s, _} -> s
      :error -> raise("Wrong move command")
    end
  end
end
