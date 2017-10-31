#!/usr/bin/env ruby

require __dir__ + "/merge_sort"
require "roo"
require "optparse"

filename = ""

OptionParser.new do |opts|
  opts.banner = "Usage: app.rb [options]"

  opts.on("-f", "--file FILENAME", "Input File") do |v|
    filename = v
  end
end.parse!

include MergeSort

@cache = {}

data = %w(Mamma ZiaRita Ivo Travis Lello Antonella ZioEnzo Dino)

puts merge_sort(data).inspect
