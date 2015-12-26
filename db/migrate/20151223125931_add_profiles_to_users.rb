class AddProfilesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :description, :text

    add_index :users, :name, unique: true
  end
end
