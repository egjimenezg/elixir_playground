defmodule Problems.NumberSequenceTest do

  use ExUnit.Case

  alias Problems.NumberSequence
  
  test "get the number of combinations for the inputs" do
    assert NumberSequence.number_of_sequences("1234") == 3
    assert NumberSequence.number_of_sequences("0123") == 0
    assert NumberSequence.number_of_sequences("1111") == 5
    assert NumberSequence.number_of_sequences("22222") == 8
  end

end
