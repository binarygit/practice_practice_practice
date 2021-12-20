#!/usr/bin/ruby
require 'pry-byebug'

class BinarySearch
  def search(arr, sought_obj, st_idx = 0, end_idx = arr.size - 1)
    return 'Sought object is not in array' if st_idx > end_idx

    center = (st_idx + end_idx) / 2
    poten_obj = arr[center]
    return "#{sought_obj} is in #{center} index" if poten_obj.eql?(sought_obj)
    return search(arr, sought_obj, center.succ) if poten_obj < sought_obj
    return search(arr, sought_obj, st_idx, center.pred) if poten_obj > sought_obj
  end
end

puts BinarySearch.new.search([1, 2, 3, 4, 5], 6)
puts BinarySearch.new.search([1, 2, 3, 4, 5], 1)
puts BinarySearch.new.search([1, 2, 3, 4, 5], 2)
