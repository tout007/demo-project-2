class Api::V1::ExpensesController < Api::V1::BaseController
    
  before_action :find_expense, only: [:show, :destroy, :update]

  def index
    render json: UserSerializer.new(current_user).serializable_hash
  end

  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      render json: @expense, status: 200
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
      render json: @expense,  status: 200
    else
      render error: {error: 'Failed to update an expense'}, status: 400 
    end
  end

  def show
    render json: ExpenseSerializer.new(@expense).serializable_hash
  end

  def categories_graph
    # render json: CategorySerializer.new(current_user).serializable_hash
    expense = current_user.sum_of_category_expense
    title = ['Category', 'Amount']
    @data = [title] + expense
    render json: @data
  end

  def line_graph
    # render json: current_user.monthly_expenses.to_json
    datewise_expense = current_user.monthly_expenses
    head = ['Date', 'Amount'] 
    @datewise_expenses = [head] + datewise_expense
    render json: @datewise_expenses
  end

  private
    def find_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.permit(:expended_at, :title, :description, :category_id, :user_id, :amount, bill_images: [])
    end
end