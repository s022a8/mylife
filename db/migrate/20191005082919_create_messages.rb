class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_foreign_key :messages, :users
    add_foreign_key :messages, :rooms
  end
end
