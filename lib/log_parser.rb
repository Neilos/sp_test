# frozen_string_literal: true

require_relative 'log_entry'

# Opens a log file and yields log entries
class LogParser
  def parse(file_name)
    File.foreach(file_name) do |line|
      yield LogEntry.new(line.chomp) if block_given?
    end
  end
end
