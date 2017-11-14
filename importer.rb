#!/usr/bin/env ruby

require "roo"
require "optparse"
require "sequel"
require "#{__dir__}/db"

filename = ""
owner = ""
clean = nil

OptionParser.new do |opts|
  opts.banner = "Usage: importer.rb [options]"

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

  opts.on("-f", "--file FILENAME", "Input File") do |v|
    filename = v
  end

  opts.on("-o", "--owner OWNER", "Whose guests are these?") do |o|
    if %w(GIOVANNI VERA COMMON).include? o.upcase
      owner = o.upcase[0]
    else
      puts "I only recognize GIOVANNI, VERA or COMMON"
      exit
    end
  end

  opts.on("--clean", "Force clean DB") do |c|
    clean = true
  end
end.parse!

xlsx = Roo::Spreadsheet.open filename
sheet_idx = case owner
when 'G'
  1
when 'V'
  2
when 'C'
  3
else
  puts "BAD OWNER"
  exit
end

data = xlsx.sheet(sheet_idx).parse(who: "Name", people: "PAX")

if clean
  puts "Force cleaning..."
  DB.run("DELETE FROM guest WHERE owner='#{owner}'")
  DB.run("DELETE FROM cache")
end


data.each_with_index do |record, idx|
  puts "#{idx}. #{record[:who]} (#{record[:people]})"
  GUESTS.insert name: record[:who], pax: record[:people].to_i, idx: idx, owner: owner
end
