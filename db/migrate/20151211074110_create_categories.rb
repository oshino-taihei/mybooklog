class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :user_id
      t.string :category_name

      t.timestamps null: false
    end
    
    add_index :categories, [:user_id, :category_name], unique: true
  end
end
