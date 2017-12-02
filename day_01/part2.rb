#!/usr/bin/env ruby

require "byebug"

def handle(line)
  sum = 0
  digits = line.chomp.split("")
  places = digits.count
  steps = places / 2
  for place in 0..places
    # puts digits[place]
    # debugger
    if digits[place] == digits[(place + steps) % places]
      sum += digits[place].to_i
    end
  end
  # debugger
  puts "line: " + line
  puts "sum: " + sum.to_s
  sum
end



# read from stdin or given file
ARGF.each_line { |line| handle(line) }
