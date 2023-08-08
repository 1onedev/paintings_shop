class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, index: true, foreign_key: true, null: false
      t.references :item, index: true, foreign_key: true, null: false

      t.float :price
      t.integer :count, default: 1, null: false

      t.timestamps null: false
    end
  end
end
