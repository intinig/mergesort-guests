#!/usr/bin/env ruby

require __dir__ + "/merge_sort"
require "roo"
require "optparse"
require "rutui"

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

# merge_sort(data).each do |item|
#   puts "#{i}. #{item[:who]}"
#   i+=item[:people]
# end

RuTui::Theme.use :light

screen = RuTui::Screen.new
screen.add_static RuTui::Text.new({ :x => 1, :y  => 1, :text => "use WASD or q/CTRL+C to quit", :rainbow => true })
@textfield = RuTui::Textfield.new({ :x => 2, :y => 2 })
screen.add @textfield

RuTui::ScreenManager.add :default, screen

RuTui::ScreenManager.loop({ :autofit => true, :autodraw => false }) do |key|
	break if key == 3 or key.chr == "q" # 3 = CTRL+C
  @textfield.write key
end
