defmodule Aoc2016.Day2 do
  @moduledoc """
  Day 2: Bathroom Security

  Keypad like this

  1 2 3
  4 5 6
  7 8 9

  U moves up, D moves down, L moves left, and R moves right.

  Each line of instructions corresponds to one button,
  starting at the previous button (or, for the first line, the "5" button);
  press whatever button you're on at the end of each line.
  If a move doesn't lead to a button, ignore it.
  """

  @keypad %{
    {0, 0} => 1 , {1, 0} => 2, {2, 0} => 3,
    {0, 1} => 4 , {1, 1} => 5, {2, 1} => 6,
    {0, 2} => 7 , {1, 2} => 8, {2, 2} => 9
  }

  @init_state {0, 0}

  @input_file_path "priv/2016/day2.txt"

  @doc """
  iex> Aoc2016.Day2.move({1, 1}, "U")
  {1, 0}

  iex> Aoc2016.Day2.move({1, 0}, "L")
  {0, 0}

  iex> Aoc2016.Day2.move({0, 0}, "L")
  {0, 0}
  """
  def move(state, "U"), do: ignore_invalid_move(state, fn({x, y}) -> {x, y-1} end)
  def move(state, "D"), do: ignore_invalid_move(state, fn({x, y}) -> {x, y+1} end)
  def move(state, "L"), do: ignore_invalid_move(state, fn({x, y}) -> {x-1, y} end)
  def move(state, "R"), do: ignore_invalid_move(state, fn({x, y}) -> {x+1, y} end)
  def move(state, "\n"), do: Map.get(@keypad, state)

  def ignore_invalid_move(original_state, reducer) do
    new_state = reducer.(original_state)
    if valid_state?(new_state) do
      new_state
    else
      original_state
    end
  end

  @doc """
  iex> Aoc2016.Day2.resolve
  "18843"
  """
  def resolve do
    {:ok, agent} = Agent.start_link fn -> "" end

    @input_file_path
    |> File.stream!([:read], 1)
    |> Enum.reduce(@init_state, fn(c, state) ->
      new_position_or_code = move(state, c)

      if is_integer new_position_or_code do
        Agent.update(agent, fn(r) -> "#{r}#{new_position_or_code}" end)
        state
      else
        new_position_or_code
      end
    end)

     result = Agent.get(agent, fn(r) -> r end)
     Agent.stop(agent)
     result
  end

  defp valid_state?(state) do
    state in Map.keys(@keypad)
  end
end
