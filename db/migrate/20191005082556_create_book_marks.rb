class CreateBookMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :book_marks do |t|
      t.integer :user_id, null: false
      t.integer :history_id, null: false

      t.timestamps
    end

    add_foreign_key :book_marks, :users
    add_foreign_key :book_marks, :histories
  end
end
