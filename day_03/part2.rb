#!/usr/bin/env ruby

require "byebug"

def log(str)
  debug = false
  puts str if debug
end

@values = Hash.new(0)
@values[[0, 0]] = 1
@target = 277678

def sum_neighbors(x, y)
  neighbors = [
    [-1,  1], [0,  1], [1,  1],
    [-1,  0],          [1,  0],
    [-1, -1], [0, -1], [1, -1]
  ]

  return 1 if [x, y] == [0, 0]

  sum = 0
  neighbors.each do |neighbor|
    x_d, y_d = neighbor
    # puts "neighbor: (#{x_d}, #{y_d}) = #{@values[[x + x_d, y + y_d]]}"
    sum += @values[[x + x_d, y + y_d]]
  end

  puts "(#{x}, #{y}) = #{sum}"
  sum
end

def last_item(layer)
  (layer * 2 + 1) ** 2
end

def calc_item(x, y)
  item = sum_neighbors(x, y)
  @values[[x, y]] = item
  if item > @target
    puts "solution found!"
    exit 0
  end
  item
end

def calc_layers
  # go up, left, down, right.
  layer = 0
  x, y = 0, 0

  while true # do a layer.
    # U layer * 2 - 1
    puts "up"
    (layer * 2 - 1).times do
      y += 1
      calc_item(x, y)
    end

    # L layer * 2
    puts "left"
    (layer * 2).times do
      x -= 1
      calc_item(x, y)
    end

    # D layer * 2
    puts "down"
    (layer * 2).times do
      y -= 1
      calc_item(x, y)
    end

    # R layer * 2 + 1
    puts "right"
    (layer * 2 + 1).times do
      x += 1
      calc_item(x, y)
    end

    layer += 1
  end # /layer

  puts "solved?" # shouldn't get here.
end

calc_layers