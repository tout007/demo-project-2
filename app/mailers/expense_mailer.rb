class ExpenseMailer < ApplicationMailer

  def cross_expense_limit_email
    @expense = params[:expense]
    mail(to: 'ayushy.tout@gmail.com', subject: "You have cross the expense limit!")
  end
end
