#!/usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: log_analyzer.rb [options]"

  opts.on("-fFILE", "--file=FILE", "Log file to analyze") do |f|
    options[:file] = f
  end

  opts.on("-eEXPR", "--error=EXPR", "Error expression to search for") do |e|
    options[:error] = e
  end
end.parse!

unless options[:file] && options[:error]
  puts "Both --file and --error options are required."
  exit
end

count = 0
File.foreach(options[:file]) do |line|
  count += 1 if line.include?(options[:error])
end

puts "The term '#{options[:error]}' appeared #{count} times in #{options[:file]}."
