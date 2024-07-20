require 'rails_helper'

RSpec.describe SendTermsheetJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    let!(:loan) { create(:loan) }
    let!(:loan_profit) { create(:loan_profit, loan:) }

    it 'generates and sends a termsheet PDF' do
      perform_enqueued_jobs do
        SendTermsheetJob.perform_later(loan.id)
      end

      expect(ActionMailer::Base.deliveries.count).to eq(1)

      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.subject).to include('Your Loan Termsheet from Longleaf Lending') # Verifica el asunto del correo
    end
  end
end
