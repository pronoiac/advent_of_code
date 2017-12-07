#!/usr/bin/env ruby

require "byebug"
require "set"

@debug = false
@on_left = Set.new
@on_right = Set.new
@weights = Hash.new(0)
@above = Hash.new #(Array.new())

def debuglog(str)
  return unless @debug
  puts str
end

def handle(input)
  puts "input: " + input # if debug
  # example: fwft (72) -> ktlj, cntj, xhth

  parts = /(\S+) \((\d+)\)( -> (.+))?/.match(input)
  left = parts[1]
  weight = parts[2].to_i
  right = parts[4]
  @weights[left] = weight

  @on_left << left
  if right
    right.split(', ').each do |item|
      debuglog "#{left} - #{item}"
      # debugger
      @on_right << item

      above_disc = @above[left] || Array.new
      above_disc << item
      @above[left] = above_disc

      # @above[left] << item
      # debugger
    end
  end

  # debugger unless right.nil?
end

def weight_above(disc, emit = false)
  debuglog "weight above: #{disc}" if emit

  return @weights[disc] if @above[disc].nil?

  disc_a = @above[disc].first

  stack = weight_above(disc_a)
  subsum = 0
  matching = true

  debuglog "disc #{disc}: #{@weights[disc]}: " if emit

  @above[disc].each do |disc|
    weight_above_disc = weight_above(disc)
    puts "  #{disc}: #{@weights[disc]} + #{weight_above_disc - @weights[disc]} = #{weight_above_disc}" if emit || @debug
    if weight_above_disc != stack
      # puts "mismatch!"
      matching = false
    end
    subsum += stack
  end

  unless matching || emit
    puts "mismatch!"
    weight_above(disc, emit = true)
    # this is ugly: then, eyeball the sums, and adjust the first part as needed.
  end

  @weights[disc] + subsum
end

# read from stdin or given file
sum = 0
ARGF.each_line do |line|
  handle(line)
end
# debugger

bottom = (@on_left - @on_right).first
weight_above(bottom)
