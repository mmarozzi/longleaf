
require 'rails_helper'

RSpec.describe LoanProfit, type: :model do
  let(:loan) { FactoryBot.create(:loan) }
  let(:loan_profit) { FactoryBot.build(:loan_profit, loan:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(loan_profit).to be_valid
    end

    it 'is not valid without a max_loan_amount_purchase_price' do
      loan_profit.max_loan_amount_purchase_price = nil
      expect(loan_profit).to_not be_valid
    end

    it 'is not valid without a max_loan_amount_arv' do
      loan_profit.max_loan_amount_arv = nil
      expect(loan_profit).to_not be_valid
    end

    it 'is not valid without a loan_amount' do
      loan_profit.loan_amount = nil
      expect(loan_profit).to_not be_valid
    end

    it 'is not valid without a total_interest_expense' do
      loan_profit.total_interest_expense = nil
      expect(loan_profit).to_not be_valid
    end

    it 'is not valid without an estimated_profit' do
      loan_profit.estimated_profit = nil
      expect(loan_profit).to_not be_valid
    end

    it 'is not valid with negative numerical values' do
      loan_profit.max_loan_amount_purchase_price = -1
      expect(loan_profit).to_not be_valid

      loan_profit.max_loan_amount_arv = -1
      expect(loan_profit).to_not be_valid

      loan_profit.loan_amount = -1
      expect(loan_profit).to_not be_valid

      loan_profit.total_interest_expense = -1
      expect(loan_profit).to_not be_valid

      loan_profit.estimated_profit = -1
      expect(loan_profit).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to loan' do
      expect(loan_profit).to belong_to(:loan)
    end
  end
end
