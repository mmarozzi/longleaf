class LoansController < ApplicationController
  before_action :set_loan, only: %i[show]
  def new
    @loan = Loan.new(
      loan_term: 1,
      purchase_price: 0,
      repair_budget: 0,
      after_repair_value: 0
    )
  end

  def create
    service = CreateLoanService.new(loan_params)
    if service.call
      @loan = service.loan
      SendTermsheetJob.perform_later(@loan.id)
      redirect_to loan_path(@loan)
    else
      flash[:error] = service.errors
      redirect_to new_loan_path
    end
  end

  def show; end

  private

  def loan_params
    params.require(:loan).permit(%i[address loan_term purchase_price repair_budget
                                    after_repair_value name email phone])
  end

  def set_loan
    @loan = Loan.find(params[:id])
  end
end
