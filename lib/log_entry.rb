# frozen_string_literal: true

# Deconstructs a log line into component data elements and stores them
# for easier consumption by other classes
class LogEntry
  def initialize(log_line)
    @path, @ip_address = *log_line.split(' ')
  end

  attr_reader :path, :ip_address
end
