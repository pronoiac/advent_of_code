#!/usr/bin/env ruby

require "byebug"
require "set"

debug = true
@on_left = Set.new
@on_right = Set.new

def handle(input)
  puts "input: " + input # if debug
  # example: fwft (72) -> ktlj, cntj, xhth

  parts = /(\S+) \((\d+)\)( -> (.+))?/.match(input)
  left = parts[1]
  weight = parts[2]
  right = parts[4]

  @on_left << left
  if right
  right.split(', ').each do |item|
      @on_right << item
    end
  end

  # debugger unless right.nil?
end

# read from stdin or given file
sum = 0
ARGF.each_line do |line|
  handle(line)
end
# debugger
puts "only on left: #{(@on_left - @on_right).first}"