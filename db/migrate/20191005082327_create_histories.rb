class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :user_id, null: false
      t.integer :age, null: false
      t.string :event, null: false
      t.integer :barometer, null: false, default: 50

      t.timestamps
    end

    add_foreign_key :histories, :users
  end
end
