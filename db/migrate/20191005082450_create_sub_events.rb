class CreateSubEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_events do |t|
      t.integer :history_id
      t.string :part

      t.timestamps
    end
  end
end
