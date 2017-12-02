#!/usr/bin/env ruby

require "byebug"

debug = true

def handle(line)
  puts "line: " + line # if debug
  # debugger
  numbers = line.chomp.split.collect{|s| s.to_i}
  for pos1 in numbers #0..numbers.length
    for pos2 in numbers #0..numbers.length
      next if pos1 == pos2
      if pos1 % pos2 == 0
        div = pos1 / pos2
        puts "div: #{div}"
        return div
      end
    end
  end
end



# read from stdin or given file
sum = 0
ARGF.each_line do |line|
  sum += handle(line)
end
puts "sum: #{sum}"