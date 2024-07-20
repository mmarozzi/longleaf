class LoanProfit < ApplicationRecord
  belongs_to :loan
  validates :max_loan_amount_purchase_price, :max_loan_amount_arv,
            :loan_amount, :total_interest_expense, :estimated_profit,
            presence: true, numericality: { greater_than_or_equal_to: 0 }

end
