#!/usr/bin/env ruby

require "byebug"
require "set"

debug = true
@registers = Hash.new(0)

def compare(conditional)
  # debugger
  puts "comparison: #{conditional}"
  parts = /(\S+)\ ([\!=<>]+)\ (-?\d+)/.match(conditional)
  # debugger
  left, comparator, right = parts[1, 3]
  register = @registers[left]
  val = right.to_i
  result = case comparator
  when ">"
    register > val
  when "<"
    register < val
  when "=="
    register == val
  when ">="
    register >= val
  when "<="
    register <= val
  when "!="
    register != val
  else
    puts "warning: unknown operator '#{comparator}' within #{conditional}!"
  end
  puts "#{conditional} = #{result}"
  result
end

def perform(command)
  parts = /(\S+)\ (...)\ (-?\d+)/.match(command)
  register_name, operator, right = parts[1, 3]
  register = @registers[register_name]
  delta = right.to_i
  new_val = case operator
  when "inc"
    register + delta
  when "dec"
    register - delta
  else
    puts "warning: unknown operator '#{operator}' within #{command}!"
  end
  @registers[register_name] = new_val
  # debugger
  puts "#{command} -> #{new_val}"
end

def handle(input)
  # puts "input: " + input # if debug
  # example: fwft (72) -> ktlj, cntj, xhth

  parts = /(.+)\ if\ (.+)/.match(input)
  cmd = parts[1]
  conditional = parts[2]
  # puts "cmd / cond: #{reg_mod} / #{conditional}"
  # puts "cond: #{conditional}"
  # puts "cmd: #{cmd}"

  if compare(conditional)
    perform(cmd)
  end
  
  # debugger
  # puts "holding"
end

# read from stdin or given file
sum = 0
ARGF.each_line do |line|
  handle(line)
end
# debugger

# debugger
puts "largest value: #{@registers.values.max}"
