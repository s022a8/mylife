class CreateQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaires do |t|
      t.string :theme, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_foreign_key :questionnaires, :users
  end
end
