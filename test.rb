#!/usr/bin/env ruby

require './lib/second_curtain'

data  = File.read("Demo/sample_output.txt")

parser = Parser.new()

# data.split("\n").each do |line|
#   parser.parse_line(line)
# end

# puts parser.latest_test_suite