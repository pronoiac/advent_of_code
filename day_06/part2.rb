#!/usr/bin/env ruby

require "byebug"
require "set"

debug = true
blocks = []
seen = Hash.new(0)
step = 0

ARGF.each_line do |line|
  blocks = line.chomp.split.collect{|s| s.to_i}
end

def print_state(step, blocks)
  puts "step ##{step}: #{blocks.join("\t")}"
end

print_state(0, blocks)

until seen[blocks] != 0
  # already seen? returns nil and exits
  # process state
  seen[blocks] = step
  max_index = blocks.index(blocks.max)
  source = blocks[max_index]
  blocks[max_index] = 0

  dest_block = (max_index + 1) % blocks.length
  while source > 0
    blocks[dest_block] += 1
    source -= 1
    dest_block = (dest_block + 1) % blocks.length
  end
  step += 1

  # debugger
  print_state(step, blocks)
end

puts "steps in loop: #{step - seen[blocks]}"