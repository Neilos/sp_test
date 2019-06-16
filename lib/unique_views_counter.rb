# frozen_string_literal: true

require 'set'

# Processes log entries and compiles and outputs
# counts of unique views for each path
class UniqueViewsCounter
  def initialize(path_ips = {})
    @path_ips = path_ips
  end

  def to_s
    path_ips
      .sort_by { |path, ips| [-ips.count, path] } # descending order
      .map { |path, ips| "#{path} #{ips.count} unique views" }
      .join(LINE_ENDING) << LINE_ENDING
  end

  private

  LINE_ENDING = "\n"

  attr_reader :path_ips
end
