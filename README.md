## README

#### Project Overview

This project is an in-house lead generation form and profit calculator for Longleaf Lending, developed to replace third-party applications such as Typeform and Zapier. The form collects user inputs, calculates estimated profits, and generates a termsheet PDF that is emailed to the user.

### Model Design

The project consists of two main models:

1. **Loan**: This model captures the details of the loan application.
   - Attributes: `address`, `loan_term`, `purchase_price`, `repair_budget`, `after_repair_value`, `name`, `email`, `phone`.

   ```ruby
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
   ```
2. **LoanProfit**: This model stores the calculated profit details.
   - Attributes: `loan_id`, `max_loan_amount_purchase_price`, `max_loan_amount_arv`, `loan_amount`, `total_interest_expense`, `estimated_profit`, `purchase_price_ratio`, `arv_ratio`, `annual_interest_rate`.
   ```ruby
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
   ```
### Form Design
The form is designed to be extensible, allowing for easy addition of new fields or modification of existing ones. It collects the following details:

- Address
- Loan term (in months)
- Purchase price
- Repair budget
- After repair value (ARV)
- Name
- Email
- Phone


### Extensibility
The form and models are designed to be easily extensible. You can add or modify fields in the models and form as needed without affecting the existing functionality. The calculations and PDF generation are handled in separate services, making the system modular and maintainable.

### Development Setup
To set up the project for development, follow these steps:

1. **Clone the repository:**
```
git clone https://github.com/your-repo/longleaf-lending.git
cd longleaf-lending
```

2. **Install dependencies:**
```
bundle install
```

3. **Set up the database:**
```
rails db:create
rails db:migrate
```
4. **Run the Rails server:**
```
rails server
```
5. Open your browser and navigate to [http://localhost:3000](http://localhost:3000) to see the application in action.

## Notes

Why was the LoanProfit model created?
Calculations can be performed using only the Loan model, but by creating the LoanProfit model, we can store the results and interest rates at the time of sending the email. This ensures that if these values change over time, we can always perform analysis or other operations using the actual values.