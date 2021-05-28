class ExpenseSerializer < ActiveModel::Serializer
  belongs_to :category
  belongs_to :user
  attributes :amount,:expended_at, :title, :category
end
