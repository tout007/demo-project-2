class Api::V1::ExpensesController < Api::V1::BaseController
    
  before_action :find_expense, only: [:show, :destroy, :update]

  def index
    @expenses = current_user.expenses
    render json: @expenses, status: 200 # OK
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      render json: @expense
    else
      render error: {error: 'Failed to add an expense'}, status: 400 
      # Bad Request (invalid request message)
    end
  end

  def destroy
    if @expense
      @expense.destroy
      render json: @expense, status: 200
    else
      render error: {error: 'Failed to delete an expense'}, status: 400
    end
  end

  def update
    if @expense
      @expense.update(expense_params)
      render json: @expense
    else
      render error: {error: 'Failed to update an expense'}, status: 400 
    end
  end

  def show
    render json: @expense
  end

  private
    def find_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.permit(:expended_at, :title, :description, :category_id, :user_id, :amount, bill_images: [])
    end
end