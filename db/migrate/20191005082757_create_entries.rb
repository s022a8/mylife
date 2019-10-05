class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false

      t.timestamps
    end

    add_foreign_key :entries, :users
    add_foreign_key :entries, :rooms
  end
end
