class CreateLoanService
  attr_reader :errors, :loan
  def initialize(data)
    @data = data
    @errors = []
  end

  def call
    @loan = Loan.new(data)
    ActiveRecord::Base.transaction do
      @loan.save!
      create_loan_profit!(@loan)
    rescue ActiveRecord::RecordInvalid => e
      @errors = e.record.errors.full_messages
      @errors << e.message if @errors.blank?
      raise ActiveRecord::Rollback
    rescue ActiveRecord::Rollback
      @errors << "Error something went wrong"
    end
    @errors.blank?
  end

  private

  attr_reader :data

  def create_loan_profit!(loan)
    service = LoanCalculatorService.new(loan)
    service.call
  end
end
