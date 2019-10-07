class AddDetailToSubEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :sub_events, :detail, :string
  end
end
