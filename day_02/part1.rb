#!/usr/bin/env ruby

require "byebug"

debug = true

def handle(line)
  puts "line: " + line # if debug
  # debugger
  numbers = line.chomp.split.collect{|s| s.to_i}
  result = numbers.max - numbers.min
  puts "min: #{numbers.min}, max: #{numbers.max}, result: #{result}"
  return result
end



# read from stdin or given file
sum = 0
ARGF.each_line do |line|
  sum += handle(line)
end
puts "sum: #{sum}"