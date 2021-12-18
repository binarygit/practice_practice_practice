#!/usr/bin/ruby

class MergeSort
  def sort(array)
    return array if array.size.eql?(1) || array.empty?

    sorted_array = []
    length = start = array.size / 2

    left_array = sort(array[0, length])
    right_array = sort(array[start..-1])

    loop do
      break if left_array.empty? && right_array.empty?

      (sorted_array << right_array.shift; next) if left_array.empty?
      (sorted_array << left_array.shift; next) if right_array.empty?

      case left_array <=> right_array
      when -1 then sorted_array << left_array.shift
      when 1 then sorted_array << right_array.shift
      else        sorted_array << left_array.shift end
    end

    sorted_array
  end
end
