class HomeController < ApplicationController
 
  def index
  end

  def welcome
    # To get category wise expenses
    if(!current_user.expenses.present?)
      flash.now[:alert] = "No Expenses at yet"
    else 
      expense = current_user.sum_of_category_expense
      title = ['Category', 'Amount']
      @data = [title] + expense
     
      datewise_expense = current_user.expenses.group(:expended_at).sum(:amount).to_a.map{ |k,v| [ k.strftime('%v'), v ] }
      head = ['Date', 'Amount'] 
      @datewise_expenses = [head] + datewise_expense
  
      # TO get sum of current user monthly expense
      @total_expense = current_user.total_expense('month').to_i
      @expense_limit = current_user.limit&.monthly_limit.to_i
      
      @remaining_amount = @expense_limit - @total_expense

      @recent_expenses = current_user.recent_expenses
    end
  end
end
  