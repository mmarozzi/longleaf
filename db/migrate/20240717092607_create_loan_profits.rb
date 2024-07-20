class CreateLoanProfits < ActiveRecord::Migration[7.2]
  def change
    create_table :loan_profits do |t|
      t.references :loan, null: false, foreign_key: true
      t.decimal :max_loan_amount_purchase_price
      t.decimal :max_loan_amount_arv
      t.decimal :loan_amount
      t.decimal :total_interest_expense
      t.decimal :estimated_profit
      t.decimal :purchase_price_ratio, default: 0.9
      t.decimal :arv_ratio, default: 0.7
      t.decimal :annual_interest_rate, default: 0.13

      t.timestamps
    end
  end
end
