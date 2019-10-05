class CreateBookMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :book_marks do |t|
      t.integer :user_id
      t.integer :history_id

      t.timestamps
    end
  end
end
