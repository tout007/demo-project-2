class AddTokenFieldToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token, :string
    add_column :users, :token_expiry_at, :datetime
  end
end
