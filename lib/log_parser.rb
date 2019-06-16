# frozen_string_literal: true

require_relative 'log_entry'

# Opens a log file and yields log entries
class LogParser
  class NonExistentFile < StandardError; end

  def parse(file_name)
    ensure_file_exists!(file_name)

    File.foreach(file_name) do |line|
      yield LogEntry.new(line.chomp) if block_given?
    end
  end

  private

  def ensure_file_exists!(file_name)
    return if File.exist?(file_name)

    raise NonExistentFile, "Sorry, file <#{file_name}> doesn't exist"
  end
end
