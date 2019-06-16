# frozen_string_literal: true

require 'unique_views_counter'

RSpec.describe UniqueViewsCounter do
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
