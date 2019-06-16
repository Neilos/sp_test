# frozen_string_literal: true

# Processes log entries and compiles and outputs
# counts of visits for each path
class VisitsCounter
  def initialize(path_counts = Hash.new(0))
    @path_counts = path_counts
  end

  def process(log_entry)
    path_counts[log_entry.path] += 1
  end

  def to_s
    path_counts
      .sort_by { |path, count| [-count, path] } # descending order
      .map { |path, count| "#{path} #{count} visits" }
      .join(LINE_ENDING) << LINE_ENDING
  end

  private

  LINE_ENDING = "\n"

  attr_accessor :path_counts
end
