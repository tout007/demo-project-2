class LimitSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :month_at, :monthly_limit
end
