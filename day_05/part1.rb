#!/usr/bin/env ruby

require "byebug"

debug = true
jumps = []

ARGF.each_line do |line|
  jumps << line.to_i
end

pointer = 0
steps = 0

def emit_jumps(steps, pointer, jumps)
  print "step ##{steps}:\t"
  unless pointer == 0
    print " #{jumps.slice(0, pointer).join('  ')} "
  end

  print "(#{jumps[pointer]})"

  puts " #{jumps.slice(pointer + 1, jumps.length).join('  ')}"
end

emit_jumps(steps, pointer, jumps)

while pointer < jumps.length
  # jump and increment
  emit_jumps(steps, pointer, jumps)
  value = jumps[pointer]
  jumps[pointer] += 1
  steps += 1
  pointer += value
end

emit_jumps(steps, 0, jumps)

puts "steps: #{steps}"