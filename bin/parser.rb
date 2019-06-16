#!/usr/bin/env ruby
# frozen_string_literal: true

begin
  LogParser.new(file_name).parse do |log_entry|
    puts log_entry
  end
rescue LogParser::NonExistentFile => error
  puts error
end
