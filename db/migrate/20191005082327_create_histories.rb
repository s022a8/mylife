class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :age
      t.string :event
      t.integer :barometer

      t.timestamps
    end
  end
end
