class HomeController < ApplicationController
 
  def index
  end

  def welcome
    # To get category wise expenses
    if(current_user.expenses == [])
      flash.now[:alert] = "No Expenses at yet"
    else 
      expense = @current_user.expenses.group(:category).sum(:amount).to_a.map { |x| [ x[0].name, x[1] ] }
      title = ['Category', 'Amount']
      @data = [title] + expense
     
      # To get date wise expenses # map{ |k, v| [x: k.strftime('%v'), y: v] }
      datewise_expense = current_user.expenses.group(:expended_at).sum(:amount).to_a.map{ |k,v| [ k.strftime('%v'), v ] }
      head = ['Date', 'Amount'] 
      @datewise_expenses = [head] + datewise_expense

      # TO get sum of current user monthly expense
      @total_expense = current_user.total_expense('month').to_i
      @expense_limit = current_user.limit.monthly_limit.to_i
      
      @remaining_amount = @expense_limit - @total_expense
    end
  end
end
  