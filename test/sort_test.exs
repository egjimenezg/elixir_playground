defmodule SortTest do
  use ExUnit.Case

  test "sort the list using merge and sort" do
    list = [2,-4,9,11,23,-2]
    assert Sort.merge_and_sort(list) == [-4,-2,2,9,11,23]
  end

end
