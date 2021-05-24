class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.text :description 
      t.integer :amount
      t.references :user, null: false, index: true
      t.string :images
      t.datetime :expended_at
      t.references :category, null: false, index: true

      t.timestamps
    end
  end
end
