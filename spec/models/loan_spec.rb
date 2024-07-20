# spec/models/loan_spec.rb

require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { FactoryBot.build(:loan) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(loan).to be_valid
    end

    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:loan_term) }
    it { should validate_presence_of(:purchase_price) }
    it { should validate_presence_of(:repair_budget) }
    it { should validate_presence_of(:after_repair_value) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }

    it { should validate_inclusion_of(:loan_term).in_range(1..12) }

    it { should validate_numericality_of(:purchase_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:repair_budget).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:after_repair_value).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_one(:loan_profit).dependent(:destroy) }
  end
end
