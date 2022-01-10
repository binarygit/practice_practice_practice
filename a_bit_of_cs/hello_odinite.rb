#!/usr/bin/ruby
# I wanted to do something like this for a long time, but only ended up doing it when someone in the Discord Chat made this because the new Matrix movie was coming out. I love this. Also, after almost a year into programming I am glad I could finally come up with a simple solution like this. 3 months ago, No Chance!

str = "Hello Odin player...welcome to the tic-tac-toe matrix...we've been waiting for you! ^_^"
 char = str.chars

 char.each do |char|
   print char
   sleep 0.25
 end


