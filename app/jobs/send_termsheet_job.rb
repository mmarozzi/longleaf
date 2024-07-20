class SendTermsheetJob < ApplicationJob
  queue_as :default

  def perform(loan_id)
    loan = Loan.find(loan_id)
    pdf = LoanTermPdf.new(loan)
    pdf_path = Rails.root.join("tmp", "loan_term_#{loan.id}.pdf")
    pdf.render_file(pdf_path)

    TermsheetMailer.with(loan: loan, pdf_path: pdf_path).termsheet_email.deliver_now
  end
end
