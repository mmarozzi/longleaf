require "prawn"

class LoanTermPdf
  include Prawn::View

  def initialize(loan)
    @loan = loan
    @loan_profit = loan.loan_profit
    generate_pdf
  end

  private

  attr_reader :loan, :loan_profit

  def generate_pdf
    logo
    title
    loan_details
    profit_details
  end

  def logo
    image "#{Rails.root}/app/assets/images/longleaf.png", width: 115
  end

  def title
    text "Loan Profit", size: 24, style: :bold, align: :center
    move_down 20
  end

  def loan_details
    subtitle("Loan Details")
    move_down 10
    text_key_value("Address", loan.address)
    move_down 5
    text_key_value("Loan Term (in months)", loan.loan_term)
    move_down 5
    text_key_value("Purchase Price", formated_number(loan.purchase_price))
    move_down 5
    text_key_value("Repair Budget", formated_number(loan.repair_budget))
    move_down 5
    text_key_value("After Repair Value (ARV)", formated_number(loan.after_repair_value))
    move_down 5
    text_key_value("Name", loan.name)
    move_down 5
    text_key_value("Email", loan.email)
    move_down 5
    text_key_value("Phone", loan.phone)
    move_down 20
  end

  def profit_details
    subtitle("Loan Profit Details")
    move_down 10

    text_key_value("Max Loan Amount by Purchase Price", formated_number(loan_profit.max_loan_amount_purchase_price))
    move_down 5
    text_key_value("Max Loan Amount by ARV", formated_number(loan_profit.max_loan_amount_arv))
    move_down 5
    text_key_value("Loan Amount", formated_number(loan_profit.loan_amount))
    move_down 5
    text_key_value("Total Interest Expense", formated_number(loan_profit.total_interest_expense))
    move_down 5
    text_key_value("Estimated Profit", formated_number(loan_profit.estimated_profit))
    move_down 20
  end

  def text_key_value(key, value)
    indent(15) do
      text "<b>#{key}</b>: #{value}", size: 12, inline_format: true
    end
  end

  def subtitle(value)
    fill_color "ADB49C"
    fill_rectangle [ bounds.left, cursor + 7 ], bounds.right, 25
    fill_color "000000"
    indent(10) do
      text value, size: 16, style: :bold
    end
  end

  def formated_number(number)
    "%.2f" % number
  end
end
