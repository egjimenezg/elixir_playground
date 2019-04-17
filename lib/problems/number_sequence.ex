defmodule Problems.NumberSequence do
  @moduledoc """
    Given the letters code
    a -> 1
    b -> 2
    .
    .
    z -> 26,
    find the number of the combinations for a given number

    Example: 

    Input: 1234
    Output: 3

    The number can be represented by 'abcd','lcd' or 'awd'
  """

  def number_of_sequences(input) do
    numbers = input
              |> String.split("", trim: true)
              |> Enum.map(&String.to_integer(&1))

    case are_all_numbers_valid?(numbers) do
      true ->
        1 + get_pairs_combinations(numbers,0,0)
      false -> 0
    end

  end

  defp get_pairs_combinations([],combinations_number,_), do: combinations_number

  defp get_pairs_combinations([head|tail],combinations_number,adjacent_occurrences) do
    case tail do
      [] ->
        get_pairs_combinations(tail,combinations_number,adjacent_occurrences)
      _ ->
        pair = (head*10)+List.first(tail)

        {occurrences,combinations_number} =
          case is_valid_number(pair) do
            true ->
              occurrences= 1+combinations_number-adjacent_occurrences
              {occurrences, occurrences+combinations_number}
            false ->
              {0,combinations_number}
          end

        get_pairs_combinations(tail,combinations_number,occurrences)
    end 
  end

  defp are_all_numbers_valid?(numbers) do
    numbers
    |> Enum.all?(fn(number) ->
      number
      |> is_valid_number 
    end)
  end

  defp is_valid_number(number) do
    number > 0 and number <= 26
  end

end
