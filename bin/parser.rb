#!/usr/bin/env ruby
# frozen_string_literal: true

LogParser.new(file_name).parse do |log_entry|
  puts log_entry
end
