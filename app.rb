#!/usr/bin/env ruby

@cache = {}

data = %w(Mamma ZiaRita Ivo Travis Lello Antonella ZioEnzo Dino)

def key left, right
  "#{left}--#{right}"
end

def merge_sort ary
  # adding here a check for ary.size == 1 would make it faster
  left, right = ms_split ary
  return left if right.size == 0
  ms_merge merge_sort(left), merge_sort(right)
end

def ask_for_comparison first, second
  puts "If you had to invite only one person (or group) who would you invite?"
  puts "1) #{first}"
  puts "2) #{second}"
  result = gets
  if ["1", "2"].include? result.strip
    result.strip == "1" ? -1 : 1
  else
    ask_for_comparison first, second
  end
end

def compare first, second
  @cache[key(first, second)] ||= ask_for_comparison first, second
end

def ms_split ary
  results = {left: [], right: []}
  target = :left
  ary.each do |item|
    if results[target].empty?
      puts "empty"
      results[target] << item
    elsif compare(item, results[target].last) > 0
      results[target] << item
    else
      target = target == :left ? :right : :left
      results[target] << item
    end
  end
  [results[:left], results[:right]]
end

def ms_merge left, right
  results = []
  target_size = left.size + right.size
  while results.size < target_size do
    if left.size == 0
      results << right.shift
    elsif right.size == 0
      results << left.shift
    elsif compare(left.first, right.first) < 0
      results << left.shift
    else
      results << right.shift
    end
  end
  results
end

puts merge_sort(data).inspect
