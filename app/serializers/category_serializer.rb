class CategorySerializer < ActiveModel::Serializer

  has_many :expenses
  
  attributes :name
end
