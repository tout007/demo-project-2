class UserSerializer < ActiveModel::Serializer
  
  has_many :expenses 
  attributes :name, :gender, :city, :gender

  def admin?
    if current_user.admin?
      attributes :id, :name, :email, :gender, :city, :gender, :active, :block
    end
  end

end
