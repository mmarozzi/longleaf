class CreateLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :loans do |t|
      t.string :address
      t.integer :loan_term
      t.decimal :purchase_price
      t.decimal :repair_budget
      t.decimal :after_repair_value
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
