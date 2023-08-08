class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status, null: false, default: 0

      t.string :name
      t.string :surname
      t.string :phone
      t.string :locality
      t.integer :delivery_service, null: false, default: 0
      t.integer :delivery_type, null: false, default: 0
      t.string :delivery_comment

      t.string :receiver_name
      t.string :receiver_surname
      t.string :receiver_phone

      t.string :number
      t.string :uid

      t.timestamps null: false
    end

    add_index :orders, :uid
    add_index :orders, :number
  end
end
