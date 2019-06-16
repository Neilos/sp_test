# frozen_string_literal: true

require 'visits_counter'
require 'log_entry'

RSpec.describe VisitsCounter do
  let(:path_counts) { Hash.new(0) }

  describe 'process' do
    before do
      path_counts['/hello'] = 1
      path_counts['/goodbye'] = 4
      path_counts['/wasssup'] = 3
    end

    context 'when path already has a record in path_counts' do
      let(:log_entry) { LogEntry.new('/wasssup 123.456.789') }

      it 'increments the relevant path count' do
        visits_counter = described_class.new(path_counts)
        visits_counter.process(log_entry)

        expect(visits_counter.to_s).to eq(
          <<~OUTPUT
            /goodbye 4 visits
            /wasssup 4 visits
            /hello 1 visits
          OUTPUT
        )
      end
    end

    context 'when path does NOT already have a record in path_counts' do
      let(:log_entry) { LogEntry.new('/happy/2/see/u 123.456.789') }

      it 'stores a path count of 1 under for the corresonding path' do
        visits_counter = described_class.new(path_counts)
        visits_counter.process(log_entry)

        expect(visits_counter.to_s).to eq(
          <<~OUTPUT
            /goodbye 4 visits
            /wasssup 3 visits
            /happy/2/see/u 1 visits
            /hello 1 visits
          OUTPUT
        )
      end
    end
  end

  describe 'to_s' do
    before do
      path_counts['/hello'] = 2
      path_counts['/goodbye'] = 4
      path_counts['/wasssup'] = 3
    end

    it 'prints an ordered list of paths with visit counts' do
      expect(described_class.new(path_counts).to_s).to eq(
        <<~OUTPUT
          /goodbye 4 visits
          /wasssup 3 visits
          /hello 2 visits
        OUTPUT
      )
    end
  end
end
