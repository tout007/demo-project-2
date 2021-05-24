class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses
  has_one :limit
  has_one_attached :image

  after_create :send_email_to_signup!

  after_initialize :init
 
  enum role: %w[user admin]
  enum gender: %w[male female] 

  validates :name, presence: true, format: {with: /\A[a-zA-Z]+\z/ }
  
  def authenticate(param_password)
    password == param_password
  end 

  def init
    self.active ||= true   # it will set the default value only if it's nil
    self.role   ||= 0
  end 

  def total_expense(interval = 'all')
    case interval
      when 'month'
        expenses.where('expended_at BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month).sum(:amount) 
      when 'day'
        expenses.where('expended_at BETWEEN ? AND ?', Date.current.beginning_of_day, Date.current.end_of_day).sum(:amount)
      when 'all'      
        expenses.sum(:amount) 
    end 
  end 
  
  # check monthly monthly limit is crossed by user 
  def monthly_limit_cross?
    total_expense('month') > limit.monthly_limit.to_i
  end

  # to get recently added expenses
  def recent_expenses
    expenses.where('expended_at BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month).order(expended_at: :desc).limit(5) 
  end
  
  # send email to user at signup first time
  def send_email_to_signup!
    SignupMailer.with(user: self).signup_email.deliver_now  
  end       
end
