FactoryBot.define do
  factory :loan_profit do
    association :loan
    max_loan_amount_purchase_price { 100000.00 }
    max_loan_amount_arv { 70000.00 }
    loan_amount { 80000.00 }
    total_interest_expense { 5000.00 }
    estimated_profit { 15000.00 }
    purchase_price_ratio { 0.9 }
    arv_ratio { 0.7 }
    annual_interest_rate { 0.13 }
  end
end
