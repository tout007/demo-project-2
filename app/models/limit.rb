class Limit < ApplicationRecord
  belongs_to :user
  validates :monthly_limit, presence: true, numericality: true
end
