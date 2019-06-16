# frozen_string_literal: true

require 'unique_views_counter'

RSpec.describe UniqueViewsCounter do
  describe '#process' do
    let(:unique_views_counter) { described_class.new }

    context 'when view for given path has NOT already been recorded' do
      let(:log_entry1) { LogEntry.new('/hello 123.456.789') }
      let(:log_entry2) { LogEntry.new('/goodbye 123.456.789') }

      it 'stores a path count of 1 under for the corresonding path' do
        unique_views_counter.process(log_entry1)

        expect(unique_views_counter.to_s).to eq(
          <<~OUTPUT
            /hello 1 unique views
          OUTPUT
        )

        unique_views_counter.process(log_entry2)

        expect(unique_views_counter.to_s).to eq(
          <<~OUTPUT
            /goodbye 1 unique views
            /hello 1 unique views
          OUTPUT
        )
      end
    end

    context 'when view for given path has already been recorded' do
      let(:log_entry1) { LogEntry.new('/wasssup 123.456.789') }
      let(:log_entry2) { LogEntry.new('/wasssup 123.456.789') }

      it 'does NOT add a new entry' do
        unique_views_counter.process(log_entry1)

        expect(unique_views_counter.to_s).to eq(
          <<~OUTPUT
            /wasssup 1 unique views
          OUTPUT
        )

        unique_views_counter.process(log_entry2)

        # Still the same
        expect(unique_views_counter.to_s).to eq(
          <<~OUTPUT
            /wasssup 1 unique views
          OUTPUT
        )
      end
    end
  end

  describe 'to_s' do
    subject { unique_views_counter.to_s }

    let(:unique_views_counter) { described_class.new(path_ips) }

    let(:path_ips) do
      {
        '/hello' => ['123.456.789', '789.456.123'],
        '/goodbye' => [
          '123.456.789', '789.456.123', '345.678.912', '987.654.321'
        ],
        '/wasssup' => ['123.456.789', '789.456.123', '987.654.321']
      }
    end

    it 'prints an ordered list of paths with visit counts' do
      expect(subject).to eq(
        <<~OUTPUT
          /goodbye 4 unique views
          /wasssup 3 unique views
          /hello 2 unique views
        OUTPUT
      )
    end
  end
end
