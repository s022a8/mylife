class CreateUsersQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :users_questionnaires do |t|
      t.integer :point, null: false, default: 0
      t.integer :user_id, null: false
      t.integer :questionnaire_item_id, null: false

      t.timestamps
    end
    add_foreign_key :users_questionnaires, :users
    add_foreign_key :users_questionnaires, :questionnaires
  end
end
