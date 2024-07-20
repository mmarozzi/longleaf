# frozen_string_literal: true

FactoryBot.define do
  factory :loan do
    address { "123 Main St" }
    loan_term { 6 }
    purchase_price { 100000.00 }
    repair_budget { 20000.00 }
    after_repair_value { 150000.00 }
    name { "John Doe" }
    email { "john@example.com" }
    phone { "123-456-7890" }
  end
end