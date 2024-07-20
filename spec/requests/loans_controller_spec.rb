# spec/requests/loans_controller_spec.rb

require 'rails_helper'

RSpec.describe LoansController, type: :request do
  describe 'GET #new' do
    it 'renders the new template' do
      get new_loan_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include('<form')
      expect(response.body).to include('Loan Term')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new loan and redirects to show page' do
        loan_params = {
          loan: {
            address: '123 Main St',
            loan_term: 6,
            purchase_price: 200000.0,
            repair_budget: 10000.0,
            after_repair_value: 250000.0,
            name: 'John Doe',
            email: 'john.doe@example.com',
            phone: '123-456-7890'
          }
        }

        expect {
          post loans_path, params: loan_params
        }.to change(Loan, :count).by(1)

        follow_redirect!

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Success profit calculation')
        expect(response.body).to include('john.doe@example.com')
      end
    end

    context 'with invalid params' do
      it 'renders new template with errors' do
        loan_params = {
          loan: {
            address: '',
            loan_term: 1,
            purchase_price: 0,
            repair_budget: 0,
            after_repair_value: 0,
            name: '',
            email: '',
            phone: ''
          }
        }

        post loans_path, params: loan_params

        expect(response).to redirect_to(new_loan_path)
        follow_redirect!

        expect(response.body).to include('Address can&#39;t be blank')
        expect(response.body).to include('Name can&#39;t be blank')
      end
    end
  end

  describe 'GET #show' do
    let!(:loan) { create(:loan) }
    let!(:loan_profit) { create(:loan_profit, loan:) }

    it 'renders the show template' do
      get loan_path(loan)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Success profit calculation')
      expect(response.body).to include(loan.email)
    end
  end
end
