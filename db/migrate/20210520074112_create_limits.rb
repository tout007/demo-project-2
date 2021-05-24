class CreateLimits < ActiveRecord::Migration[6.1]
  def change
    create_table :limits do |t|
      t.integer :monthly_limit
      t.integer :daily_limit
      t.references :user, null: false, index: true
      t.string :month_at

      t.timestamps
    end
  end
end
