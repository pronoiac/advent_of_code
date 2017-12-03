#!/usr/bin/env ruby

require "byebug"



def log(str)
  debug = false
  puts str if debug
end


def last_item(layer)
  (layer * 2 + 1) ** 2
end

def calc_layer(num)
  # could calculate this directly, but math is hard :P
  # going se
  layer = 0
  # layers: 1, 9, 25
  while (last_item(layer) < num) do
    layer += 1
  end
  # layer -= 1
  log "layer: #{layer}"
  return layer
end

def handle(line)
  input = line.to_i
  puts "# input: #{input}"
  # figure out layer.
  layer = calc_layer(input)
  dist = 2 * layer
  diff = last_item(layer) - input
  if diff == 0 # on a corner
    puts "dist: #{dist}"
    return dist
  end

  log "diff: #{diff}"
  edge_length = layer * 2

  dist_from_corner = [diff % edge_length, -diff % edge_length].min
  log "dist from corner: #{dist_from_corner}"

  dist -= dist_from_corner
  puts "# dist: #{dist}"
  # debugger
  return dist
end

# read from stdin or given file
sum = 0
ARGF.each_line do |line|
  handle(line)
end
