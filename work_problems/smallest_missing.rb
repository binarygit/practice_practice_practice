#!/usr/bin/ruby
# Given a sorted array of distinct non-negative integers, Write a program to find the smallest missing element in it.

def small_missing(array)
  array.each_cons(2) do |elem, next_elem|
    if next_elem != elem.succ
      return "Smallest missing element is #{elem.succ}"
    end
  end
  return 'This array has no missing element in its order'
end

p small_missing([0, 1, 2, 6, 9, 11, 15])
p small_missing([0])
