defmodule Sort do
  @moduledoc """
    Implementation of sorting algorithms
  """

  def merge_and_sort(list) do
    merge_and_sort(list,0,length(list)-1)
  end

  def merge_and_sort(list, left, right) do
    case {left,right} do
      {left,right} when left < right ->
        middle = div(left+right,2)
        left_length = middle-left+1
        right_length = (right-middle)*-1

        left_list = list
                    |> Enum.take(left_length)
        
        right_list = list
                     |> Enum.take(right_length)


        merge_and_sort(left_list, left, middle)
        |> merge(merge_and_sort(right_list, middle+1, right),[])
      _ ->
        list
    end
  end

  defp merge(left_list, right_list, merged_list) do
    case {left_list,right_list} do
      {[],[]} ->
        merged_list
        |> Enum.reverse
      {_,[]} ->
        reversed_list = merged_list
                        |> Enum.reverse 
        reversed_list ++ left_list
      {[],_} ->
        reversed_list = merged_list
                        |> Enum.reverse
        reversed_list ++ right_list
      {[head_left | tail_left],[head_right | tail_right]} ->

        case head_left <= head_right do
          true ->
            merge(tail_left, right_list, [head_left | merged_list])
          false ->
            merge(left_list, tail_right, [head_right | merged_list])
        end
    end
  end

end
