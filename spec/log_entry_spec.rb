# frozen_string_literal: true

require 'log_entry'

RSpec.describe LogEntry do
  let(:log_line) { '/some/path/1 127.0.0.1' }
  let(:log_entry) { described_class.new(log_line) }

  describe 'path' do
    subject { log_entry.path }

    it 'is the path extracted from the log_line' do
      expect(subject).to eq('/some/path/1')
    end
  end

  describe 'ip_address' do
    subject { log_entry.ip_address }

    it 'is the ip_address extracted from the log_line' do
      expect(subject).to eq('127.0.0.1')
    end
  end
end
