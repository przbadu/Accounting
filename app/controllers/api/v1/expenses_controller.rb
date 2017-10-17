class Api::V1::ExpensesController < Api::V1::BaseController
  before_action :set_expense, only: [:show, :update]

  def show
    render json: @expense
  end

  def create
    @expense = Plutus::Expense.new(expense_params)

    if @expense.save
      render json: @expense
    else
      error_response(@expense.errors, :unprocessable_entity)
    end
  end

  def update
    if @expense.update(expense_params)
      render json: @expense
    else
      error_response(@expense.errors, :unprocessable_entity)
    end
  end

  private

  def set_expense
    @expense = Plutus::Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name)
  end
end
