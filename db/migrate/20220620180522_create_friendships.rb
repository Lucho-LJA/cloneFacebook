class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :sent_to, null: false, foreign_key: true
      t.references :sent_by, null: false, foreign_key: true

      t.timestamps
    end
  end
end
