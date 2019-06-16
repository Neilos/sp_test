#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

require_relative '../lib/log_parser'
require_relative '../lib/unique_views_counter'
require_relative '../lib/visits_counter'

options = {}
options[:counter] = VisitsCounter.new # Counts visits by default

option_parser = OptionParser.new do |opts|
  opts.banner = '
    Usage: ./bin/parser webserver.log --count [visits/unique_views]
  '

  opts.on(
    '-c', '--count COUNT', %i[visits unique_views],
    'Select count type (visits, unique_views)'
  ) do |count|
    options[:counter] = UniqueViewsCounter.new if count == :unique_views
  end

  opts.on('-h', '--help', 'Prints help') do
    puts opts
    exit
  end
end

option_parser.parse!
file_name = ARGV[0]
counts = options[:counter]

begin
  LogParser.new.parse(file_name) do |log_entry|
    counts.process(log_entry)
  end

  puts counts
rescue LogParser::NonExistentFile => error
  puts error
end
