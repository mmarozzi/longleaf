class LoanCalculatorService
  PURCHASE_PRICE_RATIO = 0.9
  ARV_RATIO = 0.7
  ANNUAL_INTEREST_RATE = 0.13

  def initialize(loan)
    @loan = loan
  end

  def call
    LoanProfit.create!(
      loan:,
      loan_amount:,
      total_interest_expense:,
      estimated_profit:,
      max_loan_amount_purchase_price: max_loan_amount_by_purchase_price,
      max_loan_amount_arv: max_loan_amount_by_arv,
      purchase_price_ratio: PURCHASE_PRICE_RATIO,
      arv_ratio: ARV_RATIO,
      annual_interest_rate: ANNUAL_INTEREST_RATE
    )
  end

  private

  attr_reader :loan

  def max_loan_amount_by_purchase_price
    loan.purchase_price * PURCHASE_PRICE_RATIO
  end

  def max_loan_amount_by_arv
    loan.after_repair_value * ARV_RATIO
  end

  def loan_amount
    [ max_loan_amount_by_purchase_price, max_loan_amount_by_arv ].min
  end

  def monthly_interest_rate
    ANNUAL_INTEREST_RATE / 12.0
  end

  def total_interest_expense
    monthly_interest_rate * loan_amount * loan.loan_term
  end

  def estimated_profit
    loan.after_repair_value - loan_amount - total_interest_expense
  end
end
