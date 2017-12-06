#!/usr/bin/env ruby

require "byebug"
require "set"

debug = true
blocks = []
seen = Set.new
step = 0

ARGF.each_line do |line|
  blocks = line.chomp.split.collect{|s| s.to_i}
end

def print_state(step, blocks)
  puts "step ##{step}: #{blocks.join("\t")}"
end

print_state(0, blocks)

while seen.add?(blocks)
  # already seen? returns nil and exits
  # process state
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

puts "steps: #{step}"