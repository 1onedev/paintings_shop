class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :material, :integer, null: false, default: 0
  end
end
