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

xlsx = Roo::Spreadsheet.open filename

data = xlsx.sheet(0).parse(who: "Chi", people: "Persone")
puts data.inspect

include MergeSort

@cache = {}

i = 1

merge_sort(data).each do |item|
  puts "#{i}. #{item[:who]}"
  i+=item[:people]
end
