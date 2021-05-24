class ExpensesController < ApplicationController
  before_action :set_expense, only: [:edit, :update, :destroy]

  def add_expense
    @expense = Expense.new
    show_pop_up    
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    if @expense.save
      redirect_to expenses_path,
      notice: "Successfully added"
    end 
  end
  
  def edit
  end

  def update                            
    if @expense.update(expense_params)
      redirect_to expenses_path
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    @expenses = current_user.expenses.all.order(expended_at: :desc)
    flash[:alert] = 'Expense removed successfully'
  end

  def index
    @pagy, @expenses = pagy(current_user.expenses.all.order(created_at: :desc),  items: 1)
    # @expenses = current_user.recent_expenses
    #@expenses = current_user.expenses.all.order(expended_at: :desc)
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:title, :amount, :expended_at, :category_id, :user_id, :description, bill_images: [])
    end
   
end
