# frozen_string_literal: true

require 'log_parser'

RSpec.describe LogParser do
  let(:log_parser) { described_class.new }

  describe 'parse' do
    context 'when given a valid file path' do
      let(:file_name) { 'spec/fixtures/small-webserver.log' }

      let(:dummy_entry1) { instance_double('LogEntry') }
      let(:dummy_entry2) { instance_double('LogEntry') }
      let(:dummy_entry3) { instance_double('LogEntry') }
      let(:line1) { '/help_page/1 126.318.035.038' }
      let(:line2) { '/contact 184.123.665.067' }
      let(:line3) { '/index 444.701.448.104' }

      before do
        allow(LogEntry).to receive(:new).with(line1).and_return(dummy_entry1)
        allow(LogEntry).to receive(:new).with(line2).and_return(dummy_entry2)
        allow(LogEntry).to receive(:new).with(line3).and_return(dummy_entry3)
      end

      it 'parses file and yields log entries' do
        expect(LogEntry).to receive(:new).with(line1)
        expect(LogEntry).to receive(:new).with(line2)
        expect(LogEntry).to receive(:new).with(line3)

        expect do |blk|
          log_parser.parse(file_name, &blk)
        end.to yield_successive_args(
          dummy_entry1, dummy_entry2, dummy_entry3
        )
      end
    end
  end
end
