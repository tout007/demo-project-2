# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      # Database authenticatable: responsible for hashing the passsword & validating the authenticity
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.string :city
      t.integer :gender
      t.integer :role, default: 0, null: false
      t.boolean :active, default: true, null: false   
      t.boolean :block, default: false, null: false

      # Recoverable: Reset user password & send reset instructions
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable: generate & clean token for remembering the user from cookie 
      t.datetime :remember_created_at

      # Trackable: track signin count, timestamp & IP address
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Confirmable: send email with confiration instruction & verify a/c whether it is already confirmed during signed_in
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      # Lockable: Locks an a/c after specified no. of failed signin attempts.  
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
