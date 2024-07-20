class Loan < ApplicationRecord
  has_one :loan_profit, dependent: :destroy
  validates :address, :loan_term, :purchase_price, :repair_budget,
            :after_repair_value, :name, :email, :phone, presence: true

  validates :loan_term, inclusion: { in: 1..12 }
  validates :purchase_price, numericality: { greater_than_or_equal_to: 0 }
  validates :repair_budget, numericality: { greater_than_or_equal_to: 0 }
  validates :after_repair_value, numericality: { greater_than_or_equal_to: 0 }
end
