#!/usr/bin/env ruby

require "byebug"

debug = true

def handle(input)
  puts "input: " + input # if debug
  # debugger
  seen = Hash.new(0)
  words = input.split
  words.each do |word|
    word = word.split('').sort
    if seen[word] != 0
      puts "result: duplicate: #{word}"
      return 0
    end
    seen[word] += 1
  end
  puts "result: valid"
  1
end



# read from stdin or given file
sum = 0
ARGF.each_line do |line|
  sum += handle(line)
end
puts "sum: #{sum}"