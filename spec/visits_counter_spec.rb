# frozen_string_literal: true

require 'visits_counter'
require 'log_entry'

RSpec.describe VisitsCounter do
  describe 'to_s' do
    let(:path_counts) { Hash.new(0) }

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
