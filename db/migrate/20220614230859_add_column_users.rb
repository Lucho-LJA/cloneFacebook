class AddColumnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :img_auth, :string
    add_index :users, :username, unique: true
  end
end
