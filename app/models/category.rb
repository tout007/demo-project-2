class Category < ApplicationRecord
  has_many :expenses, dependent: :destroy

  after_initialize :init

  VALID_NAME_REGEX = /\A[a-zA-Z]+\z/
  validates :name, uniqueness: true, format: { with: VALID_NAME_REGEX,
    message: "only allows letters" }

  def init
    self.active ||= true  #will set the default value only if it's nil 
  end  

end
