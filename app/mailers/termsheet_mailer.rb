class TermsheetMailer < ApplicationMailer
  def termsheet_email
    @loan = params[:loan]
    attachments.inline["longleaf.png"] = File.read("#{Rails.root}/app/assets/images/longleaf.png")

    attachments["termsheet_#{@loan.id}.pdf"] = File.read(params[:pdf_path])
    mail(to: @loan.email, subject: "Your Loan Termsheet from Longleaf Lending")
  end
end
