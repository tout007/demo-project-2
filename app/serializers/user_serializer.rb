class UserSerializer < ActiveModel::Serializer
  has_one :limit
  has_many :expenses 
  attributes :name, :gender, :city, :gender
  # attribute :role, if: :role_admin?
end

  # def is_admin?
  #   user = scope.current_user
  #   if user.role == 'admin'
  #     attributes :email, :active
  #   end
  # end

  # def role_admin?
  #   if current_user.admin?
  #     attributes :email, :active
  #   end
  # end

  # def current_user
  #   scope
  # end

  # def include_email?
  #   object == current_user
  # end

