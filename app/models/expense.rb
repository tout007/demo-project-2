class Expense < ApplicationRecord
  before_save :send_mail_on_overlimit!

  belongs_to :user
  belongs_to :category
  has_many_attached :bill_images

  validates :category_id, presence: true 
  validates :amount, presence: true, numericality: true
  validates :title, presence: true, length: { minimum: 4 }

  def send_mail_on_overlimit!
    if user.monthly_limit_cross? && amount_changed?
      ExpenseMailer.with(expense: self).cross_expense_limit_email.deliver_now  
    end
  end
end
