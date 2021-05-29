class ExpenseSerializer < ActiveModel::Serializer
  belongs_to :category
  attributes :amount,:expended_at, :title, :category
  # belongs_to :user, serializer: UserSerializer
end
