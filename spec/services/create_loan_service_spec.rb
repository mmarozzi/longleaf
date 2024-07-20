# spec/services/create_loan_service_spec.rb

require 'rails_helper'

RSpec.describe CreateLoanService do
  describe '#call' do
    let(:valid_data) do
      {
        address: '123 Main St',
        loan_term: 12,
        purchase_price: 200000.0,
        repair_budget: 50000.0,
        after_repair_value: 300000.0,
        name: 'John Doe',
        email: 'john@example.com',
        phone: '1234567890'
      }
    end

    let(:invalid_data) do
      valid_data.merge(address: nil)
    end

    context 'when data is valid' do
      it 'creates a loan and loan profit' do
        service = CreateLoanService.new(valid_data)

        expect(LoanCalculatorService).to receive(:new).and_call_original

        expect { service.call }.to change(Loan, :count).by(1)
          .and change(LoanProfit, :count).by(1)

        expect(service.errors).to be_empty
        expect(service.loan).to be_persisted
      end
    end

    context 'when data is invalid' do
      it 'does not create a loan or loan profit and adds errors' do
        service = CreateLoanService.new(invalid_data)

        expect { service.call }.not_to change(Loan, :count)
        expect { service.call }.not_to change(LoanProfit, :count)

        expect(service.errors).not_to be_empty
      end
    end

    context 'when LoanCalculatorService raises an error' do
      it 'does not create a loan profit and adds errors' do
        allow(LoanProfit).to receive(:create!).and_raise(ActiveRecord::RecordInvalid.new(LoanProfit.new))

        service = CreateLoanService.new(valid_data)

        expect { service.call }.not_to change(Loan, :count)
        expect { service.call }.not_to change(LoanProfit, :count)

        expect(service.errors).not_to be_empty
        expect(service.errors).to include('Validation failed: ')
      end
    end
  end
end
