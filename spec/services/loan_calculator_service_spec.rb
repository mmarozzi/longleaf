# spec/services/loan_calculator_service_spec.rb

require 'rails_helper'

RSpec.describe LoanCalculatorService do
  describe '#call' do
    let(:loan) do
      create(:loan,
        purchase_price: 200000.0,
        after_repair_value: 300000.0,
        loan_term: 12
      )
    end
    let(:loan_profit) { create(:loan_profit, loan:)}


    let(:service) { LoanCalculatorService.new(loan) }

    it 'creates a loan profit with correct calculations' do
      service.call

      loan_profit = LoanProfit.last

      expect(loan_profit).to be_present
      expect(loan_profit.loan).to eq(loan)
      expect(loan_profit.max_loan_amount_purchase_price).to eq(loan.purchase_price * LoanCalculatorService::PURCHASE_PRICE_RATIO)
      expect(loan_profit.max_loan_amount_arv).to eq(loan.after_repair_value * LoanCalculatorService::ARV_RATIO)

      expected_loan_amount = [loan_profit.max_loan_amount_purchase_price, loan_profit.max_loan_amount_arv].min
      expect(loan_profit.loan_amount).to eq(expected_loan_amount)

      expected_estimated_profit = loan.after_repair_value - loan_profit.loan_amount - loan_profit.total_interest_expense
      expect(loan_profit.estimated_profit).to be_within(0.01).of(expected_estimated_profit)
    end
  end
end
