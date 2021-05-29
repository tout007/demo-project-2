class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  before_create :generate_token

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # , :trackable, :validatable, :confirmable

  has_one :limit
  has_one_attached :image
  has_many :expenses
  
  #facts
  has_many :facts

  after_create :send_email_to_signup!
  after_initialize :init
 
  enum role: %w[user admin]
  enum gender: %w[male female] 

  validates :name, presence: true, format: {with: /\A[a-zA-Z]+\z/ }
  
  def authenticate(param_password)
    password == param_password
  end 

  def init
    self.active ||= true # it will set the default value only if it's nil
    self.role   ||= 0
  end 

  def total_expense(interval = 'all')
    case interval
      when 'month' # To get sum of month expenses          
        expenses.where('expended_at BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month).sum(:amount) 
      when 'day'# To get sum of day expenses
        expenses.where('expended_at BETWEEN ? AND ?', Date.current.beginning_of_day, Date.current.end_of_day).sum(:amount)
      when 'all'      
        expenses.sum(:amount) 
    end 
  end 
  
  # check monthly monthly limit is crossed by user 
  def monthly_limit_cross?
    total_expense('month') > limit&.monthly_limit.to_i
  end

  # to get recently added expenses
  def recent_expenses
    expenses.where('expended_at BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month).order(expended_at: :desc).limit(5) 
  end
  
  # To get total sum of category wise expense
  def sum_of_category_expense
    expenses.group(:category).sum(:amount).to_a.map { |x| [ x[0].name, x[1] ] }
  end

  # To get list of monthly expenses 
  def monthly_expenses
    expenses.group(:expended_at).sum(:amount).to_a.map{ |k,v| [ k.strftime('%v'), v ] }
  end

  # send email to user at signup first time
  def send_email_to_signup!
    SignupMailer.with(user: self).signup_email.deliver_now  
  end   

  # protected
   
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
  end
end

  # def set_auth_token
  #    return if auth_token.present?
  #    self.auth_token = generate_auth_token
  #  end

  #  def generate_auth_token
  #    SecureRandom.uuid.gsub(/\-/,'')
  #  end
