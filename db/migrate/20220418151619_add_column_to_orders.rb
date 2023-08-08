class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :step, :integer, null: false, default: 0
    add_column :orders, :email, :string
  end
end
