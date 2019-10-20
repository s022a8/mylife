class AddIsReadToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :is_read, :boolean, null: false, default: false
  end
end
