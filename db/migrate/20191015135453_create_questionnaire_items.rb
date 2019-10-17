class CreateQuestionnaireItems < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaire_items do |t|
      t.string :content, null: false
      t.integer :questionnaire_id, null: false

      t.timestamps
    end
    add_foreign_key :questionnaire_items, :questionnaires
  end
end
