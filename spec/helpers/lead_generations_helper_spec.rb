require 'rails_helper'

RSpec.describe LeadGenerationsHelper, type: :helper do
  describe '#options_for_months' do
    it 'returns an options string for select with months' do
      expected_options = options_for_select((1..12).map { |num| [num, num] })
      expect(helper.options_for_months).to eq(expected_options)
    end
  end
end