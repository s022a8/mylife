class CreateSubEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_events do |t|
      t.integer :history_id, null: false
      t.string :part, null: false

      t.timestamps
    end
  end
end
